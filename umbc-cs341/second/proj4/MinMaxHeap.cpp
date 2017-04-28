#ifndef _MINMAXHEAP_CPP_
#define _MINMAXHEAP_CPP_

#include "MinMaxHeap.h"
#include <sstream>

using namespace std;

template <typename T> 
bool minCmp(const Item<T>& lhs, const Item<T>& rhs) {

   return lhs.data <= rhs.data; 

}
    

template <typename T> 
bool maxCmp(const Item<T>& lhs, const Item<T>& rhs) {

    return lhs.data >= rhs.data;

}


// This helps with the dump() function.
template<typename T>
string Item<T>::print() {

    stringstream ss;

    ss << "(";
    ss << this.m_data;
    ss << ",";
    ss << this.m_twin;
    ss << ")";

    return ss.str();

}


//////////////////////////////////////////////////////
// Heap Class                                       //
//////////////////////////////////////////////////////

template <typename T>
Heap<T>::Heap(int capacity, bool (*cmp)(const Item<T>&, const Item<T>&)):
    m_capacity(capacity), m_cmp(cmp), m_size(0) {
    
    m_array = new Item<T>[capacity + ROOT_INDEX];

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
void Heap<T>::bubbleUp(int index, Item<T>* obj) {

    for( ; 
            index > 1 && 
            (*m_cmp)(obj, m_array[parent]); 
            index /= 2) {
        
        swap(index, index / 2);

    }

}



template <typename T>
void Heap<T>::trickleDown(int index, Item<T>* obj) {


    int child = index * 2;

    for( ; 
            child < m_size;
            index = child, 
            child *= 2) {

        if(child < m_size && (*m_cmp)(m_array[child+1], m_array[child])) {
            child++;
        }

        if((*m_cmp)(m_array[child], tmp)) {
            swap(index, child);
        } else {
            break;
        }

    }    


}



template <typename T>
T* Heap<T>::pop() {

    T* toReturn = m_array[ROOT_INDEX]->m_data;
    int twIndex = m_array[ROOT_INDEX]->m_twin;

    // Get rid of the one at the top
    delete m_array[ROOT_INDEX];
    m_array[ROOT_INDEX] = NULL;
    swap(ROOT_INDEX, m_size);


}


template <typename T>
T* Heap<T>::peek() {

    return m_array[ROOT_INDEX]->m_data;

}


template <typename T>
void Heap<T>::dump() {

    cout << "size = " << m_size << ", capacity = " << m_capacity << endl;
    
    for(int i = ROOT_INDEX; i <= m_size; i++) {
        cout << "Heap[" << i << "] = " << m_array[i].print() << endl;
    }

}


template <typename T>
void Heap<T>::swap(int a, int b) {

    if(a == b) return;

    // Get the twins of a & b
    int twin_a = m_array[a]->m_twin;
    int twin_b = m_array[b]->m_twin;

    // Tell their twins their new location.
    if(twin_a >= 0)     m_other->m_array[twin_a]->m_twin = b;
    if(twin_b >= 0)     m_other->m_array[twin_b]->m_twin = a;

    // Swap them using the 0 index.
    m_array[0] = m_array[a];
    m_array[a] = m_array[b];
    m_array[b] = m_array[0];

    // This isn't neccessary, but I don't want to leave junk data lying
    // around.
    m_array[0] = NULL;

}



//////////////////////////////////////////////////////
// MinMaxHeap Class                                 //
//////////////////////////////////////////////////////

template <typename T>
MinMaxHeap<T>::MinMaxHeap(int capacity): 
    m_totSize(0), m_totCapacity(capacity) {

    m_minHeap = new Heap<T>(capacity, &minCmp);
    m_maxHeap = new Heap<T>(capacity, &maxCmp);

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

    if(m_totSize >= m_totCapacity) {
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
    

}

template<typename T>
void MinMaxHeap<T>::locateMax(int pos, T& data, int& index) {


}


#endif
