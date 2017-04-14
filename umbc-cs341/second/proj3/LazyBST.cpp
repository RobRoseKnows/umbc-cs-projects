/**
 * File:    LazyBST.cpp
 * Author:  Robert Rose
 * Email:   robrose2@umbc.edu
 *
 * CS341 Project 3: LazyBST
 *
 */

#include "LazyBST.h"
#include <stdexcept>        // Gives us exceptions that we use at one point.
#include <stdlib.h>         // Gives us NULL
#include <string>
#include <sstream>
#include <iostream>

using namespace std;

// Constructors

LazyBST::LazyBST(const LazyBST& other) {


    Node* newRoot = NULL;

    newRoot = copyConstruct(other.m_root);

}


Node* LazyBST::copyConstruct(const Node* on) {

    if(on == NULL) {
        return NULL;
    } else {

        Node* newNode = new Node(on->m_key);
        newNode->m_left = NULL;
        newNode->m_right = NULL;
        newNode->m_left = copyConstruct(on->m_left);
        newNode->m_right = copyConstruct(on->m_right);
        return newNode;

    }

}


// Destructor
LazyBST::~LazyBST() {

    killFamily(m_root);

}


void LazyBST::killFamily(Node* parent) {

    // This is the base case.
    if(parent == NULL) {
        return;
    }

    killFamily(parent->m_left);
    killFamily(parent->m_right);

    delete parent;

}


// Operators
const LazyBST& LazyBST::operator=(const LazyBST& rhs) {


}


// Methods
void LazyBST::insert(int key) {

    rebalance();
    m_root = insertAndRecurr(m_root, key);

}


bool LazyBST::remove(int key) {

    bool wasRemoved = false;
    rebalance();
    m_root = removeAndRecurr(m_root, key, wasRemoved);

}


bool LazyBST::find(int key) {

    return findR(key, m_root);   

}


// The recusive find function called by find()
bool LazyBST::findR(int key, Node* on) {

    if(on == NULL) {
        return false;
    } else if(key == on->m_key) {
        return true;
    } else if(key < on->m_key) {
        return findR(key, on->m_left);
    } else if(key > on->m_key) {
        return findR(key, on->m_right);
    } else {
        // Not sure what you did to get here.
        return false;
    }

}


void LazyBST::inorder() {
   
   cout << inorderRecurrsive(m_root); 

}


void LazyBST::rebalance() {

    // Check to make sure root is not NULL or if height is too short.
    if(m_root == NULL || m_root->m_height <= 3) {
        return;
    }


    // If we need to rebalance, trigger the recurrsive rebalancing function. 
    if(childrenUnbalanced(m_root)) {
        m_root = rebalanceAndRecurr(m_root);
    }

}


std::string LazyBST::inorderRecurrsive(Node* &on) {

    // Base case
    if(on == NULL)      {   return "";  }

    // Create a "buffer" to save the stuff to return.
    stringstream toReturn;

    // Add parantheses
    toReturn << "(";

    // Do the left
    toReturn << inorderRecurrsive(on->m_left);

    // Do the current
    toReturn << on->m_key << ":" << on->m_height << ":" << on->m_size;

    // Do the right
    toReturn << inorderRecurrsive(on->m_right);

    toReturn << ")";

    return toReturn.str();

}


// This checks to see if we need to rebalance without doing recursive calls.
// This is useful for the top level rebalance function and for checking if we
// need to rebalance at all.
bool LazyBST::childrenUnbalanced(Node* &on) {
   
    bool oneSideHasZero = false;
    
    int sLeft; 
    if(on->m_left != NULL) {
        sLeft = on->m_left->m_size;
    } else {
        // Left side is empty.
        sLeft = 0;
        oneSideHasZero = true;
    }


    int sRight;
    if(on->m_right != NULL) {
        sRight = on->m_right->m_size;
    } else { 
        // Right side is empty.
        sRight = 0;
    }
     

    // If we need to rebalance, trigger the recurrsive rebalancing function. 
    return (abs(sLeft - sRight) >= min(sLeft, sRight));


}



