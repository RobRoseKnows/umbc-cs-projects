<?php
include('CommonMethods.php');
$debug = true;
$COMMON = new Common($debug);
//if the passwords given both match, create a new student
if(($_POST['password']) == ($_POST['rePassword'])){
  $studIdNum = ($_POST['studIdNum']);
  $fName = ($_POST['fName']);
  $lName = ($_POST['lName']);
  $major = ($_POST['major']);
  $password = ($_POST['password']);
  $email = ($_POST['studEmail']);
  $sql = "insert into `Student Data` (`ID`, `StudentID`, `FirstName`, `LastName`,`Password`, `ApptNum`,`Major`,`Email`) values (NULL, '$studIdNum', '$fName', '$lName', '".md5($password)."', NULL, '$major','$email')";
  $rs = $COMMON->executeQuery($sql, $_SERVER["SCRIPT_NAME"]);

header('Location: index.html');
}
//otherwise, the passwords do not match and the user must be re-prompted
else{
  header('Location: studentSignup.php');
}
?>