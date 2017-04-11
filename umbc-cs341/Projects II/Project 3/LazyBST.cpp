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


void LazyBST::flattenNodes(
        Node* on, int& index, Node** arr, int size ) {

    if(on->m_left != NULL) {
        flattenNodes(on->m_left, index, arr, size);
    }

    arr[index] = on;
    index++;

    if(on->m_right != NULL) {
        flattenNodes(on->m_right, index, arr, size);
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
        // Recurr on the left size first.
        on->m_left = rebalanceAndRecurr(on->m_left);
        hLeft = on->m_left->m_height;
    } else {
        // Left side is empty.
        hLeft = 0;
    }


    int hRight;
    if(on->m_right != NULL) {
        // Then recurr on the right side if there's stuff there. 
        on->m_right = rebalanceAndRecurr(on->m_right);
        hRight = on->m_right->m_height;
    } else { 
        // Right side is empty.
        hRight = 0;
    }
     

    if(abs(hLeft - hRight) >= min(hLeft, hRight) ) {

        int subTreeSize = on->m_size;

        int flattenIndex = 0;
        Node* arr[subTreeSize];

        flattenNodes(on, *flattenIndex, arr, subTreeSize);
        unlinkAllFromChildren(arr, subTreeSize);

        Node* newRoot = insertWithOrder(0, subTreeSize - 1, arr);

    }

}


Node* LazyBST::insertWithOrder(int lower, int upper, Node** arr) {
    
    int middle = lower + (upper - lower) / 2;
    
    Node* toReturn = arr[middle];

    // Catch to make sure we haven't reached the end.
    if(upper != lower) {

        toReturn->m_left = insertWithOrder(lower, middle, arr);
        toReturn->m_right = insertWithOrder(middle, upper, arr);

    }

    return toReturn;

}


// This separates all the nodes in a flattened BST from their children. This
// allows the rebalancing to take place more easily. It also sets all their
// heights to 0 and sizes to 1.

void LazyBST::unlinkAllFromChildren(Node** arr, int size) {
    for(int i = 0; i < size; i++) {

        arr[i]->m_height = 0;
        arr[i]->m_sizes = 1;
        arr[i]->m_left = NULL;
        arr[i]->m_right = NULL;

    }
    

}
