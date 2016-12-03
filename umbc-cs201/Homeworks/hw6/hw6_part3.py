# FIle:    hw6_part1.py
# Author:  Robert Rose
# Date:    10/22/15
# Section: 11
# E-mail:  robrose2@umbc.edu
# Description:
# Program opens a .dat or .txt file and provides a word count and average
# word length.

def main():
    fileName = input("Please provide a '.dat' or '.txt' file to continue: ")
    
    # Keep checking until the end user can read
    while(fileName[-3:] != "dat" and fileName[-3:] != "txt"):
        print("File must be a '.dat' or '.txt' file to read.")
        fileName = input("Please provide a '.dat' or '.txt' file to continue:")
    fileRead = open(fileName, "r")
    
    fullText = fileRead.read()
    words = fullText.split()
    print("The file", fileName, "has", len(words), "words in it.")

    # I'm going to do some programming magic so I don't have to itterate
    # over the entire list. I can turn an O(n) operation into O(1)!
    
    # Join all the chars together.
    justChars = "".join(words)
    
    # Divide the number of chars by the number of words
    avgLength = len(justChars) / len(words)
    
    # Viola!
    print("On average, each word is", avgLength, "characters long.")
main()
