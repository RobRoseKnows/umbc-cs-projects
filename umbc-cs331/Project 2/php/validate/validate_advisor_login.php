<!-- validate_advisor_login.php -->
<!-- This file contains validation for the advisor login, it will post the correct error message to the advisor_login_error.html page --> 

<?php

require_once('../mysql_connect.php');
session_start();
$email = $_POST['email'];
$password = ($_POST['password']);
$truePassword = md5($password);

// Make the query to get the info out of advisors table
$sql = "SELECT * FROM advisors WHERE `Email` = '$email' AND `Password` = '$truePassword'";
$rs = mysql_query($sql, $conn);
$name_found = False;

$_SESSION['error_message'] = "";
//count of how many many rows are returned when query is run 
$num_rows = mysql_num_rows($rs);

//if only one match, password correct
if($num_rows == 1){
   $name_found = True;
}


// This is the pass case
if ($name_found) 
{
 
  $_SESSION['advisorEmail'] = $email;
  header('Location:../../php/view/advisor_view.php');
} 

// This is the fail case
else
{

  // Username field left blank
  if ($email == "")
  {
    $_SESSION['error_message'] .= "Email field can't be blank.<br>";
  }

  // Username does not exist in the table OR password is incorrect
  else 
  {
    $_SESSION['error_message'] = "Email or password not recognized.<br>";
  } 

  header('Location: ../../html/forms/login_advisor.html');
}

?>
