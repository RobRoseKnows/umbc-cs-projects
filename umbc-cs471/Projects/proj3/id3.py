#!/bin/python3

import argparse
import csv

from collections import namedtuple

Data_Point = namedtuple('Data_Point', ['label', 'data'])

#def algo():


def config_arg_parser() -> argparse.ArgumentParser():
    arg_parser = argparse.ArgumentParser()

    arg_parser.add_argument("train_file", type=str, help="The CSV file of values to train the data on.")
    arg_parser.add_argument("test_file", type=str, help="The CSV file with the data to test on.")

    return arg_parser

def open_csv_and_read(file_name : str, test_set : bool = False) -> list:
    ret = []
    with open(file_name, newline='') as csv_file:
        csv_reader = csv.reader(csv_file, delimiter=',', quoting='QUOTE_NONNUMERIC')
        for row in csv_reader:
            if not test_set:
                # So I can use the same reader for both test and training data, this checks to see if the data is test or training.
                curr_data = [int(val) for val in row[:-1]]
                curr_label = row[-1]
            else:
                curr_data = [int(val) for val in row]
                curr_label = None
            ret += [Data_Point(curr_label, curr_data)]
    return ret



def run(args):
    print(open_csv_and_read(args.train_file))
    print(open_csv_and_read(args.test_file, True))

arg_parser = config_arg_parser()
args = arg_parser.parse_args()

print(run(args))