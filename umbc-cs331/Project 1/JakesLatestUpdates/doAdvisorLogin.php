<?php

session_start();
include('CommonMethods.php');
$debug = true;
$COMMON = new Common($debug);

//store both the id number and password given
$advIdNum = ($_POST['advIdNum']);
$password = ($_POST['password']);
$truePassword = md5($password);

$_SESSION['ADVIDNumber'] = ($_POST['advIdNum']);

$_SESSION['PRINTFAIL'] = FALSE;

$sql = "SELECT * FROM `Advisor Data` WHERE `StudentID` = '$advIdNum' AND `Password` = '$truePassword'";

//determine how many matches the password has for that ID in the database
$rs = $COMMON->executeQuery($sql, $_SERVER["SCRIPT_NAME"]);
$num_rows = mysql_num_rows($rs);

//if only one match, password correct
if($num_rows == 1){

  //allow user to access their homepage
  echo("correct!!");
  header('Location: advisorHome.php');
}

//otherwise, password is incorrect, route user back to login screen
else{

  header('Location: advisorSignIn.php');
}


?>


