# File:    ong.py
# Author:  Robert Rose
# Date:    11/19/15
# Section: 11
# E-mail:  robrose2@umbc.edu
# Description:
# This program creates a class that translates words into 'ong'.

class Ong:
    
    # Constructor for Ong
    def __init__(self, word):
        self.word = word

    # Checks to see if the letter selected is a vowel or not.
    def isVowel(self, letter):
        vowels = ['a','e','i','o','u']
        return letter in vowels
    
    # Translates a word to ong and then prints it.
    def translateOng(self):
        newWord = ""
        for letter in self.word:
            newWord += letter
            if(not self.isVowel(letter)):
                newWord += "ong"
        print(newWord)

# Asks a user for a word and then translates it to Ong.
def main():
    string = input("Enter a string to translate: ")
    word = Ong(string)
    word.translateOng()

main()
