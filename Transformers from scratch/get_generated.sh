# for getting the detokenized translations, which are the detokenized form of the translations obtained from the source test data (test.kn) .
# these are the generated translations, which are detokenized using remove-bpe.

fairseq-generate /content/nmt-kn-ml/tokenized.kn-ml \
  --path /content/checkpoints/checkpoint_best.pt \
  --beam 5 \
  --remove-bpe \
 | grep ^H | LC_ALL=C sort -V | cut -f3- > test_ml_generated_scratch_transformer.txt  