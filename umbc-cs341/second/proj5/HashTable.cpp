/*
 * File:    HashTable.cpp
 * Name:    Robert Rose
 * Section: 1
 * Email:   robrose2@umbc.edu
 *
 * CMSC 341 Project 5
 *
 */

#include "HashTable.h"
#include "primes.h"

char * const HashTable::DELETED = (char *) 1;

//////////////////////////////////////////////////////
// Structors/Operators                              //
//////////////////////////////////////////////////////

HashTable::HashTable(int n): 
    m_H0Capacity(n), m_H1Capacity(-1), m_H2Capacity(-1),
    m_H0Size(0), m_H1Size(-1), m_H2Size(-1),
    m_H0LoadFactor(0), m_H1LoadFactor(-1),
    m_isRehashing(false) {

    H0 = new char*[n];
    H1 = NULL;
    H2 = NULL;

}



HashTable::~HashTable() {

    for(int i = 0; i < m_H0Capacity; i++)   free(H0[i]);
    for(int i = 0; i < m_H1Capacity; i++)   free(H1[i]);
    for(int i = 0; i < m_H2Capacity; i++)   free(H2[i]);

    delete [] H0;
    delete [] H1;
    delete [] H2;

}



HashTable(HashTable& other) {



}



const HashTable& operator=(HashTable& rhs) {



}



//////////////////////////////////////////////////////
// Methods                                          //
//////////////////////////////////////////////////////

unsigned int effectiveHash(const char *str, int table=0) {



}



void insert(const char *str) {



}



bool find(const char *str) {



}



char * remove(const char *str) {



}



// Finds a new capacity for the rehash table.
int findNewCapacity(unsigned int currSize) {

    int newSize = currSize * 4;
    
    if(newSize <= LOWER_BOUND) {
        newSize = 101;
    } else if(newSize > UPPER_BOUND) {
        throw TableTooLarge("New table would require > 199,999 items."); 
    } else {
        newSize = findPrime(newSize);
    }

    return newSize;

}



// Finds a prime number close to the new desired size. 
const int findPrime(int num) {

    int L = 0;
    int R = numPrimes - 1;

    int primeToReturn = 101;

    while(L <= R) {

        int M = L + (R - L) / 2;
        
        primeToReturn = primes[M];
        
        if(primes[M] < num) {
            L = M + 1;
        } else if(primes[M] > num) {
            R = M - 1;
        } else {
            return primeToReturn;
        }

    }

    return primeToReturn;

}



void freeTable(char** table, int size) {

    for(int i = 0; i < size; i++) {
        free(table[i]);
    }

    delete [] table;

}


//////////////////////////////////////////////////////
// Grading Methods                                  //
//////////////////////////////////////////////////////
 

int tableSize(int table=0) {

    switch(table) {
        case 0:
            return m_H0Capacity;
        case 1:
            return m_H1Capacity;
        case 2:
            return m_H2Capacity;
        default:
            return -1;
    }

}
    


int size(int table=0) {

    switch(table) {
        case 0:
            return m_H0Size;
        case 1:
            return m_H1Size;
        case 2:
            return m_H2Size;
        default:
            return -1;
    }

}



const char * at(int index, int table=0) {



}



//////////////////////////////////////////////////////
// Hash (H0) Methods                                //
//////////////////////////////////////////////////////

    void insertForH0(const char *str);

    bool findForH0(const char *str);

    char * removeForH0(const char *str);

//////////////////////////////////////////////////////
// ReHash (H1) Methods                              //
//////////////////////////////////////////////////////

    void insertForH1(const char *str);

    bool findForH1(const char *str);

    char * removeForH1(const char *str);
