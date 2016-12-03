# File:    hw8_part1.py
# Author:  Robert Rose
# Date:    11/24/15
# Section: 11
# E-mail:  robrose2@umbc.edu
# Description:
# This program takes a list from user input and outputs it in reverse using
# recursion. 


def main():
    integers = []
    number = int(input("Enter a number to append to the list, or -1 to stop: "))
    while(number != -1):
        integers.append(number)
        number = int(input("Enter a number to append to the list, or -1 to stop: "))
    
    print("The list as you entered it is:", integers)
    rev(integers)

# Recursively prints the integers in reverse
def rev(integers):
    print(integers[-1])
    if(len(integers) != 1):
        rev(integers[0:-1])

main()
