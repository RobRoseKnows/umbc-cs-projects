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
    m_isRehashing(false), m_isReRehashing(false) {

    H0 = new char*[n];
    H1 = NULL;
    H2 = NULL;

    for(int i = 0; i < m_H0Capacity; i++) {
        H0[i] = NULL;
    }

}



HashTable::~HashTable() {

    freeTable(H0, m_H0Capacity);
    freeTable(H1, m_H1Capacity);
    freeTable(H2, m_H2Capacity);

}



HashTable::HashTable(HashTable& other) {
    m_H0Capacity    = other.m_H0Capacity;
    m_H1Capacity    = other.m_H1Capacity;
    m_H2Capacity    = other.m_H2Capacity;
    m_H0Size        = other.m_H0Size;
    m_H1Size        = other.m_H1Size;
    m_H2Size        = other.m_H2Size;
    m_H0LoadFactor  = other.m_H0LoadFactor;
    m_H1LoadFactor  = other.m_H1LoadFactor;
    m_isRehashing   = other.m_isRehashing;
    m_isReRehashing = other.m_isReRehashing;

    if(!other.m_isRehashing) {

        H0 = new char*[other.m_H0Capacity];
        H1 = NULL;
        H2 = NULL;

        for(int i = 0; i < other.m_H0Capacity) {
            H0[i] = strcpy(other.H0[i]);
        }

    } else {



    }

}



const HashTable& HashTable::operator=(HashTable& rhs) {



}



//////////////////////////////////////////////////////
// Primary Methods                                  //
//////////////////////////////////////////////////////

int HashTable::effectiveHash(const char *str, int table=0) {

    switch(table) {
        case 0:
            return hashCode(str) % m_H0Capacity;
        case 1:
            return hashCode(str) % m_H1Capacity;
        case 2:
            return hashCode(str) % m_H2Capacity;
        default:
            return 0;
    }

}



void HashTable::insert(const char *str) {



}



bool HashTable::find(const char *str) {



}



char * HashTable::remove(const char *str) {



}



//////////////////////////////////////////////////////
// Utility Methods                                  //
//////////////////////////////////////////////////////

// Finds a new capacity for the rehash table.
int HashTable::findNewCapacity(unsigned int currSize) {

    int newSize = currSize * 4;
    
    if(newSize <= LOWER_BOUND) {
        newSize = LOWER_BOUND;
    } else if(newSize > UPPER_BOUND) {
        throw TableTooLarge("New table would require > 199,999 items."); 
    } else {
        newSize = findPrime(newSize);
    }

    return newSize;

}



