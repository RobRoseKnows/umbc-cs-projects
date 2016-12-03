# File:    temperature.py
# Author:  Robert Rose
# Date:    9/24/15
# Section: 11
# E-mail:  robrose2@umbc.edu
# Description:
# Program takes the temperature in Fahrenheit and prints a statement relevant
# to the weather.

def main():
    temp = int(input("Please enter a temperature in Fahrenheit:"))
    if temp < 25:
        print("It's freezing outside.")
    elif 25 <= temp <= 49:
        print("It's a bit chilly, remember to bundle up.");
    elif 50 <= temp <= 79:
        print("The weather is wonderful!")
    elif 80 <= temp <= 100:
        print("It's pretty hot outside")
    else:
        print("It is way too hot.")

main()
