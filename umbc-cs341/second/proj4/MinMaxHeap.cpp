#ifndef _MINMAXHEAP_CPP_
#define _MINMAXHEAP_CPP_

#include "MinMaxHeap.h"


template <typename T> 
bool minCmp(const Item<T>& lhs, const Item<T>& rhs) {

   return lhs.data <= rhs.data; 

}
    

template <typename T> 
bool maxCmp(const Item<T>& lhs, const Item<T>& rhs) {

    return lhs.data >= rhs.data;

}



template <typename T>
MinMaxHeap<T>::MinMaxHeap() {



}


template <typename T>
MinMaxHeap<T>::MinMaxHeap(int capacity) {



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
int MinMaxHeap<T>::size() {



}


template <typename T>
void MinMaxHeap<T>::insert(const T& data) {



}


template <typename T>
T MinMaxHeap<T>::deleteMin() {



}


template <typename T>
T MinMaxHeap<T>::deleteMax() {



}


template <typename T>
void MinMaxHeap<T>::dump() {



}



template <typename T>
void MinMaxHeap<T>::locateMin(int pos, T& data, int& index) {



}


template <typename T>
void MinMaxHeap<T>::locateMax(int pos, T& data, int& index) {



}


template <typename T, int m_size>
Heap::Heap(const Heap<T>& other) {



}


template <typename T, int m_size>
void Heap::deleteAt(int index) {


}


// Returns int to tell us where in the heap it ended up.
template <typename T, int m_size>
int Heap::insert(const T& data) {


}


template <typename T, int m_size>
T* Heap::pop() {



}


template <typename T, int m_size>
T* Heap::peek() {



}


template <typename T, int m_size>
void Heap::dump() {



}



template <typename T, int m_size>
void Heap::swap(int a, int b) {



}

#endif
