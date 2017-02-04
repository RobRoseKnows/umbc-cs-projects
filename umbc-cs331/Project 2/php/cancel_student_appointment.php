<!-- cancel_student_appointment.php -->
<!-- This file will be used when a student wants to cancel an appointment, this will update the appointments and students table. However nothing will be -->
<!-- deleted -->

<?php 
require_once('mysql_connect.php');
session_start();

$appt = $_SESSION['appt'];

//Delete appointment in appointment table
$sql = "UPDATE appointments SET isFull=0, NumStudents=(NumStudents-1) WHERE id = $appt";
mysql_query($sql, $conn);

//Update the students appointment number to NULL
$sql = "UPDATE students SET Appt = NULL WHERE Email = '" . $_SESSION['studentEmail'] . "'";
mysql_query($sql, $conn);


//Redirect to student view
header('Location:view/student_view.php');
?>