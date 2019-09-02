<?php
include_once "mysql_connect.php";
$studentID = $_POST['studentID'];
$apptID = $_POST['apptID'];
$sql = "UPDATE students SET Appt = NULL, appointmentChanged=1 WHERE id=".$studentID;
mysql_query($sql, $conn);
$sql = "UPDATE appointments SET NumStudents=NumStudents-1 WHERE id=".$apptID;
mysql_query($sql, $conn);
header("Location: view/advisor_view.php");
?>