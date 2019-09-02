<?php

session_start();
include('../includes/CommonMethods.php');
$debug = true;
$COMMON = new CommonMethods($debug);

//store both the id number and password given
$advIdNum = ($_POST['advIdNum']);
$password = ($_POST['password']);

// I moved the password checking code to Common.

//if only one match, password correct
if($COMMON->isCorrectPassword($advIdNum, $password, false)){

  //allow user to access their homepage
  echo("correct!!");
  header('Location: ../advisorHome.php');
}

//otherwise, password is incorrect, route user back to login screen
else{

  header('Location: ../advisorLogin.php');
}


?>


