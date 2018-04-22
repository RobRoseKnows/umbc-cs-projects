from collections import defaultdict

class Tree(defaultdict):

    #cast a (nested) dict to a (nested) Tree class
    def __init__(self, data={}):
        self.default_factory = type(self)
        for k, data in data.items():
            if isinstance(data, dict):
                self[k] = type(self)(data)
            else:
                self[k] = data

your_tree = Tree()

your_tree['a']['1']['x']  = '@'
your_tree['a']['1']['y']  = '#'
your_tree['a']['2']['x']  = '$'
your_tree['a']['3']       = '%'
your_tree['b']            = '*'

print(your_tree['b'])