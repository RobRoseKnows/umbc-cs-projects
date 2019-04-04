# Homework 3

Robert Rose

## Problem 1

Exercise 4.6 from the DSC textbook

### Exercise 4.6

Complete the SQL DDL definition of the university database of Figure 4.8 to include 
the relations `student`, `takes`, `advisor`, and `prereq`.

```sql
create table student
    (
        `ID`        varchar(5) not null,
        `name`      varchar(20) not null,
        `dept_name` varchar(20),
        `tot_cred`  decimal(3,0),
        primary key(`ID`),
        foreign key(`dept_name`) references department
    )

create table takes
    (
        `ID`        varchar(5) not null,
        `course_id` varchar(8) not null,
        `sec_id`    varchar(8) not null,
        `semester`  varchar(6) not null, check(`semester` in 
                                                (`Fall`, `Winter`, `Spring`, `Summer`)
                                            ),
        `year`      numeric(4,0) not null, check(`year` > 1759 and `year` < 2100),
        `grade`     varchar(2),
        primary key(`ID`, `course_id`, `sec_id`, `semester`, `year`),
        foreign key(`course_id`, `sec_id`, `semester`, `year`) references section,
        foreign key(`ID`) references student
    )

create table advisor
    (
        `s_ID`      varchar(5) not null,
        `i_ID`      varchar(5),
        primary key(`s_ID`),
        foreign key(`s_ID`) references student(`ID`),
        foreign key(`i_ID`) references insructor(`ID`)
    )

create table prereq
    (
        `course_id` varchar(8) not null,
        `prereq_id` varchar(8) not null,
        primary key(`course_id`, `prereq_id`),
        foreign key(`course_id`) references course(`course_id`),
        foreign key(`prereq_id`) references course(`course_id`)
    )
```