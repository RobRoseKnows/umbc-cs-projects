README.docx

This file contains the information to make the tables and connect the tables to
the current code, allowing another group to setup a new server and get this
running. 

--- Connecting this code to new database ---
Notes: This connection assumes that the tables advisors, students, and 
appointments are already created in the data base that the code will connect 
to. Information about how to make these tables will be found later in the 
README.docx file. 

Step 1: Go to the mysql_connect.php file in the php directory. 
(The path for that section looks like PROJ1_Final/php/mysql_connect.php)
Step 2: Update the @mysql_connect parameters, our version of this should look
like this - 

     $conn = @mysql_connect("studentdb-maria.gl.umbc.edu", "eversam1", 
     	   "eversam1") or die("Could not connect to MySQL");

The first parameter has to be updated to your database, the second has to be 
your username to that database and the third has to be you password to that 
same database. 

Step 3: Update the @mysql_select_db parameters, our version of this should look
like this - 

     $rs = @mysql_select_db("eversam1", $conn) or die("Could not connect select	$db database");

The only parameter that must be updated is the first one, this should be the 
name of the database you want to connect to. 

Step 4: You are done, this should properly connect our code to your database.

--- Creating our tables in SQL ---
Notes: For this step you will be running three queries to create the advisors,
students, and appointments. 

Step 1: Creating the appointments table, all you have to do is run the following 
query to recreate our appointments table in sql.

 CREATE TABLE appointments(
   id INT NOT NULL AUTO_INCREMENT,
   Advisor TEXT NOT NULL,
   NumStudents  TINYINT(4) NOT NULL,
   Date VARCHAR(10) NOT NULL,
   Time VARCHAR(5) NOT NULL,
   isGroup BOOLEAN NOT NULL,
   isFull BOOLEAN NOT NULL,
   Location TEXT NOT NULL,
   AdvisorUsername TEXT NOT NULL,
   PRIMARY KEY (id)
);

Step 2: Creating the students table, all you have to do is run the following 
query to recreate our students table in sql.

 CREATE TABLE students(
   id INT NOT NULL AUTO_INCREMENT,
   Username TEXT NOT NULL,
   studentID  VARCHAR(7) NOT NULL,
   Major TEXT NOT NULL,
   Appt INT NULL,
   firstName TEXT NOT NULL,
   lastName TEXT NOT NULL,
   studentID VARCHAR(8) NOT NULL,
   email TEXT NOT NULL
   PRIMARY KEY (id)
);

Step 3: Creating the advisors table, all you have to do is run the following 
query to recreate our advisors table in sql.

 CREATE TABLE advisors(
   id INT NOT NULL AUTO_INCREMENT,
   Username TEXT NOT NULL,
   fullName TEXT NOT NULL,
   Office TEXT NOT NULL,
   PRIMARY KEY (id)
);

--- What to do after connecting to the database and making the tables ---
Now all you have to do is navigate to the correct webpage 
(starts at PROJ1_Final/html/forms/first_page.html) to begin. 