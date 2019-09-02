# File:    hw3_part4.py
# Author:  Robert Rose
# Date:    9/24/15
# Section: 11
# E-mail:  robrose2@umbc.edu
# Description:
# Program asks user about the state of two switches and outputs the state of a
# generator.

def main():
    switch1 = True if input("Is the first switch on? (y/n)") == 'y' else False
    switch2 = True if input("Is the second switch on? (y/n)") == 'y' else False
    if(switch1 == switch2):
        print("The generator is off.")
    else:
        print("The generator is on.")

main()