// Finds a prime number close to the new desired size. 
const int HashTable::findPrime(int num) {

    int L = 0;
    int R = numPrimes - 1;

    int primeToReturn = LOWER_BOUND;

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


// Utility function to free all the memory in an array and then deallocate 
// the array.
void HashTable::freeTable(char** table, int size) {

    for(int i = 0; i < size; i++) {
        free(table[i]);
    }

    delete [] table;

}


// Called by another table when we try to copy this table while it's
// rehashing.
void HashTable::forceRehashDuringCopy() {

    if(m_isRehashing && !m_isReRehashing) {
        
        int i = 0;

        while(i < m_H0Capacity) {
    
            if(H0[i] != NULL) {
                insertForH1(H0[i]);
            }
            
            // This checks to see if H1 got turned into NULL. This will mean
            // that while we were trying to force a rehash into H1, a 
            // rerehash got triggered and then completed during the insert 
            // call. We will then want to stop doing our rehash into H1 
            // and return.
            if(H1 == NULL)  return;

            i++;

        }


        // Transfer everything.
        H0 = H1;


        // Clean up
        freeTable(H1, m_H1Capacity);

        m_isRehashing = false;

        m_H1Capacity = -1;
        m_H1Size = -1;
    
    } else if (m_isRehashing && m_isReRehashing) {

        int iH0 = 0;

        // Go through original hashtable
        while(iH0 < m_H0Capacity) {

            if(H0[iH0] != NULL) {
                insertForH2(H0[iH0])
            }

            iH0++;

        }

        int iH1 = 0;

        // Go through rehash hashtable.
        while(iH1 < m_H1Capacity) {

            if(H1[iH1] != NULL) {
                insertForH2(H1[iH1])
            }

            iH1++;

        }


        // Transfer everything to new table.
        H0 = H2;


        // Clean up
        freeTable(H1, m_H1Capacity);
        freeTable(H2, m_H2Capacity);

        m_isRehashing = false;
        m_isReRehashing = false;
        
        m_H1Capacity = -1;
        m_H1Size = -1;

        m_H2Capacity = -1;
        m_H2Size = -1;
    
    }
}


// This is called when the load factor of H0 is less than 3% or when the load
// factor of H1 passes 50%.
void HashTable::forceRehashNormal() {

    if(m_isRehashing && !m_isReRehashing) {
       
        // We don't create a new table 1 here because Table 1 should have
        // already been created and this should only be called when the load
        // factor of the original table is less than 3%.

        int i = 0;

        while(i < m_H0Capacity) {
    
            if(H0[i] != NULL) {
                insertForH1(H0[i]);
            }
            
            // This checks to see if H1 got turned into NULL. This will mean
            // that while we were trying to force a rehash into H1, a 
            // rerehash got triggered and then completed during the insert 
            // call. We will then want to stop doing our rehash into H1 
            // and return.
            if(H1 == NULL)  return;

            // This has to be the iterator instead of the wrap around
            // nextIndex() method because otherwise it will enter an infinite
            // loop.
            i++;

        }


        // Transfer everything to new table.
        H0 = H1;


        // Clean up Table 1
        freeTable(H1, m_H1Capacity);

        m_isRehashing = false;
        
        m_H1Capacity = -1;
        m_H1Size = -1;

    } else if (m_isRehashing && m_isReRehashing) {

        // This is all for creating a new Table 2 so we can insert everything
        // into it.

        m_H2Capacity = findNewCapacity(m_H0Capacity + m_H1Capacity);
        m_H2Size = 0;
        
        H2 = new char*[m_H2Capacity];



        int iH0 = 0;

        // Go through original hashtable
        while(iH0 < m_H0Capacity) {

            if(H0[iH0] != NULL) {
                insertForH2(H0[iH0])
            }

            iH0++;

        }



        int iH1 = 0;

        // Go through rehash hashtable.
        while(iH1 < m_H1Capacity) {

            if(H1[iH1] != NULL) {
                insertForH2(H1[iH1])
            }

            iH1++;

        }


        // Transfer everything from the intermediate table 2 to Table 0.
        H0 = H2;


        // Clean up the other two tables because we don't neeed them anymore
        freeTable(H1, m_H1Capacity);
        freeTable(H2, m_H2Capacity);
        
        m_isRehashing = false;
        m_isReRehashing = false;
        
        m_H1Capacity = -1;
        m_H1Size = -1;

        m_H2Capacity = -1;
        m_H2Size = -1;

    }


}


int HashTable::nextIndex(int index, int table) {

    int size = tableSize(table);

    index++;

    if(index > size)
        index = 0;

    return index;

}


//////////////////////////////////////////////////////
// Grading Methods                                  //
//////////////////////////////////////////////////////
 

int HashTable::tableSize(int table) {

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
    


int HashTable::size(int table) {

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



const char * HashTable::at(int index, int table) {

    switch(table) {
        case 0:
            return H0[index];
        case 1:
            return H1[index];
        case 2:
            return H2[index];
        default:
            return NULL;
    }

}



//////////////////////////////////////////////////////
// Hash (H0) Methods                                //
//////////////////////////////////////////////////////

void HashTable::insertForH0(const char *str) {

    if(m_H0LoadFactor > .5) {
    
        initRehash();
        insertForH1(str);
        
        // Return because there's nothing else we need to do.
        return;
    
    }

    int index = effectiveHash();
    int probeLen = 0;

    while(probeLen < MAX_PROBE_LEN) {



        index = nextIndex(index, H0_TABLE_NUM)
    }


    m_H0LoadFactor = (m_H0Size / m_H0Capacity);

}

bool HashTable::findForH0(const char *str) {
    
    if(m_H0LoadFactor > .5) {
        initRehash();
    }



    m_H0LoadFactor = (m_H0Size / m_H0Capacity);

}

char * HashTable::removeForH0(const char *str) {

    if(m_H0LoadFactor > .5) {
        initRehash();
    }



    m_H0LoadFactor = (m_H0Size / m_H0Capacity);

}

void HashTable::initRehash() {

    m_isRehashing = true;

    m_H1Capacity = findNewCapacity(m_H0Capacity);
    m_H1Size = 0;
        
    H1 = new char*[m_H1Capacity];

    for(int i = 0; i < m_H1Capacity; i++)
        H1[i] = NULL;

}

//////////////////////////////////////////////////////
// ReHash (H1) Methods                              //
//////////////////////////////////////////////////////

void HashTable::insertForH1(const char *str);

bool HashTable::findForH1(const char *str);

char * HashTable::removeForH1(const char *str);

//////////////////////////////////////////////////////
// ReReHash (H2) Methods                            //
//////////////////////////////////////////////////////

void HashTable::insertForH2(const char *str);

bool HashTable::findForH2(const char *str);

char * HashTable::removeForH2(const char *str);


