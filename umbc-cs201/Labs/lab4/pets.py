# File: pets.py
# Author: Robert Rose
# Date: 9/24/15
# E-mail: robrose2@umbc.edu
# Description:
# This program checks to see if an animal a user inputs is a pet or not. Puns
# not included.

def main():
    userInput = str(input("Please enter the animal you have:"))
    if (userInput == "cat") or (userInput == "dog"):
        print("This is a pet.")
    else:
        print("This is not a pet.")
main()

