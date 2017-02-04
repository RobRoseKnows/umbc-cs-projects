<?php

include('CommonMethods.php');
$debug = true;
$COMMON = new Common($debug);
session_start();



$date = ($_POST['Date']);
$maxStudents = ($_POST['studentLimit']);
$location = ($_POST['location']);

//combine all majors accepted into one large string
$majorMaster = "";
foreach($_POST['major'] as $major)
{
  $majorMaster .= $major;
  $majorMaster .= ',';
}
$advID = ($_SESSION['ADVIDNumber']);
if($_POST['Group'] == "Group")
{
	$advID = "Group";
}
//add each appointment at given time(s) to database
foreach($_POST['time'] as $time){

    $sql = "insert into `Appointment` (`ID`, `Location`, `TimeSlot`, `Day`,`Major`, `numStudents`, `maxStudents`, `listOfStudents`, `advisorID`) values (NULL, '$location', '$time', '$date','$majorMaster', 0 , '$maxStudents', '','$advID')";

    $rs = $COMMON->executeQuery($sql, $_SERVER["SCRIPT_NAME"]);
}

header('Location: advisorHome.php');
?>

