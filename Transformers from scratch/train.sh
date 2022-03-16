# for training the LSTM model
# train after you have done the preprocessing by running preprocess.sh

( CUDA_VISIBLE_DEVICES=0 fairseq-train nmt-kn-ml/tokenized.kn-ml \
--arch transformer \
--dropout 0.1 \
--attention-dropout 0.1 \
--activation-dropout 0.1 \
--encoder-embed-dim 256 \
--encoder-ffn-embed-dim 512 \
--encoder-layers 3 \
--encoder-attention-heads 8 \
--encoder-learned-pos \
--decoder-ffn-embed-dim 512 \
--decoder-layers 3 \
--decoder-attention-heads 8 \
--decoder-learned-pos \
--max-epoch 10 \
--optimizer adam \
--lr 5e-4 \
--batch-size 128 \
--seed 1 \
--wandb-project "Transformer from scratch - 10 March - kn to ml" )
  