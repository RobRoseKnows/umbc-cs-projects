
SELECT '- - - - - - - - - - - - - - - - - - - - - - - - - - - -' FROM DUAL;
SELECT 'All customer data.' FROM DUAL;
SELECT 
    *
FROM
    customer;


SELECT '- - - - - - - - - - - - - - - - - - - - - - - - - - - -' FROM DUAL;
SELECT 'All branch data.' FROM DUAL;
SELECT 
    *
FROM
    branch;

SELECT '- - - - - - - - - - - - - - - - - - - - - - - - - - - -' FROM DUAL;
SELECT 'All account data.' FROM DUAL;
SELECT 
    *
FROM
    account;

SELECT '- - - - - - - - - - - - - - - - - - - - - - - - - - - -' FROM DUAL;
SELECT 'All depositor data.' FROM DUAL;
SELECT 
    *
FROM
    depositor;

SELECT '- - - - - - - - - - - - - - - - - - - - - - - - - - - -' FROM DUAL;
SELECT 'All loan data.' FROM DUAL;
SELECT 
    *
FROM
    loan;

SELECT '- - - - - - - - - - - - - - - - - - - - - - - - - - - -' FROM DUAL;
SELECT 'All borrower data.' FROM DUAL;
SELECT 
    *
FROM
    borrower;

SELECT '- - - - - - - - - - - - - - - - - - - - - - - - - - - -' FROM DUAL;
SELECT 'Names and cities of all borrowers' FROM DUAL;
SELECT DISTINCT
    customer.customer_name, customer_city
FROM
    borrower,
    customer
WHERE
    borrower.customer_name = customer.customer_name
;

SELECT '- - - - - - - - - - - - - - - - - - - - - - - - - - - -' FROM DUAL;
SELECT 'Set of names and cities of customers who have a loan at Perryridge branch' FROM DUAL;
SELECT DISTINCT
    C.customer_name, customer_city
FROM
    customer C,
    borrower B,
    loan L
WHERE
    C.customer_name = B.customer_name
        AND B.loan_number = L.loan_number
        AND branch_name = 'Perryridge'
;

SELECT '- - - - - - - - - - - - - - - - - - - - - - - - - - - -' FROM DUAL;
SELECT 'Numbers of accounts with balances between 700 and 900.' FROM DUAL;
SELECT 
    account_number
FROM
    account
WHERE
    balance BETWEEN 700 AND 900;


SELECT '- - - - - - - - - - - - - - - - - - - - - - - - - - - -' FROM DUAL;
SELECT 'Names of customers on streets with names ending in "Hill".' FROM DUAL;
SELECT 
    customer_name
FROM
    customer
WHERE
    customer_street LIKE '%Hill'
;

SELECT '- - - - - - - - - - - - - - - - - - - - - - - - - - - -' FROM DUAL;
SELECT 'Names of customers with both accounts and loans at Perryridge branch.' FROM DUAL;
SELECT DISTINCT
    customer_name
FROM
    borrower,
    loan
WHERE
    borrower.loan_number = loan.loan_number
        AND branch_name = 'Perryridge'
        AND customer_name IN (SELECT 
            customer_name
        FROM
            account,
            depositor
        WHERE
            account.account_number = depositor.account_number
                AND branch_name = 'Perryridge')
;

SELECT '- - - - - - - - - - - - - - - - - - - - - - - - - - - -' FROM DUAL;
SELECT 'Names of customers with an account but not a loan at Perryridge branch.' FROM DUAL;
SELECT DISTINCT
    customer_name
FROM
    account,
    depositor
WHERE
    account.account_number = depositor.account_number
        AND branch_name = 'Perryridge'
        AND customer_name NOT IN (SELECT 
            customer_name
        FROM
            loan,
            borrower
        WHERE
            loan.loan_number = borrower.loan_number
                AND branch_name = 'Perryridge')
;

SELECT '- - - - - - - - - - - - - - - - - - - - - - - - - - - -' FROM DUAL;
SELECT 'Names and cities of all borrowers.' FROM DUAL;
SELECT DISTINCT
    C.customer_name, customer_city
FROM
    borrower B,
    customer C
WHERE
    B.customer_name = C.customer_name
;

SELECT '- - - - - - - - - - - - - - - - - - - - - - - - - - - -' FROM DUAL;
SELECT 'Set of names of customers with accounts at a branch where Hayes has' FROM DUAL;
SELECT 'An account.' FROM DUAL;
SELECT DISTINCT
    D.customer_name
FROM
    depositor D,
    account A
WHERE
    D.account_number = A.account_number
        AND branch_name IN (SELECT 
            branch_name
        FROM
            depositor Dh,
            account Ah
        WHERE
            Dh.account_number = Ah.account_number
                AND D.customer_name = 'Hayes')
;

SELECT '- - - - - - - - - - - - - - - - - - - - - - - - - - - -' FROM DUAL;
SELECT 'Set of names of branches whose assets are greater than the assets of' FROM DUAL;
SELECT 'some branch in Brooklyn' FROM DUAL;
SELECT DISTINCT
    T.branch_name
FROM
    branch T,
    branch S
WHERE
    T.assets > S.assets
        AND S.branch_city = 'Brooklyn'
;

