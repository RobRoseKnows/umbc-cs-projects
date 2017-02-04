<!-- validate_advisor.php -->
<!-- This file will validate the registration of the advisor -->

<?php
session_start();

require_once('../mysql_connect.php');

$posted_email = ($_POST['email']);

$sql = "SELECT Email FROM advisors WHERE `Email` = '$posted_email'";
$rs = mysql_query($sql, $conn);

//By default no errors
$errors = False;
$error_message = "";

if(mysql_num_rows($rs) > 0) {
  $errors = True;
  $error_message = "Email already taken<br>";
}

//Username left blank check
if ($posted_email == "")
{
    $errors = True;
    $error_message .= "Email field can't be blank.<br>";
}

/*
elseif (preg_match("/^[A-Za-z0-9._+-]+@umbc\.edu$/", $_POST['email']))
{
    $errors = True;
    $error_message .= "Not a valid UMBC Email Address<br>";
}
*/

//First name left blank check
if ($_POST['fName'] == "")
{
    $errors = True;
    $error_message .= "First name field can't be blank.<br>";
}

//Last name left blank check
if ($_POST['lName'] == "") 
{
    $errors = True;
    $error_message .= "Last name field can't be blank.<br>";
}

//office left blank
if ($_POST['office'] == "")
  {
    $errors = True;
    $error_message .= "Office field can't be blank.<br>";
  }

//passwords given do not match
if ($_POST['password'] != $_POST['rePassword']) 
{
    $errors = True;
    $error_message .= "Passwords do not match.<br>";
}

if ($errors != True) 
{
  //No errors - GOOD - Insert into database
  $fullName = ($_POST['fName'] . " " . $_POST['lName']);
  $email = ($_POST['email']);
  $office = ($_POST['office']);
  $password = $_POST['password'];
    $hashedPass = md5($password);

    $queryFormat = "INSERT INTO `advisors` (`Email`, `fullName`, `Office`, `Password`) VALUES ('%s', '%s', '%s', '%s')";

    $queryBuilt = sprintf($queryFormat, $email, $fullName, $office, $hashedPass);
  
  $rs = mysql_query($queryBuilt, $conn);
  
  session_start();
  $_SESSION['username'] = $email;
  header('Location:../../php/view/advisor_view.php');
}
else
{
  require('../../html/error_forms/register_advisor_error.html');
}
?>
