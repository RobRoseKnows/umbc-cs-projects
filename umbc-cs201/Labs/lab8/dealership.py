# File:    dealership.py
# Author:  Robert Rose
# Date:    10/22/15
# Section: 11
# E-mail:  robrose2@umbc.edu
# Description:
# This program is a used car lot.

def main():
    dataFile = open("cars.txt", "r")
    outputFile = open("results.txt", "w")
    
    for line in dataFile:
        properties = line.split(",")
        propName = properties[0]
        propColor = properties[1]
        propDoors = int(properties[2])
        propCupHolders = int(properties[3])
        propPrice = int(properties[4])
        if(propColor == "red" and propDoors == 4 and propPrice < 30000):
            outputFile.write(propName + ": $" + str(propPrice) + "\n")

    dataFile.close()
    outputFile.close()

    

main()
