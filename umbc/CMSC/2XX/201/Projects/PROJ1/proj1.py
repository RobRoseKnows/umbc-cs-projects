# File:        proj1.py
# Author:      Robert Rose
# Date:        11/10/15
# Section:     11
# E-mail:      robrose2@umbc.edu
# Description: This program is an implementation of Conway's game of life.
#              It takes relevant data from the user to construct a game
#              board and allows a user to cycle through the game.


LIVE = "A"
DEAD = "."

# Main function to run code.
def main():
    
    # Get number of rows on the board.
    rows = int(input("Please enter number of rows:\t"))
    while rows < 1:
        print("\tThat is not a valid value; please enter a number\n\tgreater than or equal to 1")
        rows = int(input("Please enter number of rows:\t"))

    # Get number of columns on the board.
    cols = int(input("Please enter number of columns:\t"))
    while cols < 1:
        print("\tThat is not a valid value; please enter a number\n\tgreater than or equal to 1\n")
        cols = int(input("Please enter number of columns:\t"))
    
    print("")
    
    board = constructBoard(cols, rows)

    # Set cells alive
    rowAlive = input("Please enter the row of a cell to turn on (or q to exit): ")
    while rowAlive != 'q':
        
        rowAlive = int(rowAlive)
        # Input validation
        while not (0 <= rowAlive < rows):
            print("\tThat is not a valid value; please enter a number\n\tbetween 0 and", rows - 1, "inclusive...\n")
            rowAlive = int(input("Please enter the row of a cell to turn on (or q to exit): "))
        
        colAlive = int(input("Enter a column for that cell: "))
        # Input validation
        while not (0 <= colAlive < cols):
            print("\tThat is not a valid value; please enter a number\n\tbetween 0 and", cols - 1, "inclusive...\n")
            colAlive = int(input("Please enter a column for that cell: "))
       
        board[rowAlive][colAlive] = LIVE
        print("")
        
        rowAlive = input("Please enter the row of a cell to turn on (or q to exit): ")
        
    print("")

    iterations = int(input("How many iterations should I run?: "))
    # Input validation
    while(iterations < 0):
        print("\tThat is not a valid value; please enter a number\n\tgreater than or equal to 0\n")
        iterations = int(input("How many iterations should I run?: "))
    
    print("Starting Board:\n")
    printBoard(board)
    print("")

    on = 0

    # Iteration time.
    while(on < iterations):
        on += 1
        print("Iteration", str(on) + ":\n")
        nextIteration(board)
        printBoard(board)
        if on != iterations:
            print("")

# Prints the contents of the board out using for loops.
def printBoard(board):
    for row in board:
        rowStr = ""
        for col in row:
            rowStr += col
        print(rowStr)

# Generates a board and fills it with periods
def constructBoard(width, height):
    board = [[DEAD for x in range(width)] for y in range(height)]
    return board

# Returns the number of live neighbors of a specified cell.
def liveNeighbors(board, x, y):
    count = 0

    # Check north west
    if(x > 0 and y > 0 and board[y - 1][x - 1] == LIVE):
        count += 1

    # Check north
    if(y > 0 and board[y - 1][x] == LIVE):
        count += 1
        
    # Check north east
    if(y > 0 and x < len(board[y]) - 1 and board[y - 1][x + 1] == LIVE):
        count += 1

    # Check east
    if(x < len(board[y]) - 1 and board[y][x + 1] == LIVE):
        count += 1

    # Check south east
    if(x < len(board[y]) - 1 and y < len(board) - 1 and board[y + 1][x + 1] == LIVE):
        count += 1

    # Check south
    if(y < len(board) - 1 and board[y + 1][x] == LIVE):
        count += 1

    # Check south west
    if(y < len(board) - 1 and x > 0 and board[y + 1][x - 1] == LIVE):
        count += 1

    # Check west
    if(x > 0 and board[y][x - 1] == LIVE):
        count += 1


    return count
        
# Checks to see if a cell is going to be alive or dead next generation based
# on the rules of the game.
def cellIsLive(neighborCount, liveNow):
    if(liveNow):
        if(neighborCount < 2):
            return False
        elif(2 <= neighborCount <= 3):
            return True
        elif(neighborCount > 3):
            return False
    else:
        if(neighborCount == 3):
            return True
        else:
            return False

# This performs each iteration on the board
def nextIteration(board):
    checkBoard = [row[:] for row in board]
    
    for y in range(len(checkBoard)):
        for x in range(len(checkBoard[y])):
            neighborCount = liveNeighbors(checkBoard, x, y) 
            if  cellIsLive(neighborCount, checkBoard[y][x] == LIVE):
                board[y][x] = LIVE
            else:
                board[y][x] = DEAD
    
main()
