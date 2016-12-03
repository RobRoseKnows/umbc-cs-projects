# File:    factorial.py
# Author:  Robert Rose
# Date:    10/29/15
# Section: 11
# E-mail:  robrose2@umbc.edu
# Description:
# Debug this. Now.

#letterCount should take a letter and word,
#and count the number of times letter appears
#in the word
def factorial(n):
    product = n
    for x in range(2,n):
        product = product * x
    return product

#no errors below this line
def main():
    print("Should print: 120\nPrints: ",end="")
    print(factorial(5))

main()
