<?php

session_start();
include('CommonMethods.php');
$debug = true;
$COMMON = new Common($debug);

//store both the id number and password given
$studIdNum = ($_POST['studIdNum']);
$password = ($_POST['password']);

$_SESSION['SIDNumber'] = ($_POST['studIdNum']);


$truePassword = md5($password);

$sql = "SELECT * FROM `Student Data` WHERE `StudentID` = '$studIdNum' AND `Password` = '$truePassword'";

//determine how many matches the password has for that ID in the database
$rs = $COMMON->executeQuery($sql, $_SERVER["SCRIPT_NAME"]);
$num_rows = mysql_num_rows($rs);
$row = mysql_fetch_row($rs);

$_SESSION['major']=$row[6];
$_SESSION['badSignup']=FALSE;

//if only one match, password correct
if($num_rows == 1){

  //allow user to access their homepage
header('Location: studentHome.php');
}

//otherwise, password is incorrect, route user back to login screen
else{

echo(".md5($password).");

  header('Location: studentSignIn.php');
}


?>
