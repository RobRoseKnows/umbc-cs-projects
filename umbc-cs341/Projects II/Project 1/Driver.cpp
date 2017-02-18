/*
 * File:    Driver.cpp
 * Author:  Robert Rose
 * Date:    2/17/17
 * E-mail:  robrose2@umbc.edu
 */

#include "Graph.h"

int main() {

    Graph G = Graph(5) ;

    G.addEdge(0, 1) ;
    G.addEdge(1, 2) ;
    G.addEdge(2, 3) ;
    G.addEdge(3, 4) ;
    G.addEdge(4, 0) ;

    G.dump() ;

    Graph G2 = Graph(G) ;
    G2.dump() ;

}
