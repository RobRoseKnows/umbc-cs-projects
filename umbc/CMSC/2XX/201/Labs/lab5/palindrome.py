# File:    palindrome.py
# Author:  Robert Rose
# Date:    10/1/15
# Section: 11
# E-mail:  robrose2@umbc.edu
# Description:
# This program reverses a string and then checks to see if it is a palindrome
# or not.

def main():
    word = input("Gimme string:")
    newWord = ""
    for c in range(1, len(word)+1):
        newWord += word[-c]
    if(word == newWord):
        print("That's a mighty fine palindrome you have there.")
    else:
        print("That's no palindrome! It's a space station!")
main()
