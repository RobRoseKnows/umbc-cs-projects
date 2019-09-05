from collections import Counter
  
cnt = Counter()
with open('en_ewt-ud-train.conllu') as f:
    line = f.readline()
    while line:
        if line[0] != '#' and line[0] != '\n':
            cols = line.split('\t')
            word = cols[1].lower()
            cnt[word] += 1

        line = f.readline()

print(cnt.most_common()[:-50:-1])
