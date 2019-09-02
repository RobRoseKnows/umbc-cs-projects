# File:    hw3_part2.py
# Author:  Robert Rose
# Date:    9/22/15
# Section: 11
# E-mail:  robrose2@umbc.edu
# Description:
# This program calculates grades based on the input of homework, exam and
# discussion weights and grades.

def main():
    homeworkWeight = float(input("Homework weight:"))
    homeworkGrade = float(input("Homework grade:"))
    examWeight = float(input("Exam weight:"))
    examGrade = float(input("Exam grade:"))
    discussionWeight = float(input("Discussion weight:"))
    discussionGrade = float(input("Discussion grade:"))
    
    grade = homeworkWeight * homeworkGrade
    grade = grade + examWeight * examGrade
    grade = grade + discussionWeight * discussionGrade
    
    print("The final numerical grade is:", grade)
    letterGrade = getLetterGrade(grade)
    print("This earns you a", letterGrade, "in the class.")

# getLetterGrade(string) returns the correct letter grade from a percentage
# Input:  the numerical grade
# Output: the letter grade
def getLetterGrade(grade):
    letterGrade = ""
    if 100 >= grade >= 90:
        letterGrade = "A"
    elif 90 > grade >= 80:
        letterGrade = "B"
    elif 80 > grade >= 70:
        letterGrade = "C"
    elif 70 > grade >= 60:
        letterGrade = "D"
    else:
        letterGrade = "F"
    return letterGrade

main()
