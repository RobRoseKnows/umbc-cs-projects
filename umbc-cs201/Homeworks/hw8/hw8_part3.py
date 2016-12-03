# File:    hw8_part2.py
# Author:  Robert Rose
# Date:    11/24/15
# Section: 11
# E-mail:  robrose2@umbc.edu
# Description:
# This program recursively finds the greatest common denominator between two
# numbers.


def main():
    num1 = int(input("Please enter the first integer: "))
    while(num1 < 1):
        print("Your number must be positive (greater than 0).")
        num1 = int(input("Please enter the first integer "))
    
    num2 = int(input("Please enter the second integer: "))
    while(num2 < 1):
        print("Your number must be positive (greater than 0).")
        num2 = int(input("Please enter the second integer: "))

    find = gcd(num1, num2, 1)
    print("The GCD of", num1, "and", num2, "is", find)

# Recursively finds the greatest common denominator
def gcd(num1, num2, current):
    
    # Base case
    if(current > min(num1, num2)):
        return -1
    
    num1divided = num1 / current
    num2divided = num2 / current
    currentIsDenominator = False
    
    # Check to see if it's a common denominator
    if(num1divided == int(num1divided) and num2divided == int(num2divided)):
        currentIsDenominator = True
    
    recurse = gcd(num1, num2, current + 1)
    
    # If there's a higher GCD, use it. If not and if current works, use it. 
    # Otherwise return -1.
    if(recurse > current):
        return recurse
    elif(currentIsDenominator):
        return current
    else:
        return -1

main()
