<?php

include('CommonMethods.php');
$debug = true;
$COMMON = new Common($debug);

//if the passwords given both match, create a new advisor
if(($_POST['password']) == ($_POST['rePassword'])){

  $advIdNum = ($_POST['advIdNum']);
  $fName = ($_POST['fName']);
  $lName = ($_POST['lName']);
  $password = ($_POST['password']);
  $office = ($_POST['office']);

  $sql = "insert into `Advisor Data` (`ID`, `StudentID`, `FirstName`, `LastName`,`Password`, `Office`) values (NULL, '$advIdNum', '$fName', '$lName','".md5($password)."','$office')";

  $rs = $COMMON->executeQuery($sql, $_SERVER["SCRIPT_NAME"]);
header('Location: index.html');

}

//otherwise, the passwords do not match and the user must be re-prompted
else{

  header('Location: advisorSignup.php');

}
?>
