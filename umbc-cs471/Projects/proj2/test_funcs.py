from math import sin, cos, pi

PROMPT_FILE = "input_file.txt"
def prompt_example(x,y):
    return x+y

TEST1_FILE = "easy_func.txt"
def test1(x, y):
    return -((x+1)**2+y**2)+1

TEST2_FILE = "med_func.txt"
def test2(x, y):
    return (x**2 - y)* sin(x)

def sinc(x):
    if x == 0:
       return 1
    return sin(x) / x

TEST3_FILE = "old_hard.txt"
def test3(x, y):
    return sinc(x**2+y**2)

def my_func(x, y, input_file):
    if input_file == PROMPT_FILE:
        return prompt_example(x, y)
    elif input_file == TEST1_FILE:
        return test1(x, y)
    elif input_file == TEST2_FILE:
        return test2(x, y)
    elif input_file == TEST3_FILE:
        return test3(x, y)
    else:
        print("uh...")
        return None