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


template <typename T> class MinMaxHeap;
template <typename T> class Heap;

template <typename T> 
bool minCmp(const Item<T>& lhs, const Item<T>& rhs);
    
template <typename T> 
bool maxCmp(const Item<T>& lhs, const Item<T>& rhs);



// I built a Heap class last semester for 341. I made sure to directly copy
// but there are a few things (like this overflow error) that carried over. 
class HeapOverflow : public std::overflow_error {
    public:
        HeapOverflow(const std::string& what) : std::overflow_error(what) {}
};



template <typename T>
class Item {
public:
    Item(T* data=NULL): m_data(data), m_twin(-1) {}

    std::ostream& operator<<(std::ostream& os, const Item<T>& item);

    // Originally I was going to make these private and use friend classes and
    // functions, but I realized that might be two obvious to reference the
    // comparison functions.
    T* m_data;
    int m_twin;
};



template <typename T>
class Heap {
public:
    
    Heap(int capacity, bool (*cmp)(const Item<T>& *, const Item<T>& *));
    Heap(const Heap<T>& other);

    ~Heap();

    // The subscript operator to get things out of the heap nicely. Defined
    // in header file because it's very simple.
    Item<T>* operator[](int index)  {   return m_heap[index];   }

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
    Item<T>* m_heap[];

    int m_size;
    int m_capacity;

    bool (*m_cmp)(const Item<T>& *, const Item<T>& *);

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
