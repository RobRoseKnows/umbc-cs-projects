#ifndef LAZY_BST_H_
#define LAZY_BST_H_

/**
 * File:    LazyBST.h
 * Author:  Robert Rose
 * Email:   robrose2@umbc.edu
 *
 * CS341 Project 3: LazyBST
 *
 */

class Node;
class LazyBST;


class Node {
public:
    // Use initializer lists to make constructors. 
    Node(): 
        m_key(-1), 
        m_data(-1), 
        m_height(0), 
        m_size(1) {};
    Node(int key): 
        m_key(key), 
        m_data(key), 
        m_height(0), 
        m_size(1) {};
    Node(int key, int data): 
        m_key(key), 
        m_data(data), 
        m_height(0), 
        m_size(1) {};
     
    int m_key;
    int m_data;
    
    int m_size;
    int m_height;
    
    Node* m_left;
    Node* m_right;

}


class LazyBST {
public:

    // Constructors
    LazyBST();
    LazyBST(const LazyBST& other);

    // Destructor
    ~LazyBST();

    // Operators
    const LazyBST& operator=(const LazyBST& rhs);

    // Methods
    void insert(int key);

    bool remove(int key);

    bool find(int key);

    void inorder();

    void rebalance();

    bool locate(const char *position, int& key);

private:

    Node* m_root;

    // This flattens all the nodes out into an array of pointers to nodes.
    // This is used when you sort them all back together and stuff. The 
    // disconnect sets it apart from the other flattenNodes in that it sets
    // all the children to NULL so it can be used in rebalancing operations
    //
    // on:      the current node
    // index:   what index within the array the node is on
    // arr:     the array with all the nodes in it
    // size:    the total size of the subtree.
    void LazyBST::flattenAndDisconnectNodes(
            Node* on, int& index, Node** arr, int size );

    // This is the recurrsive insert function for the lazy BST. It recurrs 
    // until it finds a null pointer where the node should go. When it finds
    // it, it inserts a new Node with the key and then returns bool.
    //
    // Takes:   a node pointing to the root of the subtree we're on.
    //          a key to add into the tree
    // Returns: true if a node is inserted,
    //          false otherwise.
   
    Node* insertAndRecurr(Node* on, int key);

    Node* rebalanceAndRecurr(Node* on);

    // Helper function that returns the minimum of two integers for the 
    // rebalance recurrsion function. Defined in header file because it's only
    // one short expression.
    int LazyBST::min(int x, int y)  {    return (x >= y) ? x : y;   }


    // Helper function that returns the absolute value of an integer for the
    // rebalance recurssion function. Defined in header file because it's only
    // one short expression.
    int LazyBST::absVal(int n)      {    return (n >= 0) ? n : -n;  }

}

#endif
