<?php
session_start();

//grabs session vars
$_SESSION["firstName"] = ($_POST["firstName"]);
$_SESSION["lastName"] = ($_POST["lastName"]);
$_SESSION["studEmail"] = $_POST["studEmail"];
$_SESSION["major"] = $_POST["major"];

//makes changes changes
$firstn = ($_POST["firstName"]);
$lastn = ($_POST["lastName"]);
$email = $_POST["studEmail"];
$major = $_POST["major"];
$sid = $_SESSION["SIDNumber"];

//Actually update student data
$debug = false;
include('./CommonMethods.php');
$COMMON = new Common($debug);
	$sql = "update `Student Data` set `FirstName` = '$firstn', `LastName` = '$lastn', `Email` = '$email', `Major` = '$major' where `StudentID` = '$sid'";
	$rs = $COMMON->executeQuery($sql, $_SERVER["SCRIPT_NAME"]);

header('Location: studentHome.php');
?>