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
        self.max_node = 0 # wtf was this for?

    def add_edge(self, node_from : int, node_to : int, weight : int) -> None:
        new_edge = Edge(weight=weight, to_node=node_to)
        self._adjlist[node_from].add(new_edge)

        if node_to not in self._adjlist:
            self._adjlist[node_to]

        if max(node_from, node_to) > self.max_node:
            self.max_node = max(node_from, node_to)

    def close_graph(self) -> None:
        for node in range(self.max_node + 1):
            self._adjlist[node]

    def get_edge_set(self, node) -> set:
        return self._adjlist[node]


class SearchType(Enum):
    BFS = 'BFS'
    DFS = 'DFS'
    UCS = 'UCS'

    def __str__(self):
        return self.name

def build_graph(file_in) -> Graph:
    graph = Graph()
    for line in file_in:
        src, dest, weight = map(int, line.split())
        graph.add_edge(src, dest, weight)
    return graph

def config_arg_parser() -> argparse.ArgumentParser():
    arg_parser = argparse.ArgumentParser()

    arg_parser.add_argument("input_file", type=str, help="The input file with the directed graph nodes and edges.")
    arg_parser.add_argument("start_node", type=int, help="The starting node to search from.")
    arg_parser.add_argument("end_node", type=int, help="The end node to search for.")
    arg_parser.add_argument("search_type", type=SearchType, help="What search type to use.", choices=list(SearchType))

    return arg_parser

def bfs(G, src, dest):
    nodes_visited = set()
    nodes_to_visit = deque([[src]])

    while nodes_to_visit:
        path = nodes_to_visit.popleft()
        on = path[-1]
        if on not in nodes_visited:
            nodes_visited.add(on)

            if on == dest:
                return path

            for edge in sorted(G.get_edge_set(on)):
                to = edge.to_node
                nodes_to_visit.append(path + [to])

    return []

def dfs(G, src, dest):
    nodes_visited = set()
    nodes_to_visit = [[src]]

    while nodes_to_visit:
        path = nodes_to_visit.pop()
        on = path[-1]
        if on not in nodes_visited:
            nodes_visited.add(on)

            if on == dest:
                return path

            for edge in sorted(G.get_edge_set(on)):
                to = edge.to_node
                nodes_to_visit.append(path + [to])

    return []

def ucs(G, src, dest):
    path = []
    nodes_visited = set()

    return path

def run():
    arg_parser = config_arg_parser()
    args = arg_parser.parse_args()
    G = Graph()
    with open(args.input_file) as file_in:
        G = build_graph(file_in)

    src = args.start_node
    dest = args.end_node
    search = args.search_type

    if search is SearchType.BFS:
        return bfs(G, src, dest)
    elif search is SearchType.DFS:
        return dfs(G, src, dest)
    elif search is SearchType.UCS:
        return ucs(G, src, dest)
    else:
        return []

print(run())