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

char * const HashTable::DELETED = (char *) 1;

//////////////////////////////////////////////////////
// Structors/Operators                              //
//////////////////////////////////////////////////////

HashTable::HashTable(int n) {



}



HashTable::~HashTable() {



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



int findNewCapacity(unsigned int currSize) {



}



// Finds the closest prime greater than or equal to the provided num. 
const int findPrime(int num) {



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
