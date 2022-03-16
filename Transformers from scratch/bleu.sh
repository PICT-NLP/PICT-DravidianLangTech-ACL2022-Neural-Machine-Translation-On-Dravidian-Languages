# for obtaining the bleu according to the nltk bleu metric.
# pass the generated and actual translation files accrodingly to get the nltk bleu score.

import nltk
from nltk.translate.bleu_score import sentence_bleu
f = open("/content/test_ml_generated_scratch_transformer.txt")
ml_candidates = [i.strip() for i in f.readlines()]
f = open("/content/test_ml_actual_scratch_transformer.txt")
ml_gold = [i.strip() for i in f.readlines()]
total_four = 0
for i in range(len(ml_candidates)):
    candidate = ml_candidates[i].split(" ")
    references = ml_gold[i].split(" ")
    reference = [references]
    score_cumulative4 = sentence_bleu(reference, candidate, weights=(0.25, 0.25, 0.25, 0.25))
    total_four = total_four + score_cumulative4
print(total_four/len(ml_candidates))