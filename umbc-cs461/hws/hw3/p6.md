# Homework 3

Robert Rose

## Problem 1

Exercise 7.20 from the DSC textbook. Further, provide appropriate SQL commands 
in a script file that creates appropriate tables your ER model, together with 
all appricable (primary key, unique, not null, and referencial) integrity 
constraints. 

### Exercise 7.20

Consider theE-Rdiagram in Figure 7.29, which models an online bookstore.

![entity-relationship-diagram](./e-r-7-20-pre.png)

#### a. 

List the entity sets and their primary keys.

Primary keys in bold.

- author (**name**, addressl, url)
- book (**ISBN**, title, year, price)
- publisher(**name**, address, phone, URL)
- shopping_basket(**basket_id**)
- warehouse(**code**, address, phone)
- customer(**email**, name, address, phone)

#### b. 

Suppose the bookstore adds Blu-ray discs and downloadable videoto its collection. 
The same item may be present in one or both formats,with differing prices. Extend 
the E-R diagram to model this addition,ignoring the effect on shopping baskets.

![entity-relationship-diagram](./e-r-7-20-b.png)

#### c. 

Now extend the E-R diagram, using generalization, to model the case where a 
shopping basket may contain any combination of books, Blu-ray discs, or 
downloadable video.

![entity-relationship-diagram](./e-r-7-20-c.png)