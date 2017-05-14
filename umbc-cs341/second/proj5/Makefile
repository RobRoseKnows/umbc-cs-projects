# File:		Makefile
# Name: 	Robert Rose
# Email:	robrose2@umbc.edu
#
# CMSC 341 Spring 2017 Project 4

CXX = g++
DEBUG = -g
CPPFLAGS = -Wall -ansi -std=c++98 $(DEBUG)
PRIM_OBJS = HashTable.o Driver.o

all: $(PRIM_OBJS)
	$(CXX) $(CPPFLAGS) $(PRIM_OBJS) -o a.out

test%.out: HashTable.o test%.o 
	$(CXX) $(CPPFLAGS) $^ -o $@

val: all
	valgrind --leak-check=full ./a.out

run: all
	./a.out

fresh: clean run

clean:
	rm -f *.o *.out *~ *.gch
