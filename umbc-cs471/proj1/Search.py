#!bin/python3

from collections import deque
from enum import Enum

import argparse

class SearchType(Enum):
    BFS = 'BFS'
    DFS = 'DFS'
    UCS = 'UCS'

    def __str__(self):
        return self.value

def config_arg_parser():
    arg_parser = argparse.ArgumentParser()

    arg_parser.add_argument("input_file", type=str, help="The input file with the directed graph nodes and edges.")
    arg_parser.add_argument("start_node", type=int, help="The starting node to search from.")
    arg_parser.add_argument("end_node", type=int, help="The end node to search for.")
    arg_parser.add_argument("search_type", )

def main():
    arg_parser = config_arg_parser()

main()