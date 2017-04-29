#ifndef _MINMAXHEAP_CPP_
#define _MINMAXHEAP_CPP_

#include "MinMaxHeap.h"
#include <sstream>

using namespace std;

template <typename T> 
bool minCmp(const Item<T>* lhs, const Item<T>* rhs) {

    if(lhs == NULL || rhs == NULL) {
        return false;
    }

   return lhs->m_data <= rhs->m_data; 

}
    

template <typename T> 
bool maxCmp(const Item<T>* lhs, const Item<T>* rhs) {

    if(lhs == NULL || rhs == NULL) {
        return false;
    }

    return lhs->m_data >= rhs->m_data;

}


// This helps with the dump() function.
template<typename T>
string Item<T>::print() {

    stringstream ss;

    ss << "(";
    ss << this->m_data;
    ss << ",";
    ss << this->m_twin;
    ss << ")";

    return ss.str();

}


//////////////////////////////////////////////////////
// Heap Class                                       //
//////////////////////////////////////////////////////

template <typename T>
Heap<T>::Heap(int capacity, bool (*cmp)(const Item<T>*, const Item<T>*)):
    m_capacity(capacity), m_cmp(cmp), m_size(0) {
    
    m_array = new Item<T>*[capacity + ROOT_INDEX];

}


template <typename T>
Heap<T>::Heap(const Heap<T>& other) {

    m_capacity = other.m_capacity;
    m_cmp = other.m_cmp;
    m_size = other.m_size;

    m_array = new Item<T>[other.m_capacity + ROOT_INDEX];

    for(int i = ROOT_INDEX; i <= m_size; i++) {
        m_array[i] = other.m_array[i];
    }

}


template <typename T>
Heap<T>::~Heap() {

    for(int i = 0; i <= m_capacity; i++) {

        delete m_array[i];
        m_array[i] = NULL;

    }

    delete [] m_array;

    m_other = NULL;

}


template <typename T>
pair<T, int> Heap<T>::deleteAt(int index) {

    if(m_size <= 0) {
        throw HeapUnderflow("No nodes left to remove!");
    }

    if(index > m_size) {
        throw HeapUnderflow("No node exists at index!" );
    }

    T retData = m_array[index]->m_data;
    int twIndex = m_array[index]->m_twin;
    pair<T, int> toReturn = pair<T, int>(retData, twIndex); 

    swap(index, m_size);
    
    // Get rid of the one at the top
    delete m_array[m_size];
    m_array[m_size] = NULL;

    m_size--;

    trickleDown(index);

    return toReturn;

}
    

template <typename T>
int Heap<T>::insert(const T& data, int twin) {

    if(m_size + 1 > m_capacity) {
        throw HeapOverflow("Heap::insert(): Heap already at capacity");
    }
    
    m_size++;
    m_array[m_size] = new Item<T>(data, twin);

    return bubbleUp(m_size);

}


template <typename T>
int Heap<T>::bubbleUp(int index) {

    int parent = index / 2;
    Item<T>* temp = m_array[index];

    for( ; 
            index >= 1 && 
            (*m_cmp)(temp, m_array[parent]); 
            index = parent) {
        
        parent = index / 2;
        swap(index, parent);

    }

    m_array[index] = temp;

    return index;

}



template <typename T>
int Heap<T>::trickleDown(int index) {

    // Get left child
    int child = index * 2;
    Item<T>* tmp = m_array[index];

    for( ; 
            child <= m_size;
            index = child) {

        child = index * 2;

        if(child < m_size && (*m_cmp)(m_array[child+1], m_array[child])) {
            child++;
        }

        if((*m_cmp)(m_array[child], tmp)) {
            swap(index, child);
        } else {
            break;
        }

    }

    m_array[index] = tmp;

    return index;

}



template <typename T>
pair<T, int> Heap<T>::pop() {

    if(m_size <= 0) {
        throw HeapUnderflow("No nodes left to remove!");
    }

    T retData = m_array[ROOT_INDEX]->m_data;
    int twIndex = m_array[ROOT_INDEX]->m_twin;
    pair<T, int> toReturn = pair<T, int>(retData, twIndex); 

    swap(ROOT_INDEX, m_size);
    
    // Get rid of the one at the top
    delete m_array[m_size];
    m_array[m_size] = NULL;

    m_size--;

    trickleDown(ROOT_INDEX);

    return toReturn;

}


template <typename T>
Item<T> Heap<T>::peek() {

    return *m_array[ROOT_INDEX];

}


template <typename T>
void Heap<T>::dump() {

    cout << "size = " << m_size << ", capacity = " << m_capacity << endl;
    
    for(int i = ROOT_INDEX; i <= m_size; i++) {
        cout << "Heap[" << i << "] = " << m_array[i]->print() << endl;
    }

}


template <typename T>
void Heap<T>::swap(int a, int b) {

    if(a == b) return;

    int twin_a = -1;
    int twin_b = -1;

    // Get the twins of a & b
    if(m_array[a] != NULL) twin_a = m_array[a]->m_twin;
    if(m_array[b] != NULL) twin_b = m_array[b]->m_twin;

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

    m_minHeap = new Heap<T>(capacity, minCmp);
    m_maxHeap = new Heap<T>(capacity, maxCmp);

    m_minHeap->setOther(m_maxHeap);
    m_maxHeap->setOther(m_minHeap);

}



template <typename T>
MinMaxHeap<T>::MinMaxHeap(const MinMaxHeap<T>& other) {

    m_totSize = other.m_totSize;
    m_totCapacity = other.m_totCapacity;

    m_minHeap = new Heap<T>(other.m_minHeap);
    m_maxHeap = new Heap<T>(other.m_maxHeap);

    m_minHeap->setOther(m_maxHeap);
    m_maxHeap->setOther(m_minHeap);

}



template <typename T>
MinMaxHeap<T>::~MinMaxHeap() {

    delete m_minHeap;
    delete m_maxHeap;

}



template <typename T>
const MinMaxHeap<T>& MinMaxHeap<T>::operator=(const MinMaxHeap<T>& rhs) {


}



template <typename T>
void MinMaxHeap<T>::insert(const T& data) {

    if(m_totSize >= m_totCapacity) {
        throw HeapOverflow("MinMaxHeap::insert(): Heap already at capacity");
    }

    int locInMin = m_minHeap->insert(data);
    int locInMax = m_maxHeap->insert(data, locInMin);

    m_minHeap->setTwinAt(locInMin, locInMax);
    

}



template <typename T>
T MinMaxHeap<T>::deleteMin() {

    if(m_totSize <= 0) {
        throw HeapUnderflow("In deleteMin: Heap has no items left.");
    }

    pair<T, int> minDeleteResult = m_minHeap->pop();

    m_maxHeap->deleteAt(minDeleteResult.second);

    return minDeleteResult.first;

}



template <typename T>
T MinMaxHeap<T>::deleteMax() {

    if(m_totSize <= 0) {
        throw HeapUnderflow("In deleteMin: Heap has no items left.");
    }

    pair<T, int> maxDeleteResult = m_maxHeap->pop();

    m_minHeap->deleteAt(maxDeleteResult.second);

    return maxDeleteResult.first;

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

    Item<T>* item = m_minHeap->getItemAt(pos);
    data = item->m_data;
    index = item->m_twin;

}

template<typename T>
void MinMaxHeap<T>::locateMax(int pos, T& data, int& index) {

    Item<T>* item = m_maxHeap->getItemAt(pos);
    data = item->m_data;
    index = item->m_twin;

}


#endif
