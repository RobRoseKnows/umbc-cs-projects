#include "LazyBST.h"
#include<iostream>

int main() {

    // I didn't get everything finished but I need to move on to other
    // homework asignments so I'm submitting this as is.
    //
    // I'm pretty sure inserting works 100%
    // I know inorder() is working 100%.
    // I know copy constructor is working 100%
    // I'm pretty sure rebalance() works most of the time.
    // I'm not sure if remove is working working 100%.
    // There are some errors that pop up on some of the harder tests.
    // No memory leaks though!
    //
    // I probably could have done this better if I made everything work
    // in-place (that's not the right word, but I'm not sure what is) without
    // moving a bunch of pointers around..
    cout << "Insert Test" << endl;

    LazyBST T1;

    T1.insert(1);
    T1.insert(2);
    T1.insert(3);

    T1.inorder();
    cout << endl;

    T1.insert(4);
    
    T1.inorder();
    cout << endl;

    T1.insert(10);
    
    T1.inorder();
    cout << endl;

    T1.insert(20);

    T1.inorder();
    cout << endl;

    cout << endl;
    cout << "Try Copy Constructor" << endl;

    LazyBST T2 = LazyBST(T1);
    T2.inorder();
    cout << endl;

}
