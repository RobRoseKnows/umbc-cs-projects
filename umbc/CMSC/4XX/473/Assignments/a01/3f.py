from collections import Counter

cnt = Counter()
with open('en_ewt-ud-train.conllu') as f:
    line = f.readline()
    while line:
        if line[0] != '#' and line[0] != '\n':
            cols = line.split('\t')
            word = cols[1]
            cnt[word] += 1

        line = f.readline()

cnt2 = Counter()
with open('en_ewt-ud-dev.conllu') as f:
    line = f.readline()
    while line:
        if line[0] != '#' and line[0] != '\n':
            cols = line.split('\t')
            word = cols[1]
            cnt2[word] += 1

        line = f.readline()

print("types missing: {}".format(len(set(cnt.keys()) - set(cnt2.keys()))))
print("tokens: {}".format(sum(cnt2.values())))
