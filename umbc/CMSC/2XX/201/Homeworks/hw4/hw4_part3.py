# File:    hw4_part3.py
# Author:  Robert Rose
# Date:    10/6/15
# Section: 11
# E-mail:  robrose2@umbc.edu
# Description:
# This program asks a user for 10 subjects and then tells them which ones they
# can study. In order to be studied, they must end with '-ology'

def main():
    subjects = []
    for i in range(10):
        subjects.append(str(input("Please provide a subject: ")))
    
    for val in subjects:
        if(val[-5:] == "ology"):
            print("You can study", val)
        else:
            print(val)

main()
