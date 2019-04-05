# Homework 3

Robert Rose

## Problem 1

Exercise 4.16 from the DSC textbook

### Exercise 4.16

Referential-integrity constraints as defined in this chapter involve exactly two 
relations. Consider a database that includes the relations shown in Figure 4.12. 
Suppose that we wish to require that every name that appears in `address` appears 
in either `salaried_worker` or `hourly_worker`, but not necessarily in both.

#### a. 

Propose a syntax for expressing such constraints.

```sql
--- A variant of the existing foreign key relationship syntax.
foreign key (name) references salaried_worker or hourly_worker
```

#### b. 

Discuss the actions that the system must take to enforce a constraintof this form.

Whenever a tuple is inserted into the address relation, a  lookup on the name value
must be made on the salaried_worker relation and hourly_worker relation. If it finds
a tuple, it can short circuit the other one, depending on the order in which they
appear. An advanced database system could do some threading in order to potentially
save lookup time. I actually don't know whether or not that would be superior tbh.

