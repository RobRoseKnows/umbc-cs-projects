# File:    hw3_part1.py
# Author:  Robert Rose
# Date:    9/22/15
# Section: 11
# E-mail:  robrose2@umbc.edu
# Description:
# Part One of Homework 3 takes a user input of 3 floats and outputs the
# average.

def main():
    float1 = float(input("Please enter a floating point number:"))
    float2 = float(input("Please enter a floating point number:"))
    float3 = float(input("Please enter a floating point number:"))
    sumFloats = float1 + float2 + float3
    average = sumFloats / 3
    print("The average of the three floats is:", average)

main()
