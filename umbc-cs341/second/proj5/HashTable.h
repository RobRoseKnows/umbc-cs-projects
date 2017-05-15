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

// The bounds for the hash table sizes.
#define UPPER_BOUND 199999
#define LOWER_BOUND 101

class TableTooLarge : public out_of_range {
    public:
        TableTooLarge(const string& what) : out_of_range(what) {}
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
// Primary Methods                                  //
//////////////////////////////////////////////////////

    unsigned int effectiveHash(const char *str, int table=0); 

    void insert(const char *str);

    bool find(const char *str);

    char * remove(const char *str);

//////////////////////////////////////////////////////
// Utility Methods                                  //
//////////////////////////////////////////////////////

    int findNewCapacity(unsigned int currSize);

    // Finds the closest prime greater than or equal to the provided num. 
    const int findPrime(int num);

    void freeTable(char** table, int size);

    // This is what's called when we try to make a copy of a table while
    // we're in the middle of rehashing it. In this case we don't need to
    // create the new tables we're rehashing into.
    void forceRehashDuringCopy();
    
    // This is used when we need to rehash during normal table operation.
    // First the section calling the rehash sets the rehashing flags
    // (m_isRehashing and/or m_isReRehashing) and then calls this function.
    // Unlike the copy rehashing fuction, this one creates the new tables
    // it will be rehashing into. 
    //
    // To be used if the load factor of the original table is < 3% or if the
    // rehash table's load factor exceeds 50%.
    void forceRehashNormal();
    
    int nextIndex(int index, int table=0);
    

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
// ReReHash (H2) Methods                            //
//////////////////////////////////////////////////////

    void insertForH2(const char *str);

    bool findForH2(const char *str);

    char * removeForH2(const char *str);

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
    bool m_isReRehashing;

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
