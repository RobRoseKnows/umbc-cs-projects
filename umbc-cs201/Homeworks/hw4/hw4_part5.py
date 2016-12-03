# File:    hw4_part3.py
# Author:  Robert Rose
# Date:    10/6/15
# Section: 11
# E-mail:  robrose2@umbc.edu
# Description:
# This program asks a user for 10 subjects and then tells them which ones they
# can study. In order to be studied, they must end with '-ology'

def main():
    string = str(input("Please enter a string: "))
    character = str(input("Please enter a character: "))
    count = 0
    for char in string.lower():
        if(char == character.lower()):
            count += 1
    print("The character '" + character + "' appears " + str(count) + " times in the string:")
    print("\t" + string)

main()
