#!bin/python3

from collections import deque
from collections import namedtuple
from collections import defaultdict

from enum import Enum

import argparse

Edge = namedtuple('Edge', ['weight', 'to_node'])

class Graph(object):

    def __init__(self):
        self._adjlist = defaultdict(set)
        self.max_node = 0

    def add_edge(self, node_from : int, node_to : int, weight : int) -> None:
        new_edge = Edge(weight=weight, to_node=node_to)
        self._adjlist[node_from].add(new_edge)

        if node_to not in self._adjlist:
            self._adjlist[node_to]

        if max(node_from, node_to) > self.max_node:
            self.max_node = max(node_from, node_to)


class SearchType(Enum):
    BFS = 'BFS'
    DFS = 'DFS'
    UCS = 'UCS'

    def __str__(self):
        return self.name

def config_arg_parser() -> ArgumentParser:
    arg_parser = argparse.ArgumentParser()

    arg_parser.add_argument("input_file", type=str, help="The input file with the directed graph nodes and edges.")
    arg_parser.add_argument("start_node", type=int, help="The starting node to search from.")
    arg_parser.add_argument("end_node", type=int, help="The end node to search for.")
    arg_parser.add_argument("search_type", type=SearchType, help="What search type to use.", choices=list(SearchType))

def main():
    arg_parser = config_arg_parser()
    args = arg_parser.parse_args()
    with open(args.input_file) as file:


main()