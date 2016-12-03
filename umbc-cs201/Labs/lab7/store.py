# File:    store.py
# Author:  Robert Rose
# Date:    10/15/15
# Section: 11
# E-mail:  robrose2@umbc.edu
# Description:
# Program prints items and allows users to purchase items.

def main():
    items = ["shoes", "socks", "hat", "belt", "blouse", "dress", "tie"]
    prices = [54.99,     7.11,  6.49,  22.58,    21.73,   38.99, 14.83]
    money = 100.00

    while(money > 0):
        print("You have $", money, "in ya pocket")
        
        for i in range(0, len(items)):
            print((i + 1), "-", items[i], "\t\t\t $", prices[i])
       
        itemRequested = int(input("Please choose an item # to purchase, or '0' to quit: "))
        if(itemRequested != 0):
            if(money >= prices[itemRequested - 1]):
                print("Thank you for purchasing:", items[itemRequested - 1])
                money -= prices[itemRequested - 1]
            else:
                print("Sorry, but you are unable to afford that item.")
        else:
            money = -9001
    print("Thank you for shopping at Python Shoppe")
        

main()