bool LazyBST::locate(const char *position, int& key) {

    return recurrAndLocate(position, key, m_root);

}


bool LazyBST::recurrAndLocate(const char *position, int& key, Node* on) {

    // Base case
    if(on == NULL)  {   return false;   }

    // Actually I don't think I need this because I check for the null
    // character in the switch statement.
    // Check to see if we're just looking for the root.
//    if(position == "") {
//        key = on->m_key;   
//        return true;    
//    }

    const char currChar = position[0];

    Node* nextNode = NULL;

    const char* newPosition;  

    switch(currChar) {

        case 'L':
            // Go to the left 
            nextNode = on->m_left;
            newPosition = 
                string(position).substr(1, string::npos).c_str();
            return recurrAndLocate(newPosition, key, nextNode);
        
        case 'R':
            // Go to the right
            nextNode = on->m_right;
            newPosition = 
                string(position).substr(1, string::npos).c_str();
            return recurrAndLocate(newPosition, key, nextNode);
        
        case '\0':
            // We already checked to make sure something exists at this point
            // so we know we're at the correct node, store the key and return
            // true.
            key = on->m_key;
            return true;

        default:
            return false; 

    }

}



void LazyBST::flattenNodes(
        Node* &on, int& index, Node* arr[], int size ) {

    if(on == NULL) {
        return;
    }

    if(on->m_left != NULL) {
        flattenNodes(on->m_left, index, arr, size);
    }

    arr[index] = on;
    index++;

    if(on->m_right != NULL) {
        flattenNodes(on->m_right, index, arr, size);
    }

}



Node* LazyBST::insertAndRecurr(Node* &on, int key) {


    // Check if it's time to add a new node.
    if(on == NULL) {

        Node* newNode = new Node(key) ;
        newNode->m_left = NULL;
        newNode->m_right = NULL;
        return newNode;
    
    } else {

        if(key == on->m_key) {
            
            // This tells us that no Node was inserted.
            return NULL;
        
        } else if(key > on->m_key) {

            // Set it negative as default so we can check for unequality and
            // we'll know when something new is added.
            int priorHeightRight = -1;
            int priorSizeRight = 0;
            
            if(on->m_right != NULL) {
                priorHeightRight = on->m_right->m_height;
                priorSizeRight = on->m_right->m_size;
            }
            

            // Do the recurrsion.
            Node* resultRight = insertAndRecurr(on->m_right, key);
            
            if(resultRight == NULL) {

                // No node was inserted, just recurr up the tree doing 
                // nothing
                return NULL;

            } else {

               // If we did add a new node somewhere in subtrees, increment
                // the size and height counters.
                if(resultRight->m_size != priorHeightRight ) { 
                    on->m_size += 
                        (resultRight->m_size - priorSizeRight);
                }

                if(resultRight->m_size != priorHeightRight) {
                    on->m_height =
                        max(resultRight->m_height + 1, on->m_height);
                }

                on->m_right = resultRight;

                return on;

            }


        } else if(key < on->m_key) {

            // Set it negative as default so we can check for unequality and
            // we'll know when something new is added.
            int priorHeightLeft = -1;
            int priorSizeLeft = 0;
            
            if(on->m_left != NULL) {
                priorHeightLeft = on->m_left->m_height;
                priorSizeLeft = on->m_left->m_size;
            }
            
            // Do the recurrsion.
            Node* resultLeft = insertAndRecurr(on->m_left, key);
            
            if(resultLeft == NULL) {

                // No node was inserted, just recurr up the tree doing 
                // nothing
                return NULL;

            } else {

                // If we did add a new node somewhere in subtrees, increment
                // the size and height counters.
                if(resultLeft->m_size != priorHeightLeft ) { 
                    on->m_size += 
                        (resultLeft->m_size - priorSizeLeft);
                }

                if(resultLeft->m_size != priorHeightLeft) {
                    on->m_height = 
                        max(resultLeft->m_height + 1, on->m_height);
                }

                on->m_left = resultLeft;

                return on;

            }

        } 

    }

}



Node* LazyBST::removeAndRecurr(
        Node* &on, int toRemove, bool &wasRemoved, bool doRemove) {

    // Whether or not the recurrsion resulted in an insertion.
    Node* result = NULL;

    // Check if it's time to add a new node.
    if(on == NULL) {

        return NULL ;

    } else {

        if(toRemove == on->m_key) {

            Node* toReturn;

            if(on->m_left != NULL && on->m_right != NULL) {
                // There are two children, uh oh.

                // This is a dummy boolean value that we can use for the
                // recursion on the right side.
                bool dummyBoolForTwoChildren = false;

                toReturn = findMin(on->m_right);

                if(toReturn == NULL)    {   return NULL;    }
                
                toReturn->m_left = on->m_left;
                toReturn->m_right = 
                    removeAndRecurr(
                            on->m_right, 
                            toReturn->m_key, 
                            dummyBoolForTwoChildren,
                            // This false here means we won't delete the node
                            // we're pointing to in dummyBoolForTwoChildren
                            false);
                
                int newHeight = 0;
                int newSize = 1;

                if(toReturn != NULL) {
                    newSize = getSizeBelow(toReturn);
                    int hRight = 
                        (toReturn->m_right) 
                            ? toReturn->m_right->m_height
                            : 0;
                    int hLeft = 
                        (toReturn->m_left) 
                            ? toReturn->m_left->m_height
                            : 0;
                    newHeight = max(hLeft, hRight - 1);
                }

                if(toReturn != NULL) {
                    toReturn->m_size = newSize;
                    toReturn->m_height = newHeight;
                }

                on->m_left = NULL;
                on->m_right = NULL;
                
                if(doRemove)    {   delete on;  }
 

            } else {
                // Took this from Park's slides to eliminate the need for 
                toReturn = 
                    ((on->m_left != NULL) ? on->m_left : on->m_right);

                /*
                int newHeight = 0;
                int newSize = 1;

                if(toReturn != NULL) {
                    newSize = getSizeBelow(toReturn);
                    int hRight = 
                        (toReturn->m_right) 
                            ? toReturn->m_right->m_height
                            : 0;
                    int hLeft = 
                        (toReturn->m_left) 
                            ? toReturn->m_left->m_height
                            : 0;
                    newHeight = max(hLeft, hRight - 1);
                }

                if(toReturn != NULL) {
                    toReturn->m_size = newSize;
                    toReturn->m_height = newHeight;
                }*/

                // Free the memory
                on->m_left = NULL;
                on->m_right = NULL;
                if(doRemove)    {   delete on;  }

            }


            // This tells us that no Node was inserted.
            wasRemoved = true;

            return toReturn;

        } else if(toRemove > on->m_key) {

            // Do the recurrsion.
            result = removeAndRecurr(
                    on->m_right, toRemove, wasRemoved, doRemove);

            if(wasRemoved) {
                // Since we removed one, we should subtract the size.
                on->m_size--;
                // Correct the height of the subtree.
                on->m_height = 
                    max(((result) ? result->m_height - 1 : -1), 
                        (on->m_left) ? on->m_left->m_height : -1) + 1;
                
                on->m_right = result;

                return on;

            } else {

                return on;

            }

        } else if(toRemove < on->m_key) {

            // Do the recurrsion
            result = removeAndRecurr(
                    on->m_left, toRemove, wasRemoved, doRemove);

            if(wasRemoved) {
                // Since we removed one, we should subtract the size.
                on->m_size--;
                // Correct the height of the subtree.
                on->m_height = 
                    max((result) ? result->m_height - 1 : -1, 
                        (on->m_right) ? on->m_right->m_height : -1) + 1;
                
                on->m_left = result;

                return on;

            } else {

                return on;

            }

        } 

    }

}



