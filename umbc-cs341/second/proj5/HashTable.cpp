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

#include <iostream>

char * const HashTable::DELETED = (char *) 1;

//////////////////////////////////////////////////////////////////
// Structors/Operators                                          //
//////////////////////////////////////////////////////////////////

HashTable::HashTable(int n): 
    m_H0Capacity(n), m_H1Capacity(-1), m_H2Capacity(-1),
    m_H0Size(0), m_H1Size(-1), m_H2Size(-1),
    m_H0LoadFactor(0), m_H1LoadFactor(-1),
    m_isRehashing(false), m_isReRehashing(false) {

    H0 = new char * [n];
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

    if(other.m_isRehashing) {
        other.forceRehashDuringCopy();
    }

    H0 = new char * [other.m_H0Capacity];
    H1 = NULL;
    H2 = NULL;

    for(int i = 0; i < other.m_H0Capacity; i++) {
        if(H0[i] != DELETED && H0[i] != NULL) {
            H0[i] = strdup(other.H0[i]);
        } else if(H0[i] != NULL){
            H0[i] = DELETED;
        } else {
            H0[i] = NULL;
        }
    }
}



const HashTable& HashTable::operator=(HashTable& rhs) {

    freeTable(H0, m_H0Capacity);
    freeTable(H1, m_H1Capacity);
    freeTable(H2, m_H2Capacity);
        
    m_H0Capacity    = rhs.m_H0Capacity;
    m_H1Capacity    = rhs.m_H1Capacity;
    m_H2Capacity    = rhs.m_H2Capacity;
    m_H0Size        = rhs.m_H0Size;
    m_H1Size        = rhs.m_H1Size;
    m_H2Size        = rhs.m_H2Size;
    m_H0LoadFactor  = rhs.m_H0LoadFactor;
    m_H1LoadFactor  = rhs.m_H1LoadFactor;
    m_isRehashing   = rhs.m_isRehashing;
    m_isReRehashing = rhs.m_isReRehashing;

    if(rhs.m_isRehashing) {
        rhs.forceRehashDuringCopy();
    }


    H0 = new char * [rhs.m_H0Capacity];
    H1 = NULL;
    H2 = NULL;

    for(int i = 0; i < rhs.m_H0Capacity; i++) {
        if(H0[i] != DELETED && H0[i] != NULL) {
            H0[i] = strdup(rhs.H0[i]);
        } else if(H0[i] != NULL){
            H0[i] = DELETED;
        } else {
            H0[i] = NULL;
        }
    }

    return *this;

}



//////////////////////////////////////////////////////////////////
// Primary Methods                                              //
//////////////////////////////////////////////////////////////////

int HashTable::effectiveHash(const char *str, int table) {

    switch(table) {
        case H0_TABLE_NUM:
            return (hashCode(str) % m_H0Capacity);
        case H1_TABLE_NUM:
            return (hashCode(str) % m_H1Capacity);
        case H2_TABLE_NUM:
            return (hashCode(str) % m_H2Capacity);
        default:
            return 0;
    }

}



void HashTable::insert(const char *str) {

    char *newStr = strdup(str);

    if(!m_isRehashing && m_H0LoadFactor > .5) {
        initRehash();
    } else if(m_isRehashing && m_H0LoadFactor < .03) {
        forceRehashNormal();
    } else if(m_isRehashing && m_H1LoadFactor > .5) {
        initReRehash();
    }

    if(m_isRehashing && find(newStr)){ 
        // It's already in the first table, we don't want to insert it again. 
        // Shortcircuiting means we won't do an unneccessary find if we are
        // not in the process of rehashing.
        return;
    } else if(m_isRehashing) {
        // If it's not already in the first table but we are rehashing the
        // table, insert the thing into the second table.
        insertIntoH1(newStr);
    } else {
        // Otherwise just insert into the base table.
        insertIntoH0(newStr);
    }

}



bool HashTable::find(const char *str) {

    if(!m_isRehashing && m_H0LoadFactor > .5) {
        initRehash();
    } else if(m_isRehashing && m_H0LoadFactor < .03) {
        forceRehashNormal();
    } else if(m_isRehashing && m_H1LoadFactor > .5) {
        initReRehash();
    }

    return findInH0(str);

}



