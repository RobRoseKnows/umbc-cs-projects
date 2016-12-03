# File:    hw4_part3.py
# Author:  Robert Rose
# Date:    10/6/15
# Section: 11
# E-mail:  robrose2@umbc.edu
# Description:
# This program asks a user for 10 subjects and then tells them which ones they
# can study. In order to be studied, they must end with '-ology'

def main():
    nums = range(1, 101)
    
    for num in nums:
        if num % 3 == 0 and num % 5 == 0:
            print("In the future, everyone will be world-famous for 15 minutes.")      
        elif num % 5 == 0:
            print("Where do you see yourself in five years?")
        elif num % 3 == 0:
            print("Better three hours too soon than a minute too late.")
        else:
            print(num)


main()
