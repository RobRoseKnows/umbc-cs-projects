#!bin/python3

import argparse
import random

from collections import Counter

from test_funcs import my_func

RAND = random.Random()
#RAND.seed(1338)

# Maximum number of restarts to do
MAX_RESTARTS = 60


# Putting the current value first is how we make sure it eventually terminates.
def minusPlusZero(val : int) -> (int, int, int):
    return (val, val - 1, val + 1)

def high_next(on_x : int, on_y : int, xmin : int, ymin : int, xmax : int, ymax : int) -> (int, int):
    x_vals = list(filter(lambda x: xmin <= x <= xmax, minusPlusZero(on_x)))
    y_vals = list(filter(lambda y: ymin <= y <= ymax, minusPlusZero(on_y)))

    combos = [ (x, y) for x in x_vals for y in y_vals ]

    heuristics = [ my_func(x, y, TEST_ID) for x, y in combos ]

    high_index = heuristics.index(max(heuristics))
    return combos[high_index]


def hill_climbing(xinit : int, yinit : int, xmin : int, ymin : int, xmax : int, ymax : int):
    on_x = xinit
    on_y = yinit

    while True:
        next_x, next_y = high_next(on_x, on_y, xmin, ymin, xmax, ymax)
        if next_x == on_x and next_y == on_y:
            #We found the local maxima, go ahead and return.
            return next_x, next_y
        else:
            on_x = next_x
            on_y = next_y


# Graph program taken from prompt.
def graph(func, xmin : int, ymin : int, xmax : int, ymax : int, points=[]):
    fig = plt.figure()
    ax = fig.gca(projection='3d')

    # Make data.
    X = np.arange(xmin, xmax, 0.25)
    Y = np.arange(ymin, ymax, 0.25)
    X, Y = np.meshgrid(X, Y)

    Z = func(X,Y)
    # Plot the surface.
    surf = ax.plot_surface(X, Y, Z, #cmap=cm.coolwarm,
    linewidth=0, antialiased=False)

    # Customize the z axis.
    ax.set_zlim(-1.01, 1.01)
    ax.zaxis.set_major_locator(LinearLocator(10))
    ax.zaxis.set_major_formatter(FormatStrFormatter('%.02f'))

    # Add a color bar which maps values to colors.
    #fig.colorbar(surf, shrink=0.5, aspect=5)
    for i in points:
        ax.plot([i[0]], [i[1]], [i[2]], '.', color=(i[3]/1000,0,0))
    plt.show()


def config_arg_parser() -> argparse.ArgumentParser():
    arg_parser = argparse.ArgumentParser()

    arg_parser.add_argument("input_file", type=str, help="The input file with the my_func() file.")
    arg_parser.add_argument("xmin", type=int, help="The minimum x value.")
    arg_parser.add_argument("ymin", type=int, help="The minimum y value.")
    arg_parser.add_argument("xmax", type=int, help="The maximum x value.")
    arg_parser.add_argument("ymax", type=int, help="The maximum y value.")

    return arg_parser

def random_restarts(xmin, ymin, xmax, ymax):

    count = Counter()
    number_iterations = 0

    while number_iterations < MAX_RESTARTS:
        number_iterations += 1
        state_x = RAND.randint(xmin, xmax)
        state_y = RAND.randint(ymin, ymax)

        maxima_loc = hill_climbing(state_x, state_y, xmin, ymin, xmax, ymax)

        # print("Init state: " + str(state_x) + ", " + str(state_y) + "  Maximum: " + str(maxima_loc))

        count[maxima_loc] += 1

    # print(str(count))

    keys = list(count.keys())
    heuristics = [ my_func(x, y, TEST_ID) for x, y in keys ]
    high_index = heuristics.index(max(heuristics))

    # for key in count.keys():
    #     # print(key)
    #     print(str(key) + ": " + str(count[key]) + " = " + str(my_func(key[0], key[1])))

    # maxima = count.most_common(1)[0][0]
    maxima = keys[high_index]
    return [maxima[0], maxima[1]]


def run(args):

    #func_file_body = open(args.input_file).read() # VERY DANGEROUS! DO NOT DO IRL!
    #print(func_file_body)
    #func_text = func_file_body + "\n"
    #print(func_text)
    #exec(func_text)

    xmin = args.xmin
    ymin = args.ymin
    xmax = args.xmax
    ymax = args.ymax

    return random_restarts(xmin, ymin, xmax, ymax)

arg_parser = config_arg_parser()
args = arg_parser.parse_args()

TEST_ID = args.input_file

result = run(args)

print(result)
# print(my_func(result[0], result[1]))