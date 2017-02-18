/*
 * File:    Graph.cpp
 * Author:  Robert Rose
 * Date:    2/17/17
 * E-mail:  robrose2@umbc.edu
 *
 */

#include "Graph.h"
#include <iostream> 
#include <stdio.h> // This allows me to use printf

using namespace std;


Graph::Graph(int n) {

    if(n <= 0) {
        throw std::out_of_range("Invalid graph size (n <= 0) in constructor");
    }

    m_size = n ;
    m_adjLists = new AdjListNode*[n] ;

}


Graph::Graph(const Graph& G) {

    m_size = G.m_size ;
    m_adjLists = new AdjListNode*[m_size] ;

    for(int i = 0; i < m_size; i++) {
        
        AdjListNode *on = G.m_adjLists[i] ;
        
        while(on != NULL) {

            m_adjLists[i] = new AdjListNode(on->m_vertex, m_adjLists[i]) ;
            on = on->next ;

        }

    }

}


Graph::~Graph() {

}


const Graph& Graph::operator=(const Graph& rhs) {

}


int Graph::size() {

    return m_size ;

}


void Graph::addEdge(int u, int v) {

    m_adjLists[u] = new AdjListNode(v, m_adjLists[u]);
    m_adjLists[v] = new AdjListNode(u, m_adjLists[v]);

}


void Graph::dump() {

    printf("Dump out graph (size = %u):\n", m_size) ;

    for(int i = 0; i < m_size; i++) {

        // Print out what node we're using as root.
        printf("[ %u]:", i) ;

        // Keep track of what node we're iterating through.
        AdjListNode *on = m_adjLists[i];

        while(on != NULL) {
            // Print out list
            printf(" %u", on->m_vertex) ;
            on = on->next ;
        }

        cout << endl ;
    
    }

}



//
// Begin EgIterator Inner Class
//

Graph::EgIterator::EgIterator(Graph *Gptr, bool isEnd) {

}


bool Graph::EgIterator::operator!= (const EgIterator& rhs) {

}


void Graph::EgIterator::operator++ (int dummy) {

}


std::pair<int, int> Graph::EgIterator::operator*() {

}

//
// END EgIterator Inner Class
//



Graph::EgIterator Graph::egBegin() {

}


Graph::EgIterator Graph::egEnd() {

}



//
// BEGIN NbIterator Inner Class
//

Graph::NbIterator::NbIterator(Graph *Gptr, int v, bool isEnd) {
    
}


bool Graph::NbIterator::operator!= (const NbIterator& rhs) {

    return m_where != rhs.m_where ;

}


void Graph::NbIterator::operator++ (int dummy) {

}


int Graph::NbIterator::operator*() {

}

//
// END NbIterator Inner Class
//



Graph::NbIterator Graph::nbBegin(int v) {

}



Graph::NbIterator Graph::nbEnd(int v) {

}



//
// BEGIN AdjListNode Inner Class
//

Graph::AdjListNode::AdjListNode(int v, AdjListNode *ptr) {
    
    m_vertex = v ;
    next = ptr;

}

//
// END AdjListNode Inner Class
//




