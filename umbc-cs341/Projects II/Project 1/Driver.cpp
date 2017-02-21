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

    
    ///////////////////////////////////////////////////
    // Testing Functionality for Static Objects ///////
    ///////////////////////////////////////////////////
    cerr << "********* Static Class *********" << endl;

    cerr << "------ Test Constructor --------" << endl;
    
    Graph G = Graph(5) ;
    G.dump();
    cerr << endl;
    
    
    cerr << "-------- Test Add Edges --------" << endl;

    G.addEdge(0, 1) ;
    G.addEdge(1, 2) ;
    G.addEdge(2, 3) ;
    G.addEdge(3, 4) ;
    G.addEdge(4, 0) ;

    G.dump() ;
    cerr << endl;
    
    cerr << "---- Test Copy Constructor -----" << endl;

    Graph G2 = Graph(G) ;
    G2.dump() ;
    cerr << endl;
    
    cerr << "---- Test Neighbor Iterator ----";
    printNeighbors(G, 0) ;
    cerr << endl << endl;

    cerr << "------ Test Edge Iterator ------";
    printEdges(G) ;
    cerr << endl << endl;

    ///////////////////////////////////////////////////
    // Testing Functionality for Dynamic Objects //////
    ///////////////////////////////////////////////////
    cerr << "********************************" << endl;
    cerr << "********* Dynamic Class ********" << endl;
    cerr << "********************************" << endl;


    cerr << "------ Test Constructor --------" << endl;

    Graph* Gptr1 = new Graph(5);
    Gptr1->dump();
    cerr << endl;

    cerr << "-------- Test Add Edges --------" << endl;

    Gptr1->addEdge(3, 4);
    Gptr1->addEdge(1, 4);
    Gptr1->addEdge(0, 3);
    Gptr1->addEdge(0, 4);
    Gptr1->addEdge(0, 1);
    Gptr1->addEdge(1, 2);
    Gptr1->addEdge(2, 4);;

    Gptr1->dump();
    cerr << endl;

    cerr << "---- Self Asignment Dynamic -----" << endl;
    Gptr1->dump();
    Gptr1 = Gptr1;
    Gptr1->dump();

    cerr << endl;

    ///////////////////////////////////////////////////
    // Testing Functionality Combining Dynamic And  //
    // Static Objects.                              //
    //////////////////////////////////////////////////
    cerr << "********************************" << endl;
    cerr << "* Combining Dynamic and Static *" << endl;
    cerr << "********************************" << endl;

    cerr << "---- Stat->Dyn Copy Cstruct ----" << endl;

    cerr << "Static G:" << endl;
    G.dump();
    cerr << endl;

    Graph* Gptr2 = new Graph(G);
    
    cerr << "Dynamic Gptr2 (copied):" << endl;
    Gptr2->dump();
    cerr << endl;
}

void printNeighbors(Graph &G, int on) {
    
    printf("\nThe neighbors of vertex %u are:\n", on);
    
    Graph::NbIterator endNbItr = G.nbEnd(on);
    for(Graph::NbIterator itr = G.nbBegin(on); itr != endNbItr; itr++) {
        cerr << *itr << " ";
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
