/*
 * File:    Driver.cpp
 * Author:  Robert Rose
 * Date:    2/17/17
 * E-mail:  robrose2@umbc.edu
 */

#include "Graph.h"
#include <iostream>

using namespace std;

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
    
    
    cout << "--- Test Neighbor Iterator ---" << endl;
    cout << "0's neighbors: " << endl;
    
    Graph::NbIterator endNbItr = G.nbEnd(0);
    for(Graph::NbIterator itr = G.nbBegin(0); itr != endNbItr; itr++) {
        cout << *itr << " ";
    }

    cout << endl << endl;

    cout << "--- Test Edge Iterator ---" << endl;

    Graph::EgIterator endEgItr = G.egEnd();
    for(Graph::EgIterator itr = G.egBegin(); itr != endEgItr; itr++) {
        std::pair<int, int> edge = *itr;
        cout << edge.first << " <-> " << edge.second << endl;
    }

    cout << endl << endl;
}
