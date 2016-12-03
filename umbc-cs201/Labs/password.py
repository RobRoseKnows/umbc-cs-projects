# File:    password.py
# Author:  Robert Rose
# Date:    10/8/15
# Section: 11
# E-mail:  robrose2@umbc.edu
# Description:
# This program asks a user to guess the password and continues asking until the
# damn user can remember his/her damn password.

PASSWORD = "UMBCrulz"

def main():
    guesses = 3
    guess = ""
    while guesses > 0 and guess != PASSWORD:
        guess = input("Password plz: ")
        if guess == PASSWORD:
            print("Congrats! Welcome to the Dark Side.")
        else:
            guesses -= 1
            print("ID-10-T Error. Try another password. Tries remaining: ", guesses)
    if guesses == 0:
       print("PEBCAK. You may not access The Dark Side.")

main()
