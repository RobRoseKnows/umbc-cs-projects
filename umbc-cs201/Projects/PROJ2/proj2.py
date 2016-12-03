# File:    proj2.py
# Author:  Robert Rose
# Date:    12/4/15
# Section: 11
# E-mail:  robrose2@umbc.edu
# Description:
# An auto-fill program that runs recursively.

# String constant messages for filename request.
FILENAME_REQUEST = "Please enter a file for input: "
FILENAME_NOT_VALID = "That is not a valid filename -- please enter a filename\n\tthat ends in \".dat\" or \".txt\": "

# String constant messages for coordinate prompt with string formatting.
FIRST_COORDINATE_PROMPT = "Please enter the coordinates you would like to start\nfilling at in the form \"row,col\", or Q to quit: "
NEXT_COORDINATE_PROMPT = "Please enter the coordinates you would like to fill at\n\tin the form \"row,col\": "
BAD_ROW_COORDINATE = "\t{givenNum} is not a valid row value; please enter a number\n\tbetween 0 and {h} inclusive."
BAD_COL_COORDINATE = "\t{givenNum} is not a valid column value; please enter a number\n\tbetween 0 and {w} inclusive."

# String constant messages for symbol prompt with string formatting.
SYMBOL_PROMPT = "Please enter a symbol to fill with: "
BAD_SYMBOL = "\tThe symbol \"{sym}\" is not a single character."

# String constant messages for step choice with string formatting.
STEPS_PROMPT = "Would you like to show each step of the recusion?"
YN_PROMPT = "Enter \"yes\" or \"no\": "
BAD_ANSWER = "The choice \"{inpt}\" is not valid."

# Divisor line string constant
LINE = "============================================"

# The main function.
def main():
    grid = getGrid()
    printGrid(grid)
    
    coords = getCoordinates(len(grid), len(grid[0]))
    row = coords[0]
    col = coords[1]    

    while(not (row == -1 or col == -1)):
        
        symbol = getSymbol()
        showStepsBool = getShowSteps()
        
        # Print things
        print()
        autoFill(grid, row, col, symbol, showStepsBool)
        print(LINE + "\n")
        printGrid(grid)
        print()

        # Get new coordinates
        coords = getCoordinates(len(grid), len(grid[0]))
        row = coords[0]
        col = coords[1]
        
    # If user has input "Q" then requestCoordinates() will return -1
    if(row == -1 or col == -1):
        print("Thank you for using the autofill program!")
        return
    
    

# getGrid() asks for a valid filename until one is given and then returns a
# 2D array representing the grid.
# Returns: the 2D grid array
def getGrid():
    
    # Get a valid filename
    fileName = input(FILENAME_REQUEST)
    while(fileName[-4:] != ".dat" and fileName[-4:] != ".txt"):
        fileName = input(FILENAME_NOT_VALID)

    fileIn = open(fileName, "r")
    
    # Create an empty 2D array.
    gridOut = []
    
    lineOn = 0
    for line in fileIn:
        
        # Create the row
        gridOut.append([])
        
        line = line.strip()
        
        # Add the characters
        for char in line:
            gridOut[lineOn].append(char)
        lineOn += 1

    fileIn.close()

    return gridOut

# printGrid() prints the grid
# Input: the grid in a 2D array
def printGrid(arrayIn):
    for line in arrayIn:
        lineText = ""
        for char in line:
            lineText += char
        print(lineText)

# getSymbol() prompts a user for a single character until one is provided.
# Returns: a single character
def getSymbol():
    symbol = input(SYMBOL_PROMPT)
    while(len(symbol) != 1):
        print(BAD_SYMBOL.format(sym=symbol))
        symbol = input(SYMBOL_PROMPT)
    return symbol

# getCoordinates() asks a user to input a row and column value and does so 
# until valid coordinates are entered. If "Q" is entered it will return
# (-1, -1) so the program will be able to quit.
# Input:   the height and width of the grid
# Returns: a tuple containing the row and column
def getCoordinates(height, width):

    # Request coords
    coordinates = input(FIRST_COORDINATE_PROMPT)
    if(coordinates == "Q"):
        return (-1, -1)
    coordArray = coordinates.split(',')
    row = int(coordArray[0])
    col = int(coordArray[1])

    # Confirm coords
    while(not ((0 <= row < height) and (0 <= col < width))):
        # Check to see if valid row coord
        if(not (0 <= row < height)):
            print(BAD_ROW_COORDINATE.format(givenNum=row, h=(height - 1)))
        # Check to see if valid col coord
        if(not (0 <= col < width)):
            print(BAD_COL_COORDINATE.format(givenNum=col, w=(width - 1)))
        # Request coords
        coordinates = input(NEXT_COORDINATE_PROMPT)
        if(coordinates == "Q"):
            return (-1, -1)
        coordArray = coordinates.split(',')
        row = int(coordArray[0])
        col = int(coordArray[1])
    
    # Yay! Tuples!
    return (row, col)

# getShowSteps() asks a user whether they want to show the steps of the
# recursion until they provide a valid answer.
# Returns: A boolean as to whether steps should be shown
def getShowSteps():

    # Ask
    print(STEPS_PROMPT)
    answer = input(YN_PROMPT)

    # Continue asking
    while(not (answer == "yes" or answer == "no")):
        print(BAD_ANSWER.format(inpt=answer))
        print(STEPS_PROMPT)
        answer = input(YN_PROMPT)
        
    # Set the boolean answer
    answerBool = False
    if(answer == "yes"):
        answerBool = True
    else:
        answerBool = False
        
    return answerBool

# autoFill() fills the grid recursively starting from a given row and column
# Input: the grid, row coordinate, col coordinate, symbol to fill with, boolean
#        to tell if we need to fill or not.
def autoFill(grid, row, col, symbol, showSteps):
    
    # Check to see if cell is empty.
    if(grid[row][col] != " "):
        return
    
    # Set the cell equal to the symbol and print the grid if applicable.
    grid[row][col] = symbol
    if(showSteps):
        printGrid(grid)
        print()
    
    # Above
    autoFill(grid, row - 1, col, symbol, showSteps)
    
    # Right
    autoFill(grid, row, col + 1, symbol, showSteps)
    
    # Below
    autoFill(grid, row + 1, col, symbol, showSteps)
    
    # Left
    autoFill(grid, row, col - 1, symbol, showSteps)

main()
