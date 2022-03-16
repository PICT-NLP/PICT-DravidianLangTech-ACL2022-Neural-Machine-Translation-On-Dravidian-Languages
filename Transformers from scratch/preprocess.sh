# script for preprocessing the generated train, dev and test files for source and target languages.
# please refer the fairseq documentation for the commands used: ( https://fairseq.readthedocs.io/en/latest/command_line_tools.html#fairseq-preprocess )
# specify source-lang and target-lang accordingly.

fairseq-preprocess --source-lang kn --target-lang ml \
--trainpref nmt-kn-ml/train/train \
--validpref nmt-kn-ml/dev/dev \
--testpref nmt-kn-ml/test/test \
--destdir nmt-kn-ml/tokenized.kn-ml \
--thresholdsrc 2 \
--thresholdtgt 2 