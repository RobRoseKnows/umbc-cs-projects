#ifndef _HASH_TABLE_H_
#define _HASH_TABLE_H_

/*
 * File:    HashTable.h
 * Name:    Robert Rose
 * Section: 1
 * Email:   robrose2@umbc.edu
 *
 * CMSC 341 Project 5
 *
 */

#include <stdexcept>
#include <stdlib.h>
#include <stdio.h>
#include <cstring>

class TableOutOfRange : public out_of_range {
    public:
        TableOutOfRange(const string& what) : out_of_range(what) {}
};



class HashTable {
// Since the example class with DELETED in the project description didn't use
// `public:` and `private:` I'm assuming we don't need to worry about that for
// this project.

//////////////////////////////////////////////////////
// Structors/Operators                              //
//////////////////////////////////////////////////////

    HashTable(int n=101);

    ~HashTable();

    HashTable(HashTable& other);

    const HashTable& operator=(HashTable& rhs);


//////////////////////////////////////////////////////
// Methods                                          //
//////////////////////////////////////////////////////

    unsigned int effectiveHash(const char *str, int table=0); 

    void insert(const char *str);

    bool find(const char *str);

    char * remove(const char *str);

    int findNewCapacity(unsigned int currSize);

    // Finds the closest prime greater than or equal to the provided num. 
    const int findPrime(int num);

//////////////////////////////////////////////////////
// Grading Methods                                  //
//////////////////////////////////////////////////////

    // Grading program
    bool isRehashing()  {   return m_isRehasing;    }
    
    int tableSize(int table=0);
    
    int size(int table=0);

    const char * at(int index, int table=0); 

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

//////////////////////////////////////////////////////
// Member Variables                                 //
////////////////////////////////////////////////////// 

    // Hash
    char ** H0;
    // ReHash
    char ** H1;
    // Hash and ReHash were on a boat, hash fell off, who was left?

    // If the rehash fails, give up and move everything to a new table.
    char ** H2;

    // Total number of items we can fit in each of the tables.
    unsigned int m_H0Capacity;
    unsigned int m_H1Capacity;
    unsigned int m_H2Capacity;

    // Total number of items currently in each table.
    unsigned int m_H0Size;
    unsigned int m_H1Size;
    unsigned int m_H2Size;

    // Load factors.
    double m_H0LoadFactor;
    double m_H1LoadFactor;

    bool m_isRehashing;


//////////////////////////////////////////////////////
// Given Values                                     //
//////////////////////////////////////////////////////

    static char * const DELETED; 
    
    // The hash code function defined in header file because it was given.
    unsigned int hashCode(const char *str) {

        unsigned int val = 0;
        const unsigned int thirtyThree = 33; // magic number from the textbook

        int i = 0;
        while(str[i] != '\0') {
            val = val * thirtyThree + str[i];
            i++;
        }
        
        return val;

    }
};



#endif
