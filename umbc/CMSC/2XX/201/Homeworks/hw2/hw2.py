# File:    hw2.py
# Author:  Robert Rose
# Date:    9/12/15
# Section: 11
# Email:   robrose2@umbc.edu
# Description:
# This file contains mathmatical expressions as
# part of Homework 1.

print("Robert Rose")
print("Various math problem solutions as part of Homework 1.")

# Question 1:
# Expected output: 24
num1 = (7 + 1) * 3
print("Question 1 evaluates to:", num1)
# Actual output: 24
# Explanation: Parentheses first (8), then multiplication (24)

# Question 2:
# Expected output: 2
num2 = (12 % 5)
print("Question 2 evaluates to:", num2)
# Actual output: 2
# Explanation: Remainder of 12 / 5 is 2.

# Question 3:
# Expected output: 21
num3 = (21 % 49)
print("Question 3 evaluates to:", num3)
# Actual output: 21
# Explanation: 21 / 49 = 0, remainder 21.

# Question 4:
# Expected output: 2
num4 = (5 - 3) + (10 - 5) * (8 % 2)
print("Question 4 evaluates to:", num4)
# Actual output: 2
# Explanation: Parentheses first (2, 5, 0), then multiplaction (0), then
# addition (2)

# Question 5:
# Expected output: 34.0
num5 = 6.5 + 5 / 2 * (4 + 7)
print("Question 5 evaluates to:", num5)
# Actual output: 34.0
# Explanation: Parantheses first (11), then division (2.5), then
# multiplacation (27.5), then addition (34)

# Question 6:
# Expected output: 5.0
num6 = 9 / 3 + 18 - 4 * 4
print("Question 6 evaluates to:", num6)
# Actual output: 5.0
# Explanation: First division (3), then multiplication (16), then
# addition (21), then subtraction (5)

# Question 7:
# Expected output: 22
num7 = 8 % 3 + 5 * 4
print("Question 7 evaluates to:", num7)
# Actual output: 22
# Explanation: Frist multiplication (20), then mod (2), then
# addition (22)

# Question 8:
# Expected output: 79.914...
num8 = 81.3 / 2.1 + ((51.5 % 65.2) * 2 / 2.5)
print("Question 8 evaluates to:", num8)
# Actual output: 79.91428571428571
# Explanation: First parantheses (51.5), then parantheses multiplication (103),
# then parantheses division (41.2), then division (38.714...), then
# addition (79.914...)

# Question 9:
# Given equation: 100 - 8 * 8 + 1 / 0.5
# Solved equation: 100 - ((8 * 8 + 1) / 0.5)
# Target number: -30
num9 = 100 - ((8 * 8 + 1) / 0.5)
target9 = -30
print("Question 9 evaluates to:", num9, "and should be", target9)

# Question 10:
# Given equation: 84 / 10 + 11 - 4 * 4
# Solved equation: (84 / (10 + 11) - 4) * 4
# Target number: 0
num10 = (84 / (10 + 11) - 4) * 4
target10 = 0
print("Question 10 evaluates to:", num10, "and should be", target10)
