# File:    hw4_part2.py
# Author:  Robert Rose
# Date:    10/6/15
# Section: 11
# E-mail:  robrose2@umbc.edu
# Description:
# The program takes a width, height and symbol of a box and then prints it
# using concatenation.

def main():
    width = int(input("Input width: "))
    height = int(input("Input height: "))
    symbol = str(input("Choose symbol: "))
    
    box = (symbol * width) + "\n"
    for i in range(1, height - 1):
        box += symbol
        box += (width - 2) * " "
        box += symbol
        box += "\n"
    if(height > 1):
        box += symbol * width
    print(box)

main()
