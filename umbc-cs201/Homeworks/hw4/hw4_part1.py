# File:    hw4_part1.py
# Author:  Robert Rose
# Date:    10/6/15
# Section: 11
# E-mail:  robrose2@umbc.edu
# Description: 
# This proram draws a right triangle of a requested height using an inputed
# symbol.

def main():
    height = int(input("Please input a triangle height: "))
    symbol = str(input("Please input a one character symbol: "))
    for i in range(0, height):
        line = symbol * (i + 1)
        print(line)
main()
