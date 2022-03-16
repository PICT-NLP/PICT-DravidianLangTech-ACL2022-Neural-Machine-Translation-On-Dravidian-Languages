# for generating the translations in the cli itself.
# would return the corresponding sacrebleu metric for the translations.

fairseq-generate /content/nmt-kn-ml/tokenized.kn-ml \
  --path checkpoints/checkpoint_best.pt \
  --beam 5 \
  --remove-bpe