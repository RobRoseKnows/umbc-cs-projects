#!/bin/python3

import argparse
import csv

from collections import namedtuple, Counter
from math import log

try:
    from cs471_util import filter_lol_by_index, filter_lol_pair_by_val, choose_split, split_attrs
except:
    print("Looks like the utility file (`cs471_util.py`) is missing.")

DataPoint = namedtuple('DataPoint', ['label', 'data'])


########################################################
# Decision Tree classes
########################################################

class DecisionLeafNode():

    # This is the Decision Leaf Node class that
    def __init__(self, result : int):
        self.result = result

    def __call__(self) -> int:
        return result

    def __str__(self) -> str:
        return str(result)

class DecisionBranch():
    def __init__(self, labels: list, attrs : int, branches : dict = None):
        self.labels = labels
        self.attrs = attrs
        self.branches = {} or branches
        learn()

    def __call__(self, attrs : list):
        attr_val = attrs[self.attr_index]

        # The value for this attribute is in the tree (should be for our project)
        if attr_val in self.branches:
            # If it's a leaf, it'll just return the result otherwise it recurrs to the
            # next branch.
            return self.branches[attr_val](attrs)
        else:
            return None


    def learn(self):
        # labels -> a list of integer categories
        # attrs -> a list of list of attrs corresponding to the list of labels.

        # Check to make sure there are actually labels in the given sample.
        if not len(self.labels):
            return None

        # Now that we know there are actually things in the sample, we can do more science.
        plurality_label, plurality_count = Counter(self.labels).most_common(1)[0]
        if plurality_count == len(self.labels):
            # This means everything is one thing! Yay! Just choose whichever was the most common
            return DecisionLeafNode(plurality_label)

        elif not len(attrs[0]):
            # All of them for this project should have the same attributes, so I'll
            # just check the first one. This is if we've eliminated all the relevant attributes,
            # we just choose the most common label.
            return DecisionLeafNode(plurality_label)

        else:

            chosen_attr_index = choose_split(self.labels, self.attrs)
            self.attr_index = chosen_attr_index

            self.branches = split_by_attr(chosen_attr_index)


    def split_by_attr(self, attr_index) -> dict:
        set_of_attrs = set(split_attrs(self.attrs)[attr_index])

        ret_dict = dict()

        for val in set_of_attrs:
            new_labels, new_attrs = filter_lol_pair_by_val(self.labels, self.attrs, attr_index, val)
            new_attrs = filter_lol_by_index(attr_index, new_attrs)
            ret_dict[val] = DecisionBranch(new_labels, new_attrs)

        return ret_dict


class DecisionTree():

    def __init__(self):
        # The root can either be pointing to a branch or a leaf, depending on what the result is.
        self.root = None

    # Train is basically a wrapper around the recursive learning function.
    def train(self, labels : list, attrs : list):
        plurality_label, plurality_count = Counter(labels).most_common(1)[0]
        if plurality_count == len(labels):
            self.root = DecisionLeafNode(plurality_label)
        elif:
            self.root = DecisionLeafNode(plurality_label)
        else:
            self.root = DecisionBranch(labels, attrs)

    def test(self, labels : list, attrs : list):


#########################################################
# Functions
#########################################################

def generate_tree(data : list):
    if not len(self.data):
        self.root = None
        return None

def get_ig_for_attr(attrs : list, index : int) -> float:


def choose_split(labels : list, attrs : list) -> int:
    ig_for_attr = []

    return


def remove_index(index : int, arr : list) -> list:
    return filter_lol_by_index(index, arr)

def all_with_attr_value(labels : list, attrs : list, attr_index : int, val : int, inverted : bool = False) -> list, list:
    return filter_lol_pair_by_val(labels, attrs, attr_index, val, inverted)

def predict(training_data : list, testing_data : list):
    tree = DecisionTree()

    # Originally was going to treat the data like tuples but oh well.
    training_labels, training_attrs = zip(*training_data)
    tree.train(training_labels, training_attrs)

# This uses zip and the Counter collection to count what the most common label in the
# training data is.
# Returns: (label, number of times it appears)
def find_plurality(points : list) -> int, int:
    pts_labels, pts_data = zip(*points)
    count = Counter(pts_labels)
    return count.most_common(1)[0]


# Configures the argument parser
def config_arg_parser() -> argparse.ArgumentParser():
    arg_parser = argparse.ArgumentParser()

    arg_parser.add_argument("train_file", type=str, help="The CSV file of values to train the data on.")
    arg_parser.add_argument("test_file", type=str, help="The CSV file with the data to test on.")

    return arg_parser

# Reusable function to open a CSV, read the values in it and put them into datapoints.
# Setting test_set to True will return None as the label for the testing data.
def open_csv_and_read(file_name : str, test_set : bool = False) -> list:
    ret = []
    with open(file_name, newline='') as csv_file:
        csv_reader = csv.reader(csv_file, delimiter=',')
        for row in csv_reader:
            if not test_set:
                # So I can use the same reader for both test and training data, this checks to see if the data is test or training.
                curr_data = [int(val) for val in row[:-1]]
                curr_label = row[-1]
            else:
                curr_data = [int(val) for val in row]
                curr_label = None
            ret += [DataPoint(curr_label, curr_data)]
    return ret


def run(args):
    training_data = open_csv_and_read(args.train_file)
    testing_data = open_csv_and_read(args.test_file, True)

arg_parser = config_arg_parser()
args = arg_parser.parse_args()

print(run(args))