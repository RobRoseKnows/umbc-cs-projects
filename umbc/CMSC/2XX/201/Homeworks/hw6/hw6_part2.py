# FIle:    hw6_part2.py
# Author:  Robert Rose
# Date:    10/22/15
# Section: 11
# E-mail:  robrose2@umbc.edu
# Description:
# Program asks users for a file with grades and weights and calculates the
# weighted grade.

def main():
    totalGrade = 0
    
    # Get file name and open it
    fileName = input("File name: ")
    fileGrades = open(fileName, "r")
    
    # Iterate over each line in the file.
    for line in fileGrades:
        lineList = line.split(" ")
        weight = float(lineList[0])
        lineGrade = 0
        
        # Iterate through everything else on the line
        for grade in lineList[1:]:
            lineGrade += int(grade)
        
        totalGrade += (lineGrade / (len(lineList) - 1)) * weight
        
    fileGrades.close()
    print("Your final weighted score is", totalGrade)    

main()
