#!/bin/python3

from math import log

# Just a handy utility file with a bunch of functions I didn't want to clog up the main thing.

# lg = log base 2. talked about in class
def lg(x) -> float:
    return log(x, 2)

# This cuts out the index from each list in a list of lists.
def remove_index(index : int, arr : list) -> list:
    return [ val[:index] + val[(index + 1):] for val in arr]