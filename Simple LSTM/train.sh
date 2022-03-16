# for training the LSTM model
# train after you have done the preprocessing by running preprocess.sh

( CUDA_VISIBLE_DEVICES=0 fairseq-train /content/nmt-kn-ml/tokenized.kn-ml \
--arch lstm \
  --dropout 0.2 \
  --optimizer adam --lr 0.005 --lr-shrink 0.5 \
  --max-tokens 12000 \
  --max-epoch 25 \
  --wandb-project "Simple LSTM - kn to ml - 5 March 2022" )
  