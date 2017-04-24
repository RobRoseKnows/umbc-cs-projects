#ifndef _MINMAXHEAP_H_
#define _MINMAXHEAP_H_

// I used this last semester too to avoid magic numbers.
#define ROOT_INDEX 1

/*
 * File:    MinMaxHeap.h
 * Author:  Robert Rose
 * E-mail:  robrose2@umbc.edu
 * 
 * Project 4 Spring 2017
 *
 */


template <typename T> class MinMaxHeap;
template <typename T> class Heap;

template <typename T> 
bool minCmp(const Item<T>& lhs, const Item<T>& rhs);
    
template <typename T> 
bool maxCmp(const Item<T>& lhs, const Item<T>& rhs);

template <typename T>
struct Item {
    
    T* data;
    int index;        

};

// I took the idea for defining the heap size as a template from a similar
// project last semester. Last semester it was neccessary to define the arrays
// so I assume it is here too.
template <typename T>
class Heap {
public:
    
    Heap(bool (*cmp)(const Item<T>& *, const Item<T>& *)): m_cmp(cmp) {};
    Heap(const Heap<T>& other);

    void deleteAt(int index);
    
    // Returns int to tell us where in the heap it ended up.
    int insert(const T& data);

    T pop();
    T peek();

    void dump();
    void setOther(Heap<T>* other)   {   m_other = other;    }

private:
    
    Heap<T>* m_other;
    Item<T>* m_heap[m_size + ROOT_INDEX];
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

    int size();

    void insert(const T& data);

    T deleteMin();
    T deleteMax();

    void dump();

    void locateMin(int pos, T& data, int& index);
    void locateMax(int pos, T& data, int& index);


private:

    Heap<T>* minHeap;
    Heap<T>* maxHeap;


};





#include "MinMaxHeap.cpp"

#endif
