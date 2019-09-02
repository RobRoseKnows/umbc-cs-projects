# File:    hw3_part3.py
# Author:  Robert Rose
# Date:    9/24/15
# Section: 11
# E-mail:  robrose2@umbc.edu
# Description:
# Program takes user user symptoms and attempts to guess as
# to a diagnosis.

def main():
    questionAnswer = input("Do you have a fever? (y/n)")
    hasFever = True if questionAnswer == 'y' else False
    if not hasFever:
        questionAnswer = input("Do you have a stuffy nose? (y/n)")
        hasStuffyNose = True if questionAnswer == 'y' else False
        if not  hasStuffyNose:
            print("Your diagnosis: You are a hypochondriac")
        else:
            print("Your diagnosis: You have a head cold")
    else:
        questionAnswer = input("Do you have a rash? (y/n)")
        hasRash = True if questionAnswer == 'y' else False
        if hasRash:
            print("Your diagnosis: You have the Measles")
        else:
            questionAnswer = input("Does you ear hurt? (y/n)")
            hasEarHurt = True if questionAnswer == 'y' else False
            if hasEarHurt:
                print("Your diagnosis: You have an ear infection.")
            else:
                print("Your diagnosis: You have the flu.")

main()
