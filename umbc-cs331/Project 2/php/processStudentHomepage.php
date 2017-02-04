<?php
include_once "mysql_connect.php";
if(!isset($_SESSION)){
    session_start();
}
$value1 = "Schedule Appointment";
$value2 = "Cancel Appointment";
$value3 = "Edit Account Information";
$value3b = "Start Season";
$value4 = "Log Out";

$value = isset($_POST['next']) ? $_POST['next'] : "";
echo $value;

if ($value == $value1) {
    header('Location: schedule_student_appointment.php');
}

if ($value == $value2) {
    header('Location: cancel_student_appointment.php');
}

if ($value == $value3) {
    header('Location: editStudentInfo.php');
}
if ($value == $value3b) {
    $endOfSeason = 0;
    $sql = "UPDATE advisors SET setEndOfSeason='" . $endOfSeason.  "' WHERE Email='" . $_SESSION['advisorEmail'] . "'";
    mysql_query($sql, $conn);
    header('Location: view/advisor_view.php');
}
if ($value == $value4) {
    header('Location: ../html/forms/first_page.html');
}
?>