from math import sin, cos, pi

FUNC_DICT = dict()

PROMPT_FILE = "input_file.txt"
def prompt_example(x,y):
    return x+y
FUNC_DICT[PROMPT_FILE] = prompt_example

TEST1_FILE = "easy_func.txt"
def test1(x, y):
    return -((x+1)**2+y**2)+1
FUNC_DICT[TEST1_FILE] = test1

TEST2_FILE = "med_func.txt"
def test2(x, y):
    return (x**2 - y)* sin(x)
FUNC_DICT[TEST2_FILE] = test2

def sinc(x):
    if x == 0:
       return 1
    return sin(x) / x

TEST3_FILE = "old_hard.txt"
def test3(x, y):
    return sinc(x**2+y**2)
FUNC_DICT[TEST3_FILE] = test3

def my_func(x, y, input_file):
    return FUNC_DICT[input_file](x, y)
