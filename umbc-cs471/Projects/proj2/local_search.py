#!bin/python3

import argparse

import random

RAND = random.Random()
RAND.seed(1337)

def hill_climbing(xinit : int, yinit : int, xmin : int, ymin : int, xmax : int, ymax : int):
    on_x = xinit
    on_y = yinit

    while True:
        # Check to see if one of the neighbors goes out of bounds in the x-direction
        inbound_x_neg = xmin <= on_x - 1 <= xmax
        inbound_x_pos = xmin <= on_x + 1 <= xmax

        # Check if they go out of bounds in the y-direction.
        inbound_y_neg = ymin <= on_y - 1 <= ymax
        inbound_y_pos = ymin <= on_y + 1 <= ymax

        # Check if x & y are both inbound
        inbound_x = inbound_x_neg and inbound_x_pos
        inbound_y = inbound_y_neg and inbound_y_pos

        inbound_all = inbound_x and inbound_y

        # Check if inbound on negative or positive
        inbound_neg = inbound_x_neg and inbound_y_neg
        inbound_pos = inbound_x_pos and inbound_y_pos

        if()

        next_x, next_y = high_next()


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


def run():
    arg_parser = config_arg_parser()
    args = arg_parser.parse_args()

    with open(args.input_file) as file_in:
        exec(file_in) # VERY DANGEROUS! DO NOT DO IRL!

    xmin = args.xmin
    ymin = args.ymin
    xmax = args.xmax
    ymax = args.ymax