char * HashTable::remove(const char *str) {

    if(!m_isRehashing && m_H0LoadFactor > .5) {
        initRehash();
    } else if(m_isRehashing && m_H0LoadFactor < .03) {
        forceRehashNormal();
    } else if(m_isRehashing && m_H1LoadFactor > .5) {
        initReRehash();
    }
    
    return removeFromH0(str);

}



//////////////////////////////////////////////////////////////////
// Utility Methods                                              //
//////////////////////////////////////////////////////////////////

// Finds a new capacity for the rehash table.
int HashTable::findNewCapacity(int currSize) { 

    int newSize = currSize * 4;
    
    if(newSize <= LOWER_BOUND) {
        newSize = LOWER_BOUND;
    } else if(newSize > UPPER_BOUND) {
        throw TableTooLarge("New table would require > 199,999 items."); 
    } else {
        newSize = findPrime(newSize);
    }

    //cout << "NC: curr: " << currSize << " new: " << newSize << endl;

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
        if(table[i] != DELETED && table[i] != NULL) {
            //free(table[i]);
        }
    }

    delete [] table;

}


// Called by another table when we try to copy this table while it's
// rehashing.
void HashTable::forceRehashDuringCopy() {

    //cout << "Force rehash during copy." << endl;

    if(m_isRehashing && !m_isReRehashing) {
        
        int i = 0;

        while(i < m_H0Capacity) {
    
            // I don't need to do any fancy conditionals here because if 
            // it needs to be moved to another table, the insert function
            // will do that on its own (or at least set up what needs to
            // be done).
            if(H0[i] != NULL && H0[i] != DELETED) {
                insertIntoH1(H0[i]);
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

            if(H0[iH0] != NULL && H0[iH0] != DELETED) {
                insertIntoH2(H0[iH0]);
            }

            iH0++;

        }

        int iH1 = 0;

        // Go through rehash hashtable.
        while(iH1 < m_H1Capacity) {

            if(H1[iH1] != NULL && H1[iH1] != DELETED) {
                insertIntoH2(H1[iH1]);
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

    //cout << "Force rehash normal" << endl;

    if(m_isRehashing && !m_isReRehashing) {
       
        // We don't create a new table 1 here because Table 1 should have
        // already been created and this should only be called when the load
        // factor of the original table is less than 3%.

        int i = 0;

        while(i < m_H0Capacity) {
    
            if(H0[i] != NULL && H0[i] == DELETED) {
                insertIntoH1(H0[i]);
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

        m_H2Capacity = findNewCapacity(m_H0Size + m_H1Size);
        m_H2Size = 0;

        H2 = new char*[m_H2Capacity];

        int iH0 = 0;

        // Go through original hashtable
        while(iH0 < m_H0Capacity) {

            if(H0[iH0] != NULL && H0[iH0] != DELETED) {
                insertIntoH2(H0[iH0]);
            }

            iH0++;

        }



        int iH1 = 0;

        // Go through rehash hashtable.
        while(iH1 < m_H1Capacity) {

            if(H1[iH1] != NULL && H1[iH1] != DELETED) {
                insertIntoH2(H1[iH1]);
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


int HashTable::prevIndex(int index, int table) {

    int size = tableSize(table);

    index--;

    if(index < 0)
        index = size - 1;

    return index;

}



//////////////////////////////////////////////////////////////////
// Grading Methods                                              //
//////////////////////////////////////////////////////////////////
 

int HashTable::tableSize(int table) {

    switch(table) {
        case H0_TABLE_NUM:
            return m_H0Capacity;
        case H1_TABLE_NUM:
            return m_H1Capacity;
        case H2_TABLE_NUM:
            return m_H2Capacity;
        default:
            return -1;
    }

}
    


int HashTable::size(int table) {

    switch(table) {
        case H0_TABLE_NUM:
            return m_H0Size;
        case H1_TABLE_NUM:
            return m_H1Size;
        case H2_TABLE_NUM:
            return m_H2Size;
        default:
            return -1;
    }

}



const char * HashTable::at(int index, int table) {

    switch(table) {
        case H0_TABLE_NUM:
            return H0[index];
        case H1_TABLE_NUM:
            return H1[index];
        case H2_TABLE_NUM:
            return H2[index];
        default:
            return NULL;
    }

}



//////////////////////////////////////////////////////////////////
// Hash (H0) Methods                                            //
//////////////////////////////////////////////////////////////////

void HashTable::insertIntoH0(char *str) {


    bool added = false;

    // If it's not rehashing, go down in here and insert it here. If it is, 
    // it will insert the item into H1 below this if statement in another one
    // that checks whether or not it has been added.
    if(!m_isRehashing) {

        int index = hashH0(str);
        int probeLen = 0;

        // Keep going until we either add it or we go too far.
        while(!added && probeLen < MAX_PROBE_LEN) {

            if(H0[index] == NULL || H0[index] == DELETED) {

                added = true;
                H0[index] = str;
                m_H0Size++;

            }

            // Next index is given by a method so we can wrap around properly.
            index = nextH0(index);

            probeLen++;

        }

        // If the cluster is to big, init rehashing.
        if(probeLen >= MAX_PROBE_LEN) {
            initRehash();
        }

    }

    // If we didn't find the thing we wanted but we are rehashing, go check
    // the next table too.
    if(!added) {

        initRehash();
        insertIntoH1(str);

    }



    if(m_isRehashing) {
        moveH0ClusterAt(hashH0(str));
    }

    m_H0LoadFactor = (((double) m_H0Size) / m_H0Capacity);

}


//////////////////////////////////////////////////////
//
//
bool HashTable::findInH0(const char *str) {
   
    bool isFound = false;


    int index = hashH0(str);
    int probeLen = 0;

    // Keep going until we either add it or we go too far.
    while(H0[index] != NULL && !isFound && probeLen < MAX_PROBE_LEN) {

        if(H0[index] != DELETED && strcmp(H0[index], str) == 0) {

            isFound = true;

        }

        // Next index is given by a method so we can wrap around properly.
        index = nextH0(index);

        probeLen++;

    }

    // If the cluster is to big, init rehashing.
    if(probeLen >= MAX_PROBE_LEN) {
        initRehash();
    }


    // If we didn't actually add anything, we need to rehash because the
    if(!isFound && m_isRehashing) {

        if(H1 != NULL) {
            isFound = findInH1(str);
        } else {
            isFound = false;
        }
    }



    // Move cluster to new table if we're in the process of rehashing. This
    // flag will be triggered by the rest of the program when rehashing is
    // needed.
    if(m_isRehashing) {
        moveH0ClusterAt(hashH0(str));
    }


    m_H0LoadFactor = (((double) m_H0Size) / m_H0Capacity);

    return isFound; 

}


//////////////////////////////////////////////////////
//
//
char * HashTable::removeFromH0(const char *str) {

    bool isRemoved = false;
    char * toReturn = NULL;

    int index = hashH0(str);
    int probeLen = 0;

    // Keep going until we either add it or we go too far.
    while(H0[index] != NULL && !isRemoved && probeLen < MAX_PROBE_LEN) {

        if(H0[index] != DELETED && (strcmp(H0[index], str) == 0)) {

            isRemoved = true;
            toReturn = H0[index];
            H0[index] = DELETED;
            m_H0Size--;

        }

        // Next index is given by a method so we can wrap around properly.
        index = nextH0(index);

        probeLen++;

    }
 
    // If the cluster is to big, init rehashing.
    if(probeLen >= MAX_PROBE_LEN) {
        initRehash();
    }


    // If we didn't find the thing we wanted but we are rehashing, go check
    // the next table too.
    if(!isRemoved && m_isRehashing) {

        toReturn = removeFromH1(str);

    }
    

    if(m_isRehashing) {
        moveH0ClusterAt(hashH0(str));
    }

    m_H0LoadFactor = (((double) m_H0Size) / m_H0Capacity);

    return toReturn;

}


//////////////////////////////////////////////////////
//
//
void HashTable::initRehash() {
   

    if(!m_isRehashing) {

    
        m_isRehashing = true;

        m_H1Capacity = findNewCapacity(m_H0Size);
        m_H1Size = 0;

        m_H1LoadFactor = (((double) m_H1Size) / m_H1Capacity);

        //cout << "Capp: " << m_H1Capacity << endl;

        H1 = new char*[m_H1Capacity];

        for(int i = 0; i < m_H1Capacity; i++)
            H1[i] = NULL;

    }
}



//////////////////////////////////////////////////////
//
//
void HashTable::moveH0ClusterAt(int index) {

    int backwards = index;
    int forwards = nextH0(index);

    // Work our way backwards and remove the cluster. Only stop when
    // we're no longer NULL.
    while(H0[backwards] != NULL) {

        // We don't need to move DELETED entries to the new table.
        if(H0[backwards] != DELETED) {
            // TODO: Will this be a pointer to a cstring or a cstring?
            insertIntoH1(H0[backwards]);

            m_H0Size--;
            m_H1Size++;

        }

        H0[backwards] = NULL;

        backwards = prevH0(backwards);

    }

    while(H0[forwards] != NULL) {

        if(H0[forwards] != DELETED) {
            
            insertIntoH1(H0[forwards]);

            m_H0Size--;
            m_H1Size++;

        }

        H0[forwards] = NULL;

        forwards = nextH0(forwards);

    }

    m_H0LoadFactor = (((double) m_H0Size) / m_H0Capacity);
    m_H1LoadFactor = (((double) m_H1Size) / m_H1Capacity);

}


//////////////////////////////////////////////////////////////////
// ReHash (H1) Methods                                          //
//////////////////////////////////////////////////////////////////



//////////////////////////////////////////////////////
//
//
void HashTable::insertIntoH1(char *str) {

    bool added = false;

    // If it's not rehashing, go down in here and insert it here. If it is, 
    // it will insert the item into H2 below this if statement in another one
    // that checks whether or not it has been added.
    
        int index = hashH1(str);
        int probeLen = 0;

        // Keep going until we either add it or we go too far.
        while(!added && probeLen < MAX_PROBE_LEN) {

            if(H1[index] == NULL || H1[index] == DELETED) {

                added = true;
                H1[index] = str;
                m_H0Size++;

            }

            // Next index is given by a method so we can wrap around properly.
            index = nextH1(index);

            probeLen++;

        }

        // If the cluster is to big, init rehashing.
        if(probeLen >= MAX_PROBE_LEN) {
            initReRehash();
        }

    

    // If we didn't find the thing we wanted but we are rehashing, go check
    // the next table too.
    if(!added) {

        initReRehash();

        // Because ReRehash forces the throw up hands situation, we add this
        // to the main table.
        insert(str);

    }

    m_H1LoadFactor = (((double) m_H1Size) / m_H1Capacity);  

}



//////////////////////////////////////////////////////
//
//
bool HashTable::findInH1(const char *str) {

    int index = hashH1(str);
    int probeLen = 0;
    bool isFound = false;

    cout << index << endl;

    // Keep going until we either add it or we go too far.
    while(!isFound && H1[index] != NULL && probeLen < MAX_PROBE_LEN) {

        if(H1[index] != DELETED && strcmp(H1[index], str) == 0) {

            isFound = true;

        }

        // Next index is given by a method so we can wrap around properly.
        index = nextH1(index);

        probeLen++;

        cout << index << endl;
    }

    // If the cluster is to big, init rehashing.
    if(probeLen >= MAX_PROBE_LEN) {
        initReRehash();
        isFound = find(str);
    }


    // If we didn't actually add anything, we need to rehash because the
    if(!isFound) {

        isFound = findInH2(str);

    }

    m_H1LoadFactor = (((double) m_H1Size) / m_H1Capacity);

    return isFound; 
}



//////////////////////////////////////////////////////
//
//
char * HashTable::removeFromH1(const char *str) {

    bool isRemoved = false;
    char * toReturn = NULL;

    int index = hashH1(str);
    int probeLen = 0;

    // Keep going until we either add it or we go too far.
    while(!isRemoved && H1[index] != NULL && probeLen < MAX_PROBE_LEN) {

        if(H1[index] != DELETED && strcmp(H1[index], str) == 0) {

            isRemoved = true;
            toReturn = H1[index];
            H1[index] = DELETED;
            m_H1Size--;

        }

        // Next index is given by a method so we can wrap around properly.
        index = nextH1(index);

        probeLen++;

    }
 
    // If the cluster is to big, init rehashing.
    if(probeLen >= MAX_PROBE_LEN) {
        initReRehash();
    }


    // If we didn't find the thing we wanted but we are rehashing, go check
    // the next table too.
    if(!isRemoved && m_isReRehashing) {

        toReturn = removeFromH2(str);

    }

    m_H1LoadFactor = (((double) m_H1Size) / m_H1Capacity);

    return toReturn;


}



//////////////////////////////////////////////////////
//
//
void HashTable::initReRehash() {

    //cout << "initReRehash" << endl;

    if(!m_isReRehashing && m_isRehashing){
        m_isReRehashing = true;
        forceRehashNormal();
    }
}


void HashTable::moveH1ClusterAt(int index) {

    int backwards = index;
    int forwards = nextH1(index);

    // Work our way backwards and remove the cluster. Only stop when
    // we're no longer NULL.
    while(H1[backwards] != NULL) {

        // We don't need to move DELETED entries to the new table.
        if(H1[backwards] != DELETED) {
            // TODO: Will this be a pointer to a cstring or a cstring?
            insertIntoH2(H1[backwards]);


            m_H1Size--;
            m_H2Size++;
        }

        H1[backwards] = NULL;

        backwards = prevH1(backwards);

    }

    while(H1[forwards] != NULL) {

        if(H1[forwards] != DELETED) {
            insertIntoH2(H1[forwards]);


            m_H1Size--;
            m_H2Size++;
        }

        H1[forwards] = NULL;

        forwards = nextH1(forwards);

    }
    
    m_H1LoadFactor = (((double) m_H1Size) / m_H1Capacity);

}


//////////////////////////////////////////////////////////////////
// ReReHash (H2) Methods                                        //
//////////////////////////////////////////////////////////////////



//////////////////////////////////////////////////////
//
//
void HashTable::insertIntoH2(char *str) {

    int whereTo = hashH2(str);

    // In the (somewhat) unlikely event of a collision, find us an open spot.
    while(H2[whereTo] != NULL) {
        whereTo = nextH2(whereTo);
    }

    H2[whereTo] = str;

    // Increase size.
    m_H2Size++;

}



//////////////////////////////////////////////////////
//
//
bool HashTable::findInH2(const char *str) {

    int whereTo = hashH2(str);

    while(H2[whereTo] != NULL) {
        if(H2[whereTo] != DELETED && strcmp(H2[whereTo],str) == 0) {
            return true;
        }

        whereTo = nextH2(whereTo);
    }

    return false;

}



//////////////////////////////////////////////////////
// This will never be used.
//
char * HashTable::removeFromH2(const char *str) {

    char* toReturn = NULL;

    int index = hashH2(str);
    
    while(H2[index] != NULL) {

        if(H2[index] != DELETED && strcmp(H2[index], str) == 0) {
;
            toReturn = H2[index];
            H2[index] = DELETED;
            m_H2Size--;
            return toReturn;

        }

        index = nextH2(index);
    }

    return toReturn;

}


//////////////////////////////////////////////////////////////////
// Dump Related Methods                                         //
//////////////////////////////////////////////////////////////////


void HashTable::dump() {

    printH0();
   
    cout << endl << endl;

    if(m_isRehashing) {
        printH1();
    }

}


void HashTable::printH0() {

    cout << "HashTable #1: size = " << m_H0Size 
        << ", tableSize = " << m_H0Capacity << endl;
    
    printTable(H0, m_H0Capacity, "H0");

}


void HashTable::printH1() {
    
    cout << "HashTable #2: size = " << m_H1Size 
        << ", tableSize = " << m_H1Capacity << endl;

    printTable(H1, m_H1Capacity, "H1");

}


// Never used
void HashTable::printH2() {
    
    cout << "HashTable #3: size = " << m_H2Size 
        << ", tableSize = " << m_H2Capacity << endl;

    printTable(H2, m_H2Capacity, "H2");

}


void HashTable::printTable(char** table, int capacity, char* name) {

    for(int i = 0; i < capacity; i++) {

        char* str = getString(table[i]);
        int hash = hashCode(str) % capacity;
        
        if(table[i] != DELETED && table[i] != NULL) {
            printf("%s[%d] = %s (%d)\n", name, i, str, hash);
        } else {
            printf("%s[%d] = %s\n", name, i, str);
        }

    }

}

char* HashTable::getString(char* str) {

    if(str == NULL) {
        return "";
    } else if(str == DELETED) {
        return "DELETED";
    } else {
        return str;
    }

}

