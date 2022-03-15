from indicnlp.tokenize.indic_tokenize import trivial_tokenize
from indicnlp.normalize.indic_normalize import IndicNormalizerFactory

lang = 'ml'
input_path = 'monolingual data/te.tok.txt'
output_path = 'monolingual data/te_final2.txt'

normalizer_factory = IndicNormalizerFactory()
normalizer = normalizer_factory.get_normalizer(lang)

def process_sent(sent):
    normalized = normalizer.normalize(sent)
    processed = ' '.join(trivial_tokenize(normalized, lang))
    return processed

count=-1
lst=[]
with open(input_path, 'r', encoding='utf-8') as in_fp,\
	 open(output_path, 'w', encoding='utf-8') as out_fp:
    for line in in_fp.readlines():
        sent = line.rstrip('\n')
        if len(sent)>200:
            continue
        count+=1
        if count<80000:
            break
        out_fp.write(sent)
        out_fp.write('\n')