SELECT '- - - - - - - - - - - - - - - - - - - - - - - - - - - -' FROM DUAL;
SELECT 'Set of names of branches whose assets are greater than the assets of' FROM DUAL;
SELECT 'All branches in Brooklyn' FROM DUAL;
SELECT 
    branch_name
FROM
    branch
WHERE
    assets > ALL (SELECT 
            assets
        FROM
            branch
        WHERE
            branch_city = 'Brooklyn')
;

SELECT '- - - - - - - - - - - - - - - - - - - - - - - - - - - -' FROM DUAL;
SELECT 'Names of customers with both accounts and loans at Perryridge branch' FROM DUAL;
SELECT '(using "exists").' FROM DUAL;
SELECT 
    customer_name
FROM
    customer
WHERE
    EXISTS( SELECT 
            *
        FROM
            account,
            depositor
        WHERE
            account.account_number = depositor.account_number
                AND depositor.customer_name = customer.customer_name
                AND branch_name = 'Perryridge')
        AND EXISTS( SELECT 
            *
        FROM
            loan,
            borrower
        WHERE
            loan.loan_number = borrower.loan_number
                AND borrower.customer_name = customer.customer_name
                AND branch_name = 'Perryridge')
;

SELECT '- - - - - - - - - - - - - - - - - - - - - - - - - - - -' FROM DUAL;
SELECT 'Names of customers with an account but not a loan at Perryridge branch' FROM DUAL;
SELECT '(using "exists").' FROM DUAL;
SELECT 
    customer_name
FROM
    customer
WHERE
    EXISTS( SELECT 
            *
        FROM
            account,
            depositor
        WHERE
            account.account_number = depositor.account_number
                AND depositor.customer_name = customer.customer_name
                AND branch_name = 'Perryridge')
        AND NOT EXISTS( SELECT 
            *
        FROM
            loan,
            borrower
        WHERE
            loan.loan_number = borrower.loan_number
                AND borrower.customer_name = customer.customer_name
                AND branch_name = 'Perryridge')
;

SELECT '- - - - - - - - - - - - - - - - - - - - - - - - - - - -' FROM DUAL;
SELECT 'Set of names of customers at Perryridge branch, in alphabetical order.' FROM DUAL;
SELECT DISTINCT
    customer_name
FROM
    borrower,
    loan,
    branch
WHERE
    borrower.loan_number = loan.loan_number
        AND loan.branch_name = 'Perryridge'
ORDER BY borrower.customer_name
;

SELECT '- - - - - - - - - - - - - - - - - - - - - - - - - - - -' FROM DUAL;
SELECT 'Loan data, ordered by decreasing amounts, then increasing loan numbers.' FROM DUAL;
SELECT 
    *
FROM
    loan
ORDER BY amount DESC , loan_number ASC
;

SELECT '- - - - - - - - - - - - - - - - - - - - - - - - - - - -' FROM DUAL;
SELECT 'Names of branches having at least one account, with average account balances.' FROM DUAL;
SELECT 
    branch_name, AVG(balance)
FROM
    account
GROUP BY branch_name
;

SELECT '- - - - - - - - - - - - - - - - - - - - - - - - - - - -' FROM DUAL;
SELECT 'Names of branches having at least one account, with size of set of customers' FROM DUAL;
SELECT 'having at least one account at that branch.' FROM DUAL;
SELECT 
    branch_name, COUNT(DISTINCT customer_name)
FROM
    depositor,
    account
WHERE
    depositor.account_number = account.account_number
GROUP BY branch_name
;

SELECT '- - - - - - - - - - - - - - - - - - - - - - - - - - - -' FROM DUAL;
SELECT 'The average balance of all accounts.' FROM DUAL;
SELECT 
    AVG(balance)
FROM
    account
;

SELECT '- - - - - - - - - - - - - - - - - - - - - - - - - - - -' FROM DUAL;
SELECT 'Names of branches having at least one account, with average balances of' FROM DUAL;
SELECT 'Accounts at each branch, if that average is above 700.' FROM DUAL;
SELECT 
    branch_name, AVG(balance)
FROM
    account
GROUP BY branch_name
HAVING AVG(balance) > 700
;

SELECT '- - - - - - - - - - - - - - - - - - - - - - - - - - - -' FROM DUAL;
SELECT 'Name(s) of branch(es) having largest average balance.' FROM DUAL;
SELECT 
    branch_name
FROM
    account
GROUP BY branch_name
HAVING AVG(balance) >= ALL (SELECT 
        AVG(balance)
    FROM
        account
    GROUP BY branch_name)
;

SELECT '- - - - - - - - - - - - - - - - - - - - - - - - - - - -' FROM DUAL;
SELECT 'The number of customers.' FROM DUAL;
SELECT 
    COUNT(*)
FROM
    customer
;

SELECT '- - - - - - - - - - - - - - - - - - - - - - - - - - - -' FROM DUAL;
SELECT 'Average balance of all customers in Harrison having at least 2 accounts.' FROM DUAL;
SELECT avg(balance)
FROM depositor, account, customer
WHERE depositor.customer_name = customer.customer_name AND
	depositor.account_number = account.account_number AND
	customer_city = 'Harrison'
GROUP BY depositor.customer_name
HAVING COUNT(DISTINCT account.account_number) >= 2
;
