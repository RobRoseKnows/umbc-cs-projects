# File:    hw7.py
# Author:  Robert Rose
# Date:    10/28/15
# Section: 11
# E-mail:  robrose2@umbc.edu
# Description:
# This is a multipurpose calculator program that allows a user to input a
# list of integers and find useful statistics from them.


def main():
    print("Welcome to the List Statistics Caclulator")
    userList = getList()
    
    while(len(userList) == 0):
        print("I can't let you do that. Please input integers.")
        userList = getList()

    printMenu()
    userChoice = input("Please enter your choice, or 0 to exit: ")
    
    while(userChoice != "0"):
        if(userChoice == "1"):
            val = getMin(userList)
            print("The minimum value is", val)
        
        elif(userChoice == "2"):
            val = getMax(userList)
            print("The maximum value is", val)

        elif(userChoice == "3"):
            val = getMean(userList)
            print("The mean value is", val)

        elif(userChoice == "4"):
            val = getMedian(userList)
            print("The median value is", val)

        elif(userChoice == "5"):
            userList = emptyList(userList)

        else:
            print("That is not a valid option.")
        
        printMenu()
        userChoice = input("Please choose the statistic you would like to calculate: ")
    print("Thank you for using our calculator")

# Prints the menu
def printMenu():
    menu = """
Please choose the statistic you would like to calculate!
1. Min
2. Max
3. Mean
4. Median
5. Clear list
0. Exit
"""
    print(menu)

# getList allows users to input an arbitrarily large list of integers using a while loop
def getList():
    newList = []
    print("Enter a list of integers or 'q' to end the list.")
    enteredNumber = input("Enter an integer: ")
    
    while(enteredNumber != 'q'):
        if(enteredNumber != ''):
            # Do thing with previous input
            newList.append(int(enteredNumber))
            
        else:
            # If user doesn't input anything, try again.
            print("Invalid. Please provide an integer.")
        
        # Ask for new input
        enteredNumber = input("Enter an integer: ")
    
    return newList


# Finds the max value in a given list
def getMax(userList):
    max = userList[0]

    for val in userList:
        if(val > max):
            max = val
    
    return max

# Finds the min value in a given list
def getMin(userList):
    min = userList[0]
    
    for val in userList:
        if(val < min):
            min = val
            
    return min

# Get the median using math, not for loops (Professor Dixon said that was alright).
def getMedian(userList):
    sortedList = userList
    sortedList.sort()
    
    if(len(sortedList) % 2 == 1):
        med = sortedList[len(sortedList) // 2]
    else:
        # If there's an even number of items in the list, get the average between the centermost numbers.
        leftOfCenter = sortedList[len(sortedList) // 2 - 1]
        rightOfCenter = sortedList[len(sortedList) // 2]
        med = (leftOfCenter + rightOfCenter) / 2
    
    return med

# Gets the mean using for loops.
def getMean(userList):
    sumList = 0
    for val in userList:
        sumList += val
    return sumList / len(userList)

# Empties the list by setting it to an empty list.
def emptyList(userList):
    newList = getList()
    while(len(newList) == 0):
        print("I can't let you do that. Please enter at least one integer.")
        newList = getList()
    return newList

main()
