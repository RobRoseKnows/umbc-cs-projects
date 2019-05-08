# Homework 4

Robert Rose

## Problem 1

Exercises 10.14 (10 pts) and 10.17 (10 pts). 

### Exercise 10.14

In the variable-length record representation, a null bitmap is used to
indicate if an attribute has the null value.

#### a. 

For variable length fields, if the value is null, what would be stored
in the offset and length fields?

#### b.

In some applications, tuples have a very large number of attributes,
most of which are null. Can you modify the record representation
such that the only overhead for a null attribute is the single bit in
the null bitmap.

### Exercise 10.17

List two advantages and two disadvantages of each of the following strategies 
for storing a relational database:

#### a. Store each relation in one file.

#### b. Store multiple relations (perhaps even the entire database) in one file.

