# create a seperate folder to store everything
mkdir finetuning
cd finetuning

# clone the repo for running finetuning
git clone https://github.com/AI4Bharat/indicTrans.git
cd indicTrans
# clone requirements repositories
git clone https://github.com/anoopkunchukuttan/indic_nlp_library.git
git clone https://github.com/anoopkunchukuttan/indic_nlp_resources.git
git clone https://github.com/rsennrich/subword-nmt.git
cd ..

sudo apt install tree

# Install the necessary libraries
pip install sacremoses pandas mock sacrebleu tensorboardX pyarrow indic-nlp-library

# Install fairseq from source
git clone https://github.com/pytorch/fairseq.git
cd fairseq
# !git checkout da9eaba12d82b9bfc1442f0e2c6fc1b895f4d35d
pip install --editable ./
cd ..

cd finetuning

cd indicTrans

