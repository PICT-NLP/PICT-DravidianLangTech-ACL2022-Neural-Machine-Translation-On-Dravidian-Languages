# for training the BiLSTM model
# before training, make sure to delete the lstm.py file in the fairseq/fairseq/models/ folder after you clone fairseq, and replace the same with the lstm.py file in the repo folder given
# changes have been made accordingly for training the BiLSTM.
# train after you have done the preprocessing by running preprocess.sh

( CUDA_VISIBLE_DEVICES=0 fairseq-train /content/nmt-kn-ml/tokenized.kn-ml \
--arch lstm \
  --dropout 0.2 \
  --optimizer adam --lr 0.005 --lr-shrink 0.5 \
  --max-tokens 12000 \
  --max-epoch 25 \
  --wandb-project "BiLSTM model - kn to ml - 6 March 2022" )
