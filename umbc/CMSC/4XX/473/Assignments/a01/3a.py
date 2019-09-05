with open("./en_ewt-ud-dev.conllu") as f:
    line = f.readline()
    cnt = 0
    while line:
        if line == "\n":
            cnt += 1
        line = f.readline()
    print("dev: {}".format(cnt))

with open("./en_ewt-ud-train.conllu") as f:
    line = f.readline()
    cnt = 0
    while line:
        if line == "\n":
            cnt += 1
        line = f.readline()
    print("train: {}".format(cnt))
