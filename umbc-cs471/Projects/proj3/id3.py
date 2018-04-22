#!/bin/python3

import argparse


def algo():


def config_arg_parser() -> argparse.ArgumentParser():
    arg_parser = argparse.ArgumentParser()

    arg_parser.add_argument("train_file", type=str, help="The CSV file of values to train the data on.")
    arg_parser.add_argument("test_file", type=int, help="The CSV file with the data to test on.")

    return arg_parser

def run(args):



arg_parser = config_arg_parser()
args = arg_parser.parse_args()

print(run(args))