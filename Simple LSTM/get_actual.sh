# for getting the detokenized translations, which are the detokenized form of test.ml .
# these are the actual original translations, which are detokenized using remove-bpe.

fairseq-generate /content/content/nmt-kn-ml/tokenized.kn-ml \
  --path /content/checkpoints/checkpoint_best.pt \
  --beam 5 \
   --remove-bpe \
  | grep ^T | LC_ALL=C sort -V | cut -f2- > test_ml_actual_Simple_LSTM.txt 