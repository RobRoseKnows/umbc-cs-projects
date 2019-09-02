<?php
session_start();
$debug = false;
include('./CommonMethods.php');
$COMMON = new Common($debug);

//cancels session and changes necessary table values
if($_POST["cancel"] == 'Cancel'){
		
	//remove stud from EnrolledID
	$studentID = ($_SESSION['SIDNumber']);

	$sql = "select * from Appointment where `listOfStudents` like '%$studentID%'";
	$rs = $COMMON->executeQuery($sql, $_SERVER["SCRIPT_NAME"]);

	$row = mysql_fetch_row($rs);


	$apptNum = $row[0];

	$updatesIDList = str_replace($studentID, "", $row[7]);
	
	$sql = "update `Appointment` set `numStudents` = numStudents-1, `listOfStudents` = '$updatedIDList' where `ID` = '$apptNum'";
	$rs = $COMMON->executeQuery($sql, $_SERVER["SCRIPT_NAME"]);
	

	//update their AppointmentNumber
	$sql = "update `Student Data` set `ApptNum` = NULL where `StudentID` = '$studentID'";
	$rs = $COMMON->executeQuery($sql, $_SERVER["SCRIPT_NAME"]);
	
}
else{

}

header('Location: studentHome.php');

?>