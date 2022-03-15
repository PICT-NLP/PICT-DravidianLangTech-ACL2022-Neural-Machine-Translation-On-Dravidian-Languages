from indicnlp.tokenize.indic_tokenize import trivial_tokenize
from indicnlp.normalize.indic_normalize import IndicNormalizerFactory
from indicnlp.tokenize import sentence_tokenize
import re

INDIC = ["as", "bn", "gu", "hi", "kn", "ml", "mr", "or", "pa", "ta", "te"]

def split_sentences(paragraph, language):
    pattern=re.compile(r'\s*[.]\s*')
    matches=pattern.split(paragraph)
    final=[]
    for match in matches:
        if len(match)==0:
            continue
        if len(match)>200:
            m=re.compile(r'\s*[,]\s*').split(paragraph)
            lst=[]
            s=""
            for x in m:
                x+=", "
                if x=="":
                    continue
                if len(s+x)<200:
                    s+=x
                else:
                    lst.append(s)
                    s=x
            lst.append(s[:-2])
            final.extend(lst)
        else:
            final.append(match)
    return final


lang = 'kn'
input_path = '../../data/kn-ta/test/test.kn'
output_path = '../../data/kn-ta/test_strip.txt'

count=-1
dic={}
with open(input_path, 'r', encoding='utf-8') as in_fp,\
	 open(output_path, 'w', encoding='utf-8') as out_fp:
    for line in in_fp.readlines():
        count+=1
        sent = line.rstrip('\n')
        if len(sent)>200:
            sent_list=split_sentences(sent,'kn')
            dic[str(count)]=len(sent_list)
            for lol in sent_list:
                out_fp.write(lol)
                out_fp.write('\n')
        else:
            out_fp.write(sent)
            out_fp.write('\n')
print(dic)