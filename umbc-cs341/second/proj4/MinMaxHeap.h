#ifndef _MINMAXHEAP_H_
#define _MINMAXHEAP_H_

// I used this last semester to avoid magic numbers.
#define ROOT_INDEX 1

/*
 * File:    MinMaxHeap.h
 * Author:  Robert Rose
 * E-mail:  robrose2@umbc.edu
 * 
 * Project 4 Spring 2017
 *
 */


#include <iostream>
#include <string>
#include <stdexcept>
#include <utility>

using namespace std;

template <typename T> class MinMaxHeap;
template <typename T> class Heap;
template <typename T> class Item;

template <typename T> 
bool minCmp(const Item<T>& lhs, const Item<T>& rhs);
    
template <typename T> 
bool maxCmp(const Item<T>& lhs, const Item<T>& rhs);



// I built a Heap class last semester for 341. I made sure to directly copy
// but there are a few things (like this overflow error) that carried over. 
class HeapOverflow : public overflow_error {
    public:
        HeapOverflow(const string& what) : overflow_error(what) {}
};


template <typename T>
class Item {
public:
    Item(T* data)           : m_data(data), m_twin(-1) {}
    Item(T* data, int twin) : m_data(data), m_twin(twin) {}

    string print();

    T* m_data;
    int m_twin;
};



template <typename T>
class Heap {
public:
    
    Heap(int capacity, bool (*cmp)(const Item<T>&, const Item<T>&));
    Heap(const Heap<T>& other);

    ~Heap();

    T* getDataAt(int index)             {   return m_array[index]->m_data;   }
    T* getTwinAt(int index)             {   return m_array[index]->m_twin;   }


    T* deleteAt(int index);
    
    // Returns int to tell us where in the heap it ended up.
    int insert(const T& data);

    T* pop();
    T* peek();

    void dump();
    void setOther(const Heap<T>& other)   {   m_other = other;    }

    // Two simple functions that I can define in the header file.
    int size()      {   return m_size;      }
    int capacity()  {   return m_capacity;  }

private:
    
    Heap<T>* m_other;
    Item<T>* m_array[];
    bool (*m_cmp)(const Item<T>&, const Item<T>&);

    int m_size;
    int m_capacity;

    int getLeftChildIndex(int i) const  {   return i * 2;       }
    int getRightChildIntex(int i) const {   return i * 2 + 1;   }
    int getParentIndex(int i) const     {   return i / 2;       } 

    void bubbleUp(int from, Item<T>* obj);
    void trickleDown(int from, Item<T>* obj);

    void swap(int a, int b);

};

template <typename T>
class MinMaxHeap {
public:

    MinMaxHeap(int capacity);
    MinMaxHeap(const MinMaxHeap<T>& other);

    ~MinMaxHeap();

    const MinMaxHeap<T>& operator=(const MinMaxHeap<T>& rhs);

    // Two simple functions that I can define in the header file.
    int size()      {   return m_totSize;      }
    int capacity()  {   return m_totCapacity;  }

    void insert(const T& data);

    T deleteMin();
    T deleteMax();

    void dump();

    void locateMin(int pos, T& data, int& index);
    void locateMax(int pos, T& data, int& index);


private:

    Heap<T>* m_minHeap;
    Heap<T>* m_maxHeap;

    int m_totSize;
    // VVV DOES NOT INCLUDE 0
    int m_totCapacity;

};


#include "MinMaxHeap.cpp"

#endif
