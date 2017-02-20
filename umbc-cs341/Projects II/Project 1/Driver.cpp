/*
 * File:    Driver.cpp
 * Author:  Robert Rose
 * Date:    2/17/17
 * E-mail:  robrose2@umbc.edu
 */

#include "Graph.h"
#include <iostream>
#include <stdio.h> // Allows me to use printf

using namespace std;

void printNeighbors(Graph &G, int on) ;
void printEdges(Graph &G) ;

int main() {

    cout << "--- Test Constructor ---" << endl;
    
    Graph G = Graph(5) ;
    G.dump();
    cout << endl;
    
    
    cout << "--- Test Add Edges ---" << endl;

    G.addEdge(0, 1) ;
    G.addEdge(1, 2) ;
    G.addEdge(2, 3) ;
    G.addEdge(3, 4) ;
    G.addEdge(4, 0) ;

    G.dump() ;
    cout << endl;
    
    
    cout << "--- Test Copy Constructor ---" << endl;

    Graph G2 = Graph(G) ;
    G2.dump() ;
    cout << endl;
    
    cout << "--- Test Neighbor Iterator ---";
    printNeighbors(G, 0) ;
    cout << endl << endl;

    cout << "--- Test Edge Iterator ---";
    printEdges(G) ;

    cout << endl << endl;
}


void printNeighbors(Graph &G, int on) {
    
    printf("\nThe neighbors of vertex %u are:\n", on);
    
    Graph::NbIterator endNbItr = G.nbEnd(on);
    for(Graph::NbIterator itr = G.nbBegin(on); itr != endNbItr; itr++) {
        cout << *itr << " ";
    }

}

void printEdges(Graph &G) {

    printf("\nThe edges in the graph are:\n");

    Graph::EgIterator endEgItr = G.egEnd();
    for(Graph::EgIterator itr = G.egBegin(); itr != endEgItr; itr++) {
        std::pair<int, int> edge = *itr;
        printf("(%u, %u) ", edge.first, edge.second);
    }

}
