# FIle:    hw6_part1.py
# Author:  Robert Rose
# Date:    10/22/15
# Section: 11
# E-mail:  robrose2@umbc.edu
# Description:
# Program reads an arbitrary number of names and prints them into a file.

def main():
    # Get first name
    nameIn = input("Insert name: ")
   
    # Create file
    printFile = open("names.txt", "w")
   
    while(nameIn != "DONE"):
        printFile.write("Hello " + nameIn + "!\n")
        nameIn = input("Insert name: ")
    
    # Close the file
    printFile.close()
        

main()
