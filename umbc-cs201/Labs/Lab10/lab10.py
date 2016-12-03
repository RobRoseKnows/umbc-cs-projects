# File:    lab10.py
# Author:  Robert Rose
# Date:    11/5/15
# Section: 11
# E-mail:  robrose2@umbc.edu
# Description:
# De/encyphers words

def main():
    print("""What would you like to do?
1. Encrypt String
2. Decrypt String""")
    choice = int(input("Enter 1 or 2: "))
    shiftBy = int(input("How much would you like to shift? (1-26) "))
    if(choice == 1):
        encrypt(shiftBy)
    if(choice == 2):
        decrypt(shiftBy)



def encrypt(n):
    """Encrypts a string using Caeser cipher."""
    encoded = ""
    toEncode = input("Enter plain text message: ")
    for char in toEncode:
        newChar = ord(char) + n
        if(newChar > ord("Z")):
            newChar = newChar - 26
        encoded += chr(newChar)
    print("Your encrypted message is:", encoded)



def decrypt(n):
    """Decrypts a string using Casear cipher."""
    decoded = ""
    toDecode = input("Enter plain text message: ")
    for char in toDecode:
        newChar = ord(char) - n
        if(newChar < ord("A")):
            newChar = newChar + 26
        decoded += chr(newChar)
    print("Your decrypted message is:", decoded)

main()
