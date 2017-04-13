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

#include<string>

using namespace std;

class Node;
class LazyBST;


class Node {
public:
    // Use initializer lists to make constructors. 
    Node(): 
        m_key(-1), 
        m_data(-1), 
        m_height(0), 
        m_size(1),
        m_left(NULL),
        m_right(NULL)   {};
    Node(int key): 
        m_key(key), 
        m_data(key), 
        m_height(0), 
        m_size(1),
        m_left(NULL),
        m_right(NULL)   {};
    Node(int key, int data): 
        m_key(key), 
        m_data(data), 
        m_height(0), 
        m_size(1),
        m_left(NULL),
        m_right(NULL)   {};
     
    int m_key;
    int m_data;
    
    int m_size;
    int m_height;
    
    Node* m_left;
    Node* m_right;

};


class LazyBST {
public:

    // Constructors
    LazyBST() : m_root(NULL) {};
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


    bool locate(const char *position, int& key);

private:

    Node* m_root;

    void rebalance(); 


    //////////////////////////////////////////////////////////////////
    // Recurring methods.                                           //
    //////////////////////////////////////////////////////////////////

    // This is the recurrsive insert function for the lazy BST. It recurrs 
    // until it finds a null pointer where the node should go. When it finds
    // it, it inserts a new Node with the key and then returns bool.
    //
    // Takes:   
    // on:      a node pointing to the root of the subtree we're on.
    // key:     a key to add into the tree
    // 
    // Returns: true if a node is inserted,
    //          false otherwise. 
    Node* insertAndRecurr(Node* &on, int key);

    Node* removeAndRecurr(Node* &on, int key, bool &removed);

    Node* rebalanceAndRecurr(Node* &on);

    Node* insertDuringRebalance(int lower, int upper, Node* arr[]); 
    
    std::string inorderRecurrsive(Node* &on);
    
    bool recurrAndLocate(const char *position, int& key, Node* on);


    //////////////////////////////////////////////////////////////////
    // Some utility functions.                                      //
    //////////////////////////////////////////////////////////////////
    
    // This flattens all the nodes out into an array of pointers to nodes.
    // This is used when you sort them all back together and stuff. This
    // leaves disconnecting children as an exercise for the the current node
    // rebalancing method and whatnot.
    //
    // index:   what index within the array the node is on
    // arr:     the array with all the nodes in it
    // size:    the total size of the subtree.
    void flattenNodes(
             Node* &on, int& index, Node* arr[], int size );
    
    // This separates all the nodes in a flattened BST from their children.
    // This allows the rebalancing to take place more easily. It also sets 
    // all their heights to 0 and sizes to 1..
    void unlinkAllFromChildren(Node* arr[], int size) ;

    // This is a helper function that gets the maximum heights of the subtrees
    // below a certain node.
    int getMaxHeightBelow(Node* &on); 

    // This helper function gets the sum of the sizes of the nodes below the 
    // current one. We use this in rebalancing. 
    int getSizeBelow(Node* &on); 
    
    // Delete all of a subtree. Used in the destructor for recurssive calls.
    //
    // Takes:
    //  parent: a parent of a subtree (can have 0 children).
    void killFamily(Node* parent);
    
        
    // This checks to see if we need to rebalance without doing recursive 
    // calls. This is useful for the top level rebalance function and for 
    // checking if we need to call rebalance() at all.
    // THIS DOES NOT CHECK WHETHER THE NODES ARE TALL ENOUGH TO REBALANCE
    //
    // Takes:
    //  on:      a node representing the root of a subtree
    // Returns: 
    //  true:   when the child on one side of the tree is at least double 
    //          the height of the other child subtree.
    //  false:  otherwise
    bool childrenUnbalanced(Node* &on);


    Node* findMin(Node* &on);


    //////////////////////////////////////////////////////////////////
    // Extremely simple helper functions.                           //
    //////////////////////////////////////////////////////////////////
    
    // Helper function that returns the minimum of two integers for the 
    // rebalance recurrsion function. Defined in header file because it's 
    // only one short expression.
    int min(int x, int y)  {    return (x >= y) ? y : x;   }

    int max(int x, int y)  {    return (x >= y) ? x : y;   }

    // Helper function that returns the absolute value of an integer for the
    // rebalance recurssion function. Defined in header file because it's 
    // only one short expression.
    int absVal(int n)      {    return (n >= 0) ? n : -n;  }
};

#endif
