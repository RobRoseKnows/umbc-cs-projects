# There's some sort of error with find() I'm not sure what it is. As a result
# it will sometimes try to add the same thing to the table twice which causes
# a segfault. I'm going to go to office hours tomorrow, but I'm not sure if 
# that will help so I'm submitting tonight just in case.

CXX = g++
DEBUG = -g
FLAGS = -ansi -std=c++98 $(DEBUG)

test: myDriver.o Pinball.o
	$(CXX) $(FLAGS) myDriver.o Pinball.o -o a.out

med_test: MedTest.o Pinball.o
	$(CXX) $(FLAGS) MedTest.o Pinball.o -o med.out

small_test: SmallTest.o Pinball.o
	$(CXX) $(FLAGS) SmallTest.o Pinball.o -o small.out

myDriver.o: myDriver.cpp
	$(CXX) $(FLAGS) -c myDriver.cpp

MedTest.o: mediumtest.cpp
	$(CXX) $(FLAGS) -c mediumtest.cpp

SmallTest.o: smalltest.cpp
	$(CXX) $(FLAGS) -c smalltest.cpp

Pinball.o: Pinball.cpp Pinball.h
	$(CXX) $(FLAGS) -c Pinball.cpp

val:
	valgrind --leak-check=full ./a.out

run:
	./a.out $(INPUT) $(FLAG)

clean:
	rm -f *.o* *~ *.gch
