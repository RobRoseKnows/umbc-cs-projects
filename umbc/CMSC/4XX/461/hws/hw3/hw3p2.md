# Homework 3

Robert Rose

## Problem 2

Exercise 4.5 and 4.13 from the DSC textbook

### Exercise 4.5

Show how to define the view `student_grades(ID, GPA)` giving the grade-point average 
of each student, based on the query in Exercise 3.2; recallthat we used a relation 
`grade_points(grade,points)` to get the numeric points associated with a letter grade. 
Make sure your view definition correctly handles the case of `null` values for the grade
attribute of the `takes` relation.

```sql
CREATE VIEW `student_grades` AS 
SELECT ID, sum(course.credits * grade_points.points) / sum(course.credits) AS GPA 
FROM (takes NATURAL JOIN course)
NATURAL JOIN grade_points
GROUP BY takes.ID; 
```

### Exercise 4.13

Under what circumstances would the query

```sql
select * 
from student natural full outer join takes natural full outer join course;
```

include tuples with null values for the `title` attribute?

- Any case where title has a null value in the `course` table.
- Any students who have not yet taken a course, which will result in the natural
  full outer join returning null attributes for all `course` values because there
  won't be anything to join in takes.
