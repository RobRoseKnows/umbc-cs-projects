# Homework 3

Robert Rose

## Problem 1

Exercise 4.1 from the DSC textbook

### Exercise 4.1

Write the following queries in SQL , using the university schema.

All of these queries were followed by the query `USE university;` I didn't include
it in each snippet because it would've been redundant.

#### a. 

Display a list of all instructors, showing their ID, name, and the number of sections 
that they have taught. Make sure to show the number of sections as 0 for instructors 
who have not taught any section. Your query should use an outerjoin, and should not 
use scalar subqueries.

```sql
--- I couldn't for the life of me get this to run in MySQL workbench, but I can't
--- see what's wrong with it!
SELECT `ID`, `name`, count(`course_id`, `sec_id`, `year`, `semester`) as "Taught"
FROM instructor NATURAL LEFT OUTER JOIN teaches
GROUP BY(`ID`, `name`);
```

#### b. 

Write the same query as above, but using a scalar subquery, without outerjoin.

```sql
SELECT `ID`, `name`, (SELECT count(*) as "Taught" from teaches T where T.ID = I.ID)
FROM instructor I;
```

#### c.

Display the list of all course sections offered in Spring 2010, along with the names 
of the instructors teaching the section. If a section has more than one instructor, 
it should appear as many times in the resultas it has instructors. If it does not have 
any instructor, it should stillappear in the result with the instructor name set to "—".

```sql
SELECT section.course_id, section.sec_id, decode(instructor.name, NULL, "—", instructor.name)
FROM section NATURAL LEFT OUTER JOIN teaches NATURAL LEFT OUTER JOIN instructor
WHERE teaches.semester="Spring" and teaches.year=2010;
```

#### d.

Display the list of all departments, with the total number of instructors in each 
department, without using scalar subqueries. Make sure tocorrectly handle departments 
with no instructors.

```sql
SELECT dept_name, count(ID) FROM department NATURAL LEFT OUTER JOIN instructor
GROUP BY dept_name;
```
