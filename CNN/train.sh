# Finetuning the model

# pls refer to fairseq documentaion to know more about each of these options (https://fairseq.readthedocs.io/en/latest/command_line_tools.html)


# some notable args:
# --user_dir            -> we define the custom transformer arch in model_configs folder and pass it as an argument to user_dir for fairseq to register this architechture
# --lr                  -> learning rate. From our limited experiments, we find that lower learning rates like 3e-5 works best for finetuning.
# --restore-file        -> reload the pretrained checkpoint and start training from here (change this path for indic-en. Currently its is set to en-indic)
# --reset-*             -> reset and not use lr scheduler, dataloader, optimizer etc of the older checkpoint
# --max_tokns           -> this is max tokens per batch


( CUDA_VISIBLE_DEVICES=0 fairseq-train ../../data/final_bin \
--max-epoch=25 \
--arch=fconv \
--criterion=label_smoothed_cross_entropy \
--source-lang=SRC \
--target-lang=TGT \
--label-smoothing=0.1 \
--optimizer adam \
--adam-betas "(0.9, 0.98)" \
--clip-norm 1.0 \
--warmup-init-lr 1e-07 \
--warmup-updates 4000 \
--dropout 0.2 \
--lr-scheduler=inverse_sqrt \
--lr 3e-5 \
--tensorboard-logdir ../../../tmp/tensorboard-wandb \
--save-dir ../../drive/MyDrive/Dravidian_Dataset_Full/model \
--skip-invalid-size-inputs-valid-test \
--fp16 \
--user-dir model_configs \
--update-freq=2 \
--distributed-world-size 1 \
--max-tokens 576 \
--eval-bleu \
--eval-bleu-args "{\"beam\": 5, \"max_len_a\": 1.2, \"max_len_b\": 10}" \
--eval-bleu-detok moses \
--eval-bleu-remove-bpe \
--eval-bleu-print-samples \
--best-checkpoint-metric bleu \
--maximize-best-checkpoint-metric \
--no-epoch-checkpoints )
