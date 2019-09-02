# File:    hw3_part5.py
# Author:  Robert Rose
# Date:    9/24/15
# Section: 11
# E-mail:  robrose2@umbc.edu
# Description:
# This program takes a day of the week and provides a basic estimate of the day
# of the week. (Assuming day 1 is a Monday)

def main():
     day = int( input("Please enter the day of the month:"))
     if(1 <= day <= 31):
         dayMod7 = day % 7
         if(dayMod7 == 1):
             print("Today is a Monday!")
         elif(dayMod7 == 2):
             print("Today is a Tuesday!")
         elif(dayMod7 == 3):
             print("Today is a Wednesday!")
         elif(dayMod7 == 4):
             print("Today is a Thursday!")
         elif(dayMod7 == 5):
             print("Today is a Friday!")
         elif(dayMod7 == 6):
             print("Today is a Saturday!")
         else:
             print("Today is a Sunday!")
     else:
         print("Invalid day!")

main()
