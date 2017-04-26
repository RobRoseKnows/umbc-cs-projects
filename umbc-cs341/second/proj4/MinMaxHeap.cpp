#ifndef _MINMAXHEAP_CPP_
#define _MINMAXHEAP_CPP_

#include "MinMaxHeap.h"


template <typename T> 
bool minCmp(const std::pair<T*,int>& lhs, const std::pair<T*,int>& rhs) {

   return lhs.data <= rhs.data; 

}
    

template <typename T> 
bool maxCmp(const std::pair<T*,int>& lhs, const std::pair<T*,int>& rhs) {

    return lhs.data >= rhs.data;

}


// This helps with the dump() function.
std::ostream& Item::operator<<(std::ostream& os, const std::pair<T*,int>& item) {

    os << "(";
    os << item.m_data;
    os << ",";
    os << item.m_twin;
    os << ")";

    return os;

}


//////////////////////////////////////////////////////
// Heap Class                                       //
//////////////////////////////////////////////////////

template <typename T>
Heap<T>::Heap(int capacity, bool (*cmp)(const std::pair<T*,int>& *, const std::pair<T*,int>& *)):
    m_capacity(capacity), m_cmp(cmp) {

    m_heap = new std::pair<T*,int>[capacity + ROOT_INDEX];
    m_size = 0;

}


template <typename T>
Heap<T>::Heap(const Heap<T>& other) {



}


template <typename T>
T* Heap<T>::deleteAt(int index) {



}
    

template <typename T>
int Heap<T>::insert(const T& data) {

    if(m_size >= m_capacity) {
        throw HeapOverflow("Heap::insert(): Heap already at capacity");
    }


}


template <typename T>
T* Heap<T>::pop() {

    T* toReturn = m_heap[ROOT_INDEX];


}


template <typename T>
T* Heap<T>::peek() {

    return m_heap[ROOT_INDEX];

}


template <typename T>
void Heap<T>::dump() {

    cout << "size = " << m_size << ", capacity = " << m_capacity << endl;
    
    for(int i = ROOT_INDEX; i <= m_size; i++) {
        cout << "Heap[" << i << "] = " << *m_heap[i] << endl;
    }

}


template <typename T>
void Heap<T>::swap(int a, int b) {

    // Get the twins of a & b
    int twin_a = m_heap[a]->m_twin;
    int twin_b = m_heap[b]->m_twin;

    // Tell their twins their new location.
    m_other->m_heap[twin_a]->m_twin = b;
    m_other->m_heap[twin_b]->m_twin = a;

    // Swap them using the 0 index.
    m_heap[0] = m_heap[a];
    m_heap[a] = m_heap[b];
    m_heap[b] = m_heap[0];

    // This isn't neccessary, but I don't want to leave junk data lying
    // around.
    m_heap[0] = NULL;

}



//////////////////////////////////////////////////////
// MinMaxHeap Class                                 //
//////////////////////////////////////////////////////

template <typename T>
MinMaxHeap<T>::MinMaxHeap(int capacity): 
    m_totSize(0), m_totCapacity(capacity) {

    m_minHeap = new Heap(capacity, &minCmp);
    m_maxHeap = new Heap(capacity, &maxCmp);

}



template <typename T>
MinMaxHeap<T>::MinMaxHeap(const MinMaxHeap<T>& other) {


}



template <typename T>
MinMaxHeap<T>::~MinMaxHeap() {


}



template <typename T>
const MinMaxHeap<T>& MinMaxHeap<T>::operator=(const MinMaxHeap<T>& rhs) {


}



template <typename T>
void MinMaxHeap<T>::insert(const T& data) {

    if(m_size >= m_capacity) {
        throw HeapOverflow("MinMaxHeap::insert(): Heap already at capacity");
    }


}



template <typename T>
T MinMaxHeap<T>::deleteMin() {


}



template <typename T>
T MinMaxHeap<T>::deleteMax() {


}



template <typename T>
void MinMaxHeap<T>::dump() {

    cout << "... MinMaxHeap::dump() ..." << endl;
    cout << endl;
    
    cout << "------------Min Heap------------" << endl;
    m_minHeap->dump(); 
    cout << endl;
    
    cout << "------------Max Heap------------" << endl;
    m_maxHeap->dump();    
    cout << "--------------------------------" << endl;
    
}


template <typename T>
void MinMaxHeap<T>::locateMin(int pos, T& data, int& index) {
    
    data = minHeap[pos]->m_data;
    index = minHeap[pos]->m_twin;

}


void MinMaxHeap<T>::locateMax(int pos, T& data, int& index) {

    data = maxHeap[pos]->m_data;
    index = maxHeap[pos]->m_twin;

}


#endif
