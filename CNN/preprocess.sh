exp_dir=../../data/kn-ml
download_dir=../m2m
data_dir=$exp_dir/final
out_data_dir=$exp_dir/final_bin

rm -rf $out_data_dir

# binarizing the new data (train, dev and test) using dictionary from the download dir

 num_workers=`python -c "import multiprocessing; print(multiprocessing.cpu_count())"`

data_dir=$exp_dir/final
out_data_dir=$exp_dir/final_bin

# rm -rf $out_data_dir

echo "Binarizing data. This will take some time depending on the size of finetuning data"
fairseq-preprocess --source-lang SRC --target-lang TGT \
 --trainpref $data_dir/train --validpref $data_dir/dev --testpref $data_dir/test \
 --destdir $out_data_dir --workers $num_workers \
 --srcdict $download_dir/final_bin/dict.SRC.txt --tgtdict $download_dir/final_bin/dict.TGT.txt --thresholdtgt 5 --thresholdsrc 5