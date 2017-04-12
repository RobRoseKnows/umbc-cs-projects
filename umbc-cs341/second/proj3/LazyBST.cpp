/**
 * File:    LazyBST.cpp
 * Author:  Robert Rose
 * Email:   robrose2@umbc.edu
 *
 * CS341 Project 3: LazyBST
 *
 */

#include "LazyBST.h"
#include <stdexcept>
#include <stdlib.h>

using namespace std;

// Constructors
LazyBST::LazyBST() {


}


LazyBST::LazyBST(const LazyBST& other) {


}

// Destructor
LazyBST::~LazyBST() {

    killFamily(m_root);

}


void LazyBST::killFamily(Node* parent) {

    // This is the base case.
    if(parent == NULL) return;

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

    m_root = removeAndRecurr(m_root, key, wasRemoved);

}


bool LazyBST::find(int key) {


}


void LazyBST::inorder() {


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


// This checks to see if we need to rebalance without doing recursive calls.
// This is useful for the top level rebalance function and for checking if we
// need to rebalance at all.
bool LazyBST::childrenUnbalanced(Node* &on) {
    
    
    int sLeft; 
    if(on->m_left != NULL) {
        sLeft = on->m_left->m_size;
    } else {
        // Left side is empty.
        sLeft = 0;
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

    int i = 0;
    Node* curr = m_root;
    char direction = position[i];

    // Check to see if the root is NULL.
    if(curr == NULL)        {   return false;   }

    // Check to see if we're just looking for the root.
    if(position == "")      {   return true;    }

    while(direction != '\0') {
        // We reached the end of the locate call and found that no such node
        // exists at the requested point.
        if(curr == NULL)    {   return false;   }

        switch(direction) {

            case 'L':
                // Check left direction.
                curr = curr->m_left;
                break;
            case 'R':
                // Check right direction
                curr = curr->m_right;
                break;
            default:
                // The input we got for locate's location was invalid.
                throw std::invalid_argument("locate() had invalid direction");
        }

        i++;
        direction = position[i];
    }

    key = curr->m_key;

}


void LazyBST::flattenNodes(
        Node* &on, int& index, Node* arr[], int size ) {

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

    // Whether or not the recurrsion resulted in an insertion.
    Node* result = NULL;

    // Check if it's time to add a new node.
    if(on == NULL) {

        return new Node(key) ;
    
    } else {

        if(key == on->m_key) {
            
            // This tells us that no Node was inserted.
            return NULL;
        
        } else if(key > on->m_key) {

            // Do the recurrsion.
            result = insertAndRecurr(on->m_right, key);
            
            if(result == NULL) {

                // No node was inserted, just recurr up the tree doing 
                // nothing
                return NULL;

            } else {

                // If we did add a new node somewhere in subtrees, increment
                // the size and height counters.
                on->m_size++;
                on->m_height++;

                // If the current one on the right is not the same as the one
                // on.m_rightjust got back, do some reasignment.
                if(on->m_right->m_key != result->m_key) {    
                    // TODO: Inspect what I was doing here, I can't remember 
                    // doing it or why.
                    on->m_right = result;
                }

                return on;

            }


        } else if(key < on->m_key) {

            // Do the recurrsion.
            result = insertAndRecurr(on->m_left, key);
            
            if(result == NULL) {

                // No node was inserted, just recurr up the tree doing 
                // nothing
                return NULL;

            } else {

                // If we did add a new node somewhere in subtrees, increment
                // the size and height counters.
                on->m_size++;
                on->m_height++;

                // If the current one on the right is not the same as the one
                // on.m_rightjust got back, do some reasignment.
                if(on->m_left->m_key != result->m_key) {    
                    // TODO: Same inspection here.
                    on->m_left = result;
                }

                return on;

            }

        } 

    }

}



Node* LazyBST::removeAndRecurr(Node* &on, int toRemove, bool &wasRemoved) {

    // Whether or not the recurrsion resulted in an insertion.
    Node* result = NULL;

    // Check if it's time to add a new node.
    if(on == NULL) {

        return NULL ;

    } else {

        if(toRemove == on->m_key) {

            Node* toReturnIfDelete;

            if(on->m_left != NULL && on->m_right != NULL) {
                // There are two children, uh oh.


            } else if(on->m_left != NULL && on->m_right == NULL) {
                // One child on the left
                toReturnIfDelete = on->m_left;

            } else if(on->m_left == NULL && on->m_right != NULL) {
                // One child on the right.
                toReturnIfDelete = on->m_right;

            } else {
                // No children.
                toReturnIfDelete = NULL;
            }

            // This tells us that no Node was inserted.
            *wasRemoved = true;

            // Free the memory
            on->m_left = NULL;
            on->m_right = NULL;
            delete on;


            return toReturnIfDelete;

        } else if(toRemove > on->m_key) {

            // Do the recurrsion.
            result = removeAndRecurr(on->m_right, toRemove, wasRemoved);

            if(wasRemoved) {
                // Since we removed one, we should subtract the size.
                on->m_size--;
                // Correct the height of the subtree.
                on->m_height = getMaxHeightBelow(on) + 1; 
                
                on->m_right = result;

                return on;

            } else {

                return on;

            }

        } else if(toRemove < on->m_key) {

            // Do the recurrsion
            result = removeAndRecurr(on->m_left, toRemove, wasRemoved);

            if(wasRemoved) {
                // Since we removed one, we should subtract the size.
                on->m_size--;
                // Correct the height of the subtree.
                on->m_height = getMaxHeightBelow(on) + 1; 
                
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
        return findMin(on->m_left)
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

        flattenNodes(on, flattenIndex, arr, subTreeSize);
        unlinkAllFromChildren(arr, subTreeSize);

        Node* newRoot = insertDuringRebalance(0, subTreeSize - 1, arr);

    }

}


// This is a recursive function that goes through the flattened tree and
// generates a new tree. In order to do this is uses a binary search-esque
// movement to return new Nodes.
Node* LazyBST::insertDuringRebalance(int lower, int upper, Node* arr[]) {
    
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
