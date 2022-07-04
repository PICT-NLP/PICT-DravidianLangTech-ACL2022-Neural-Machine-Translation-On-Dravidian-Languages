<div align="center">
	<h1><b><i> PICT@DravidianLangTech-ACL2022: Neural Machine Translation On Dravidian Languages</i></b></h1>
	<a href="https://aclanthology.org/2022.dravidianlangtech-1.28/">Paper</a>
</div>

This paper presents a summary of the findings that we obtained based on the shared task on machine translation of Dravidian languages. As a part of this shared task, we carried out neural machine translations for the following five language pairs: Kannada to Tamil, Kannada to Telugu, Kannada to Malayalam, Kannada to Sanskrit, and Kannada to Tulu. The datasets for each of the five language pairs were used to train various translation models, including Seq2Seq models such as LSTM, bidirectional LSTM, Conv Seq2Seq, and training state-of-the-art as transformers from scratch, and fine-tuning already pre-trained models. For some models involving monolingual corpora, we implemented backtranslation as well. These models’ accuracy was later tested with a part of the same dataset using BLEU score as an evaluation metric.

## Dataset

- DravidianLangTech-2022 Official Dataset : https://competitions.codalab.org/competitions/36411#learn_the_details-get-data

- Monolingual Data for backtranslation : https://indicnlp.ai4bharat.org/corpora/
