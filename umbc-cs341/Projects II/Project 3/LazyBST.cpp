/**
 * File:    LazyBST.cpp
 * Author:  Robert Rose
 * Email:   robrose2@umbc.edu
 *
 * CS341 Project 3: LazyBST
 *
 */


// Constructors
LazyBST::LazyBST() {


}


LazyBST::LazyBST(const LazyBST& other) {


}

// Destructor
LazyBST::~LazyBST() {


}


// Operators
const LazyBST& LazyBST::operator=(const LazyBST& rhs) {


}


// Methods
void LazyBST::insert(int key) {


}


bool LazyBST::remove(int key) {


}


bool LazyBST::find(int key) {


}


void LazyBST::inorder() {


}


void LazyBST::rebalance() {


}


bool LazyBST::locate(const char *position, int& key) {

    

}


void LazyBST::flattenAndDisconnectNodes(
        Node* on, int& index, Node** arr, int size ) {

    if(on->m_left != NULL) {
        flattenNodes(on->m_left, index, arr, size);
        on->m_left = NULL;
    }

    arr[index] = on;
    on++;

    if(on->m_right != NULL) {

    }
}



Node* LazyBST::insertAndRecurr(Node* on, int key) {

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

                // No node was inserted, just recurr up the tree doing nothing
                return NULL;

            } else {

                // If we did add a new node somewhere in subtrees, increment
                // the size and height counters.
                on->m_size++;
                on->m_height++;

                // If the current one on the right is not the same as the one
                // on.m_rightjust got back, do some reasignment.
                if(on->m_right->m_key != result->m_key) {    
                    on->m_right = result;
                }

                return on;

            }


        } else if(key < on->m_key) {

            // Do the recurrsion.
            result = insertAndRecurr(on->m_left, key);
            
            if(result == NULL) {

                // No node was inserted, just recurr up the tree doing nothing
                return NULL;

            } else {

                // If we did add a new node somewhere in subtrees, increment
                // the size and height counters.
                on->m_size++;
                on->m_height++;

                // If the current one on the right is not the same as the one
                // on.m_rightjust got back, do some reasignment.
                if(on->m_left->m_key != result->m_key) {    
                    on->m_left = result;
                }

                return on;

            }

        }

    }

}




Node* LazyBST::rebalanceAndRecurr(Node* on) {

    // Check to see if it's NULL, if so, return.
    if(on == NULL) {
        return on;
    }

    // Check to see if it's too short to continue rebalancing. 
    if(on->m_height <= 3) {
        return on;
    }


    int hLeft; 
    if(on->m_left != NULL) {
        on->m_left = rebalanceAndRecurr(on->m_left);
        hLeft = on->m_left->m_height;
    } else {
        hLeft = 0;
    }


    int hRight;
    if(on->m_right != NULL) {
        on->m_right = rebalanceAndRecurr(on->m_right);
        hRight = on->m_right->m_height;
    } else {
        hRight = 0;
    }
     

    if(abs(hLeft - hRight) >= min(hLeft, hRight) ) {

               

    }

}


