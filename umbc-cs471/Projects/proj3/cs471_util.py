#!/bin/python3

from math import log

# Just a handy utility file with a bunch of functions I didn't want to clog up the main thing.

# lg = log base 2. talked about in class
def lg(x) -> float:
    return log(x, 2)

# This cuts out the index from each list in a list of lists.
def filter_lol_by_index(index : int, arr : list) -> list:
    return [ val[:index] + val[(index + 1):] for val in arr]

# Selects all the things in the list that have a desired value for a certain index.
def filter_lol_pair_by_val(labels : list, attrs : list, attr_index : int, val : int, inverted : bool = False) -> list, list:
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