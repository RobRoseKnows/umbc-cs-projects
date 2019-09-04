/* loanmust drop tables with foreign keys first
   due to referential integrity constraints
 */
-- use dbname
-- SET storage_engine=InnoDB;

drop table if exists depositor;
drop table if exists borrower;
drop table if exists account;
drop table if exists loan;
drop table if exists customer;
drop table if exists branch;

CREATE TABLE customer (
    customer_name VARCHAR(15) NOT NULL,
    customer_street VARCHAR(12) NOT NULL,
    customer_city VARCHAR(15) NOT NULL,
    PRIMARY KEY (customer_name)
);
    
CREATE TABLE branch (
    branch_name VARCHAR(15) NOT NULL,
    branch_city VARCHAR(15) NOT NULL,
    assets REAL NOT NULL,
    PRIMARY KEY (branch_name)
);
    
CREATE TABLE account (
    account_number VARCHAR(15) NOT NULL,
    branch_name VARCHAR(15) NOT NULL,
    balance REAL NOT NULL,
    PRIMARY KEY (account_number),
    FOREIGN KEY (branch_name)
        REFERENCES branch (branch_name)
);

CREATE TABLE loan (
    loan_number VARCHAR(15) NOT NULL,
    branch_name VARCHAR(15) NOT NULL,
    amount REAL NOT NULL,
    PRIMARY KEY (loan_number),
    FOREIGN KEY (branch_name)
        REFERENCES branch (branch_name)
);

CREATE TABLE depositor (
    customer_name VARCHAR(15) NOT NULL,
    account_number VARCHAR(15) NOT NULL,
    PRIMARY KEY (customer_name , account_number),
    FOREIGN KEY (account_number)
        REFERENCES account (account_number),
    FOREIGN KEY (customer_name)
        REFERENCES customer (customer_name)
);

CREATE TABLE borrower (
    customer_name VARCHAR(15) NOT NULL,
    loan_number VARCHAR(15) NOT NULL,
    PRIMARY KEY (customer_name , loan_number),
    FOREIGN KEY (customer_name)
        REFERENCES customer (customer_name),
    FOREIGN KEY (loan_number)
        REFERENCES loan (loan_number)
);

/* populate relations */

insert into customer	values ('Jones',	'Main',		'Harrison');
insert into customer	values ('Smith',	'Main',		'Rye');
insert into customer	values ('Hayes',	'Main',		'Harrison');
insert into customer	values ('Curry',	'North',	'Rye');
insert into customer	values ('Lindsay',	'Park',		'Pittsfield');
insert into customer	values ('Turner',	'Putnam',	'Stamford');
insert into customer	values ('Williams',	'Nassau',	'Princeton');
insert into customer	values ('Adams',	'Spring',	'Pittsfield');
insert into customer	values ('Johnson',	'Alma',		'Palo Alto');
insert into customer	values ('Glenn',	'Sand Hill',	'Woodside');
insert into customer	values ('Brooks',	'Senator',	'Brooklyn');
insert into customer	values ('Green',	'Walnut',	'Stamford');
insert into customer	values ('Jackson',	'University',	'Salt Lake');
insert into customer	values ('Majeris',	'First',	'Rye');
insert into customer	values ('McBride',	'Safety',	'Rye');

insert into branch	values ('Downtown',	'Brooklyn',	 900000);
insert into branch	values ('Redwood',	'Palo Alto',	2100000);
insert into branch	values ('Perryridge',	'Horseneck',	1700000);
insert into branch	values ('Mianus',	'Horseneck',	 400200);
insert into branch	values ('Round Hill',	'Horseneck',	8000000);
insert into branch	values ('Pownal',	'Bennington',	 400000);
insert into branch	values ('North Town',	'Rye',		3700000);
insert into branch	values ('Brighton',	'Brooklyn',	7000000);
insert into branch	values ('Central',	'Rye',		 400280);

insert into account	values ('A-101',	'Downtown',	500);
insert into account	values ('A-215',	'Mianus',	700);
insert into account	values ('A-102',	'Perryridge',	400);
insert into account	values ('A-305',	'Round Hill',	350);
insert into account	values ('A-201',	'Perryridge',	900);
insert into account	values ('A-222',	'Redwood',	700);
insert into account	values ('A-217',	'Brighton',	750);
insert into account	values ('A-333',	'Central',	850);
insert into account	values ('A-444',	'North Town',	625);

insert into depositor values ('Johnson','A-101');
insert into depositor values ('Smith',	'A-215');
insert into depositor values ('Hayes',	'A-102');
insert into depositor values ('Hayes',	'A-101');
insert into depositor values ('Turner',	'A-305');
insert into depositor values ('Johnson','A-201');
insert into depositor values ('Jones',	'A-217');
insert into depositor values ('Lindsay','A-222');
insert into depositor values ('Majeris','A-333');
insert into depositor values ('Smith',	'A-444');

insert into loan	values ('L-17',		'Downtown',	1000);
insert into loan	values ('L-23',		'Redwood',	2000);
insert into loan	values ('L-15',		'Perryridge',	1500);
insert into loan	values ('L-14',		'Downtown',	1500);
insert into loan	values ('L-93',		'Mianus',	500);
insert into loan	values ('L-11',		'Round Hill',	900);
insert into loan	values ('L-16',		'Perryridge',	1300);
insert into loan	values ('L-20',		'North Town',	7500);
insert into loan	values ('L-21',		'Central',	570);

insert into borrower values ('Jones',	'L-17');
insert into borrower values ('Smith',	'L-23');
insert into borrower values ('Hayes',	'L-15');
insert into borrower values ('Jackson',	'L-14');
insert into borrower values ('Curry',	'L-93');
insert into borrower values ('Smith',	'L-11');
insert into borrower values ('Williams','L-17');
insert into borrower values ('Adams',	'L-16');
insert into borrower values ('McBride',	'L-20');
insert into borrower values ('Smith',	'L-21');