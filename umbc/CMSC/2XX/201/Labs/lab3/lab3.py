# File:        lab3.py
# Author:      Robert Rose
# Date:        9/17/15
# Section:     11
# E-mail:      robrose2@umbc.edu
# Description: A miles per gallon calculator built in python

def main():
	miles = float(input("Input miles driven:"))
	gallons = float(input("Input gallons used:"))
	mpg = miles/gallons
	print("Your car goes", mpg, "miles per gallon")

main()

input("Press Enter to continue...")
