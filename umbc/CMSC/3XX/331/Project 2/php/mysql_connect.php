<!-- mysql_connect.php -->
<!-- This file holds the information about connecting to the database that holds the necessary information -->

<?php

//Database connection under user "userweb"

/*DEFINE('DB_HOST', 'localhost');
DEFINE('DB_USER', 'root');
DEFINE('DB_PASSWORD', '');
DEFINE('DB_NAME', 'she3');

$conn = @mysql_connect(DB_HOST, DB_USER, DB_PASSWORD) or die("Could not con\
nect to MySQL");
$rs = @mysql_select_db(DB_NAME, $conn) or die("Could not connect select $db database");*/


$conn = @mysql_connect("studentdb-maria.gl.umbc.edu", "she3", "she3") or die("Could not connect to MySQL");
$rs = @mysql_select_db("she3", $conn) or die("Could not connect select $db database");

?>