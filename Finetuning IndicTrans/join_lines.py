from indicnlp.tokenize.indic_tokenize import trivial_tokenize
from indicnlp.normalize.indic_normalize import IndicNormalizerFactory
from indicnlp.tokenize import sentence_tokenize
import re

lang = 'ta'
output_path = '../../data/kn-ta/ta_combined.txt'
input_path = '../../data/kn-ta/kn_ta_strip_outputs.txt'

count=-1 
with open(input_path, 'r', encoding='utf-8') as in_fp,\
	 open(output_path, 'w', encoding='utf-8') as out_fp:
    line=in_fp.readlines()
    i=0
    while i < len(line):
        if str(i) in dic.keys():
            for j in range(dic[str(i)]):
                sent = line[i].rstrip('\n')
                out_fp.write(sent)
                out_fp.write(" ")
                i+=1
            out_fp.write('\n')
        else:
            sent = line[i].rstrip('\n')
            out_fp.write(sent)
            out_fp.write('\n')
            i+=1