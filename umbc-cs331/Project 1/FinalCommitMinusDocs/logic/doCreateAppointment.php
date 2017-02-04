<?php

include('CommonMethods.php');
$debug = true;
$COMMON = new Common($debug);


$date = ($_POST['Date']);
$maxStudents = ($_POST['studentLimit']);
$location = ($_POST['location']);

//combine all majors accepted into one large string
$majorMaster = "";
foreach($_POST['major'] as $major){
  $majorMaster .= $major;
}

//add each appointment at given time(s) to database
foreach($_POST['time'] as $time){

    $sql = "insert into `Appointment` (`ID`, `Location`, `TimeSlot`, `Day`,`\
Major`, `numStudents`, `maxStudents`, `listOfStudents`) values (NULL, '$loca\
tion', '$time', '$date','$majorMaster', 0 , '$maxStudents', '')";

    $rs = $COMMON->executeQuery($sql, $_SERVER["SCRIPT_NAME"]);
}

?>

