# File:    palindrome.py
# Author:  Robert Rose
# Date:    10/29/15
# Section: 11
# E-mail:  robrose2@umbc.edu
# Description:
# Debug this. Now.

def isPalindrome(myString):
    tempString = myString
    length = len(tempString)
    half = length / 2
    isPalindrome = True
    for i in range(length):
        if myString[i] != myString[-i - 1]:
            isPalindrome = False
    print(isPalindrome)

#no errors below this line
def main():
    print("Should print: True\nPrints: ",end="")
    isPalindrome("tacocat")
    print("Should print: False\nPrints: ", end="")
    isPalindrome("pineapple")

main()