Node* LazyBST::findMin(Node* &on) {

    if(on == NULL) { return NULL; }

    if(on->m_left == NULL) {
        
        return on->m_left;
    
    } else {
        
        return findMin(on->m_left);
    
    }

}



Node* LazyBST::rebalanceAndRecurr(Node* &on) {

    // Check to see if it's NULL, if so, return.
    if(on == NULL) {
        return on;
    }

    // Check to see if it's too short to continue rebalancing. 
    if(on->m_height <= 3) {
        return on;
    }


    int sLeft; 
    if(on->m_left != NULL) {
        // Recurr on the left size first.
        on->m_left = rebalanceAndRecurr(on->m_left);
        sLeft = on->m_left->m_size;
    } else {
        // Left side is empty.
        sLeft = 0;
    }


    int sRight;
    if(on->m_right != NULL) {
        // Then recurr on the right side if there's stuff there. 
        on->m_right = rebalanceAndRecurr(on->m_right);
        sRight = on->m_right->m_size;
    } else { 
        // Right side is empty.
        sRight = 0;
    }
     

    if(abs(sLeft - sRight) >= min(sLeft, sRight) ) {

        int subTreeSize = on->m_size;

        int flattenIndex = 0;
        Node* arr[subTreeSize];

        for(int i = 0; i < subTreeSize; i++) {
            arr[i] = NULL;
        }

        // Asked on Piazza if this was O(n) and a TA said it was.
        flattenNodes(on, flattenIndex, arr, subTreeSize);
        unlinkAllFromChildren(arr, subTreeSize);

        return insertDuringRebalance(0, subTreeSize - 1, arr);

    }

}


// This is a recursive function that goes through the flattened tree and
// generates a new tree. In order to do this is uses a binary search-esque
// movement to return new Nodes.
Node* LazyBST::insertDuringRebalance(int lower, int upper, Node* arr[]) {
    
    if(lower > upper) {
        return NULL;
    }

    int middle = lower + (upper - lower) / 2;
    
    Node* toReturn = arr[middle];

    // Catch to make sure we haven't reached the end.
    if(upper > lower) {

        toReturn->m_left = insertDuringRebalance(lower, middle - 1, arr);
        toReturn->m_right = insertDuringRebalance(middle + 1, upper, arr);

        int tallestHeight = getMaxHeightBelow(toReturn);
        toReturn->m_height = tallestHeight + 1;


        int sizeBelow = getSizeBelow(toReturn);
        toReturn->m_size = sizeBelow + 1;
    }

    return toReturn;

}


// This is a helper function that gets the maximum heights of the subtrees
// below a certain node.
int LazyBST::getMaxHeightBelow(Node* &on) {

    int hLeft = 0;
    int hRight = 0;

    if(on == NULL)          {   return -1;  }

    // These are the NULL checks that make up the purpose of this helper
    // function.
    if(on->m_left != NULL)  {   hLeft = on->m_left->m_height;   }
    if(on->m_right != NULL) {   hRight = on->m_right->m_height; }

    // This tells us we're at a leaf so we should return -1 to symbolize that.
    if(on->m_left == NULL && on->m_right == NULL) {
        return -1;
    }


    return max(hLeft, hRight);

}


// This helper function gets the sum of the sizes of the nodes below the 
// current one. We use this in rebalancing. 
int LazyBST::getSizeBelow(Node* &on) {

    int sLeft = 0;
    int sRight = 0;
    
    if(on->m_left != NULL)  {   sLeft = on->m_left->m_size;     } 
    if(on->m_right != NULL) {   sRight = on->m_right->m_size;   }

    return sLeft + sRight; 
}


// This separates all the nodes in a flattened BST from their children. This
// allows the rebalancing to take place more easily. It also sets all their
// heights to 0 and sizes to 1.

void LazyBST::unlinkAllFromChildren(Node* arr[], int size) {
    
    for(int i = 0; i < size; i++) {

        arr[i]->m_height = 0;
        arr[i]->m_size = 1;
        arr[i]->m_left = NULL;
        arr[i]->m_right = NULL;

    }
    

}
