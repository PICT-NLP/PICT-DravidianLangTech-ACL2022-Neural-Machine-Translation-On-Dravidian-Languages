# We also add special tags to indicate the source and target language in the inputs
#  Eg: to translate a sentence from english to hindi , the input would be   __src__en__   __tgt__hi__ <en bpe tokens>
exp_dir=../../drive/MyDrive/Dataset_Full_wt/kn-ta
echo "Adding language tags"
python scripts/add_tags_translate.py $exp_dir/bpe/train.SRC $exp_dir/final/train.SRC 'kn' 'ta'
python scripts/add_tags_translate.py $exp_dir/bpe/dev.SRC $exp_dir/final/dev.SRC 'kn' 'ta'
python scripts/add_tags_translate.py $exp_dir/bpe/test.SRC $exp_dir/final/test.SRC 'kn' 'ta'
cp -r $exp_dir/bpe/train.TGT $exp_dir/final/train.TGT 
cp -r $exp_dir/bpe/dev.TGT $exp_dir/final/dev.TGT
cp -r $exp_dir/bpe/test.TGT $exp_dir/final/test.TGT