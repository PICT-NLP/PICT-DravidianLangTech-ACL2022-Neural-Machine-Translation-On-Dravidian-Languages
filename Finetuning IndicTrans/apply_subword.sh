cp -r ../../data/kn-ta/norm/* ../../data/kn-ta/data/

exp_dir=../../data/kn-ta
download_dir=../m2m
# use the vocab from downloaded dir
cp -r $download_dir/vocab $exp_dir
mv $download_dir/vocab/bpe_codes.32k.SRC_TGT $download_dir/vocab/bpe_codes.32k.SRC 
cp -r $download_dir/vocab $exp_dir
mv $download_dir/vocab/bpe_codes.32k.SRC_TGT $download_dir/vocab/bpe_codes.32k.TGT

echo "Applying bpe to the new finetuning data"
bash apply_single_bpe_traindevtest_notag.sh $exp_dir

mkdir -p $exp_dir/final