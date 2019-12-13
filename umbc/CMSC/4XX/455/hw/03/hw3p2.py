import numpy as np

def solve_c1(xa, ya):
    for x in xa:
        for y in ya:
            yield (x-2) ** 2 + (y-2) ** 2

def solve_c2(xa, ya):
    for x in xa:
        for y in ya:
            yield (x) ** 2 + (y-2) ** 2

def solve_c3(xa, ya):
    for x in xa:
        for y in ya:
            yield (x) ** 2 + (y) ** 2

for n in [0.1, 0.01, 0.001]:
    x = np.arange(1-n, 3+n+n, n)
    y = np.arange(1-n, 3+n+n, n)
    c1_arr = np.fromiter(solve_c1(x, y), float)
    c2_arr = np.fromiter(solve_c2(x, y), float)
    c3_arr = np.fromiter(solve_c3(x, y), float)
    c1_ans = 1**2
    c2_ans = 2**2
    c3_ans = 3**2
    c1_out = c1_arr > c1_ans
    c2_out = c2_arr > c2_ans
    c3_out = c3_arr > c3_ans
    in_all = np.all([c1_out, c2_out, c3_out], axis=0)
    dots = np.sum(in_all)
    area = dots * n**2
    print(f"n={n}: dots={dots}, area={area}")
