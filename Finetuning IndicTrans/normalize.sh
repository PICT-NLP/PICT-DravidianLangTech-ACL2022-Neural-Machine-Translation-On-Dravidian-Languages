# all the data preparation happens in this cell
%%shell

exp_dir=../../data/kn-ta
src_lang=kn
tgt_lang=indic

download_dir=../m2m/

train_data_dir=$exp_dir/train
dev_data_dir=$exp_dir/dev
test_data_dir=$exp_dir/test


echo "Running experiment ${exp_dir} on ${src_lang} to ${tgt_lang}"


train_processed_dir=$exp_dir/data
devtest_processed_dir=$exp_dir/data

out_data_dir=$exp_dir/final_bin

mkdir -p $train_processed_dir
mkdir -p $devtest_processed_dir
mkdir -p $out_data_dir

langs=(ta)

for lang in ${langs[@]};do
	if [ $src_lang == kn ]; then
		tgt_lang=$lang
	else
		src_lang=$lang
	fi

	train_norm_dir=$exp_dir/norm/$src_lang-$tgt_lang
	devtest_norm_dir=$exp_dir/norm/$src_lang-$tgt_lang
	mkdir -p $train_norm_dir
	mkdir -p $devtest_norm_dir


    # preprocessing pretokenizes the input 
    # after pretokenization, we use indicnlp to transliterate all the indic data to devnagiri script

	# train preprocessing
	train_infname_src=$train_data_dir/train.$src_lang
	train_infname_tgt=$train_data_dir/train.$tgt_lang
	train_outfname_src=$train_norm_dir/train.$src_lang
	train_outfname_tgt=$train_norm_dir/train.$tgt_lang
	echo "Applying normalization and script conversion for train $lang"
	input_size=`python scripts/preprocess_translate.py $train_infname_src $train_outfname_src $src_lang true`
	input_size=`python scripts/preprocess_translate.py $train_infname_tgt $train_outfname_tgt $tgt_lang true`
	echo "Number of sentences in train $lang: $input_size"

	# dev preprocessing
	dev_infname_src=$dev_data_dir/dev.$src_lang
	dev_infname_tgt=$dev_data_dir/dev.$tgt_lang
	dev_outfname_src=$devtest_norm_dir/dev.$src_lang
	dev_outfname_tgt=$devtest_norm_dir/dev.$tgt_lang
	echo "Applying normalization and script conversion for dev $lang"
	input_size=`python scripts/preprocess_translate.py $dev_infname_src $dev_outfname_src $src_lang true`
	input_size=`python scripts/preprocess_translate.py $dev_infname_tgt $dev_outfname_tgt $tgt_lang true`
	echo "Number of sentences in dev $lang: $input_size"

	# test preprocessing
	test_infname_src=$test_data_dir/test.$src_lang
	test_infname_tgt=$test_data_dir/test.$tgt_lang
	test_outfname_src=$devtest_norm_dir/test.$src_lang
	test_outfname_tgt=$devtest_norm_dir/test.$tgt_lang
	echo "Applying normalization and script conversion for test $lang"
	input_size=`python scripts/preprocess_translate.py $test_infname_src $test_outfname_src $src_lang true`
	input_size=`python scripts/preprocess_translate.py $test_infname_tgt $test_outfname_tgt $tgt_lang true`
	echo "Number of sentences in test $lang: $input_size"
done