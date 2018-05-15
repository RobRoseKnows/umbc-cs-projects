#!/bin/python3

from math import log
from collections import Counter

# Just a handy utility file with a bunch of functions I didn't want to clog up the main thing.

# lg = log base 2. talked about in class
def lg(x) -> float:
    return log(x, 2)

def ent_singular(count : int, total : int ) -> float:
    if count and total:
        prob = count / total
        return - prob * lg(prob)
    else:
        return 0

def split_attrs(arr : list) -> list:
    return [list(vals) for vals in zip(*arr)]

# Takes the total entropy of all the posisble values in a list.
def total_entropy_of_list(arr : list) -> float:

    count_of_vals = Counter(arr)

    total_entropy = 0.

    for count in count_of_vals.values():
        # Don't need to check for zero since there shouldn't be anything in the counter that's zero.
        total_entropy += ent_singular(count, len(arr))

    return total_entropy

def info_gain(labels : list, attrs : list, attr_index : int) -> (float, int):

    entropy_at_start = total_entropy_of_list(labels)

    entropy_total = 0.

    labels_for_possible_vals = organize_labels_by_attr(labels, attrs, attr_index)
    for val in labels_for_possible_vals.values():
        branch_entropy = total_entropy_of_list(val)
        entropy_total += branch_entropy

    gain = entropy_at_start - entropy_total
    return (gain, attr_index)

def choose_split(labels : list, attrs : list) -> int:
    num_attrs = len(split_attrs(attrs))
    total_gains = []

    for which in range(num_attrs):
        total_gains += [info_gain(labels, attrs, which)]

    return max(total_gains)[1]


def organize_labels_by_attr(labels : list, attrs : list, attr_index : int) -> dict:
    # lables -> list of all the labels correspondin to features
    # attrs -> list of features
    # attr_index -> which feature we want
    # Returns a dict of each value of the attr with the list of labels it has.

    possible_vals = set(split_attrs(attrs)[attr_index])
    labels_by_val = dict()

    for val in possible_vals:
        labels_by_val[val] = []

    for index, label in enumerate(labels):
        this_label_attr = attrs[index][attr_index]
        labels_by_val[this_label_attr] += [label]

    return labels_by_val


# This cuts out the index from each list in a list of lists.
def filter_lol_by_index(index : int, arr : list) -> list:
    return [ val[:index] + val[(index + 1):] for val in arr]

# Selects all the things in the list that have a desired value for a certain index.
def filter_lol_pair_by_val(labels : list, attrs : list, attr_index : int, val : int, inverted : bool = False) -> (list, list):
    # labels -> the list of labels to take in corresponding to the attrs
    # attrs -> a list of lists containing the attributes
    # attr_index -> the index of the attribute we're examining.
    # val -> the value we want to get
    # inverted -> If set to True, this will REMOVE labels with the given attribute instead of keeping them

    new_labels = []
    new_attrs = []

    for label, attr_list in zip(labels, attrs):
        # Zip them together again to iterate in parallel.
        if attr_list[attr_index] == val:
            # Has desired attribute!
            if not inverted:
                new_labels += [label]
                new_attrs += [attr_list]
        else:
            if inverted:
                new_labels += [label]
                new_attrs += [attr_list]

    return new_labels, new_attrs