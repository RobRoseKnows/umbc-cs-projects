<?php
session_start();

$debug = false;
include('./CommonMethods.php');
$COMMON = new Common($debug);
$apptID = $_POST['apptNum'];
$SID = $_SESSION['SIDNumber'];

$sql = "select * from `Appointment` where `ID` = $apptID";
$rs = $COMMON->executeQuery($sql, $_SERVER["SCRIPT_NAME"]);
$row = mysql_fetch_array($rs);

$sql2 = "select * from `Student Data` where `StudentID` = '$SID'";
$rs2 = $COMMON->executeQuery($sql2, $_SERVER["SCRIPT_NAME"]);
$row2 = mysql_fetch_array($rs2);

//if no valid appts match that appt number, reject it
if(mysql_num_rows($rs)==0)
{
	$_SESSION['badSignup'] = TRUE;
	header('Location: studentHome.php');

}
//If you have an appt already, reject it
if($row2[5]!= NULL)
{
	$_SESSION['badSignup'] = TRUE;
	header('Location: studentHome.php');

}
else
{
	//determine if you can actually sign up for that appt, major check can be added in later revision
	if($row[5]<$row[6])
	{
		//schedule appt
		$sql3 = "update `Student Data` set `ApptNum` = '$apptID' where `StudentID` = '$SID'";
		$rs3 = $COMMON->executeQuery($sql3, $_SERVER["SCRIPT_NAME"]);
		//add to the count of students and the list ofSIDs
		$addedCount = $row[5]+1;
		$addedList = $row[7].$SID.',';
		
		$sql4 = "update `Appointment` set `numStudents` = '$addedCount', `listOfStudents`= '$addedList' where `ID` = '$apptID'";
		$rs4 = $COMMON->executeQuery($sql4, $_SERVER["SCRIPT_NAME"]);
	
		header('Location: studentHome.php');

	}
	else
	{
		//too many people in the session, kick back
		$_SESSION['badSignup'] = TRUE;
		header('Location: studentHome.php');

	}
}





?>