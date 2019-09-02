<?php
session_start();

include('../includes/CommonMethods.php');
$debug = true;
$COMMON = new CommonMethods($debug);

//store both the id number and password given
$studIdNum = ($_POST['studIdNum']);
$password = ($_POST['password']);

if($COMMON->isCorrectPassword($studIdNum, $password, true)){
  //allow user to access their homepage
  header('Location: ../studentHome.php');
}

//otherwise, password is incorrect, route user back to login screen
else{

//  echo(".md5($password).");

  header('Location: ../studentLogin.php');
}


?>
