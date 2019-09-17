from collections import Counter

en_cnt = Counter()
with open('en_ewt-ud-train.conllu') as f:
    line = f.readline()
    while line:
        if line[0] != '#' and line[0] != '\n':
            cols = line.split('\t')
            word = cols[1]
            cnt[word] += 1

        line = f.readline()

fr_cnt = Counter()
with open('fr_gsd-ud-train.conllu') as f:
    line = f.readline()
    while line:
        if line[0] != '#' and line[0] != '\n':
            cols = line.split('\t')
            word = cols[1]
            cnt[word] += 1

        line = f.readline()