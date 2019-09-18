# This was run using the jupyter extension for vscode. Each "#%%" marks a cell
# in a jupyter notebook.
#%%
import numpy as np
import os
os.chdir('473/Assignments/a02')
#%%
en_words = []
with open('./en_ewt-ud-train.conllu') as f:
    line = f.readline()
    while line:
        if line[0] != '#' and line[0] != '\n':
            cols = line.split('\t')
            word = cols[1]
            en_words.append(word)

        line = f.readline()
en_words = np.array(en_words)

#%%
fr_words = []
with open('./fr_gsd-ud-train.conllu') as f:
    line = f.readline()
    while line:
        if line[0] != '#' and line[0] != '\n':
            cols = line.split('\t')
            word = cols[1]
            fr_words.append(word)

        line = f.readline()
fr_words = np.array(fr_words)

#%%

en_unq_val, en_freq = np.unique(en_words, return_counts=True)
fr_unq_val, fr_freq = np.unique(fr_words, return_counts=True)

#%%
en_rank = np.arange(1, len(en_freq) + 1)
fr_rank = np.arange(1, len(fr_freq) + 1)

#%%
log_en_rank = np.log(en_rank)
log_en_freq = np.log(en_freq)
log_fr_rank = np.log(fr_rank)
log_fr_freq = np.log(fr_freq)

#%%
import seaborn as sns
sns.set(color_codes=True)
#%%
sns.regplot(x=log_en_rank, y=log_en_freq, marker='.')
#%%
sns.regplot(x=log_fr_rank, y=log_fr_freq, marker='.')