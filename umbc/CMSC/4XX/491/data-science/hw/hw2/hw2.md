# HW 2
## Rob Rose

## Part 1

Write each of the following queries: For each query, turn in the query and the result of running it on the Retail database that you just created. 


### Query 1

**Prompt:** Count the number of employees whose last name or first name starts with 
the letter 'P'. 

**Query:**

```{sql}
SELECT COUNT(*) FROM employees WHERE (lastName LIKE 'P%' OR firstName LIKE 'P%');
```

**Result:**
>5


### Query 2

**Prompt:** For how many letters of the alphabet are there more than one employee
 whose last name starts with that letter? Hint: The substr function will be useful 
 here in a GROUP BY clause. 

**Query:**

```{sql}
SELECT (COUNT(*) > 1) FROM employees GROUP BY SUBSTR(lastName, 1, 1);
```

**Result:**
>7


### Query 3

**Prompt:** How many orders have not yet shipped? 

**Query:**

```{sql}
SELECT COUNT(*) FROM orders WHERE status != "shipped";
```

**Result:**
>23


### Query 4

**Prompt:** How many orders where shipped less than 2 days before they were required?  

**Query:**

```{sql}
SELECT COUNT(*) FROM orders WHERE shippedDate + 2 > requiredDate;
```

**Result:**
>25


### Query 5

**Prompt:** For each distinct product line, what is the total dollar value of 
orders placed? 

**Query:**

```{sql}
SELECT                                                                                          productLine,
    SUM(quantityOrdered * priceEach) total
FROM
    orderdetails
        INNER JOIN
    products USING (productCode)
GROUP BY productLine;
```

**Result:**
>+------------------+------------+
>| productLine      | total      |
>+------------------+------------+
>| Classic Cars     | 3853922.49 |
>| Motorcycles      | 1121426.12 |
>| Planes           |  954637.54 |
>| Ships            |  663998.34 |
>| Trains           |  188532.92 |
>| Trucks and Buses | 1024113.57 |
>| Vintage Cars     | 1797559.63 |
>+------------------+------------+


### Query 6

**Prompt:** For each distinct product line, what is the total dollar value of 
orders placed? 

**Query:**

```{sql}
SELECT                                                                                          productLine,
    SUM(quantityOrdered * priceEach) total
FROM
    orderdetails
        INNER JOIN
    products USING (productCode)
GROUP BY productLine;
```

**Result:**
>+------------------+------------+
>| productLine      | total      |
>+------------------+------------+
>| Classic Cars     | 3853922.49 |
>| Motorcycles      | 1121426.12 |
>| Planes           |  954637.54 |
>| Ships            |  663998.34 |
>| Trains           |  188532.92 |
>| Trucks and Buses | 1024113.57 |
>| Vintage Cars     | 1797559.63 |
>+------------------+------------+