# File:    hw8_part2.py
# Author:  Robert Rose
# Date:    11/24/15
# Section: 11
# E-mail:  robrose2@umbc.edu
# Description:
# This program takes a triangle height and prints out a right triangle of that
# height.


def main():
    height = int(input("Please enter the height of your triangle: "))
    while(height < 1):
        print("Your triangle height must be positive (> 0).")
        height = int(input("Please enter the height of your triangle: "))
    
    character = input("Please enter a character for your triangle: ")
    
    # Add a new line in between
    print()
    
    tri(height, character)


# Recursive triangle drawing function.
def tri(height, character):
    row = character * height
    print(row)
    if(height > 1):
        tri(height - 1, character)

main()
