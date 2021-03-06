#!/bin/bash

# code for data preparation

# tokenization with the help of moses tokenizer
MOSES_GIT_URL=${MOSES_GIT_URL:-https://github.com/moses-smt/mosesdecoder.git}
# applying subword
SUBWORD_GIT_URL=${SUBWORD_GIT_URL:-https://github.com/rsennrich/subword-nmt.git}

SEQ2SEQ_GIT_URL=${SEQ2SEQ_GIT_URL:-https://github.com/google/seq2seq.git}

# applying preprocessing
MOSES_TOKENIZER=${MOSES_SCRIPT:-mosesdecoder/scripts/tokenizer/tokenizer.perl}
MOSES_CLEAN=${MOSES_CLEAN:-mosesdecoder/scripts/training/clean-corpus-n.perl}
VOCAB_SKRIPT=${VOCAB_SKRIPT:-seq2seq/bin/tools/generate_vocab.py}

LEARN_BPE_SKRIPT=${LEARN_BPE_SKRIPT:-subword-nmt/learn_bpe.py}
APPLY_BPE_SKRIPT=${APPLY_BPE_SKRIPT:-subword-nmt/apply_bpe.py}
GET_VOCAB_SKRIP=${GET_VOCAB_SKRIP:-subword-nmt/get_vocab.py}
NUM_THREADS=${NUM_THREADS:-8}
PERL=${PERL:-perl}
PYTHON=${PYTHON:-python}

# for deciding the source and target corpus (you can change the extensions accordingly)
SOURCE=corpus.kn
TARGET=corpus.ml

cp $1 $SOURCE
cp $2 $TARGET

if [ "$#" -ne 2 ]; then
  echo "Source and target files must be passed"
  exit 1
fi

if [ ! -d "mosesdecoder" ]; then
  git clone ${MOSES_GIT_URL}
fi

if [ ! -d "subword-nmt" ]; then
  git clone ${SUBWORD_GIT_URL}
fi

if [ ! -d "seq2seq" ]; then
  git clone ${SEQ2SEQ_GIT_URL}
fi

cat $SOURCE | ${PERL} ${MOSES_TOKENIZER} -threads ${NUM_THREADS} -l sk > $SOURCE.tok
cat $TARGET | ${PERL} ${MOSES_TOKENIZER} -threads ${NUM_THREADS} -l ml > $TARGET.tok

mv $SOURCE.tok $SOURCE
mv $TARGET.tok $TARGET

${PERL} ${MOSES_CLEAN} corpus kn ml "corpus.clean" 1 500

${PYTHON} ${VOCAB_SKRIPT} --max_vocab_size 50000 < corpus.clean.ml > vocab.50k.ml
${PYTHON} ${VOCAB_SKRIPT} --max_vocab_size 50000 < corpus.clean.kn > vocab.50k.kn

# Learn Shared BPE
for merge_ops in 32000; do
  echo "Learning BPE with merge_ops=${merge_ops}. This may take a while..."
  cat "corpus.clean.kn" "corpus.clean.ml" | \
    ${PYTHON} ${LEARN_BPE_SKRIPT} -s $merge_ops > "bpe.${merge_ops}"

  echo "Apply BPE with merge_ops=${merge_ops} to tokenized files..."
  for lang in ml kn; do
    for f in "corpus.${lang}" "corpus.clean.${lang}"; do
      outfile="${f%.*}.bpe.${merge_ops}.${lang}"
      ${PYTHON} ${APPLY_BPE_SKRIPT} -c "bpe.${merge_ops}" < $f > "${outfile}"
      echo ${outfile}
    done
  done

  # Create vocabulary file for BPE
  cat "corpus.clean.bpe.32000.ml" "corpus.clean.bpe.32000.kn" | \
    ${PYTHON} ${GET_VOCAB_SKRIP} | cut -f1 -d ' ' > "vocab.bpe.${merge_ops}"
done
