<?php
include_once "mysql_connect.php";
if(!isset($_SESSION)){
    session_start();
}
$value1 = "Schedule Appointment";
$value2 = "Print Schedule";
$value3a = "End Season";
$value3b = "Start Season";
$value4 = "Students Summary";
$value5 = "Log Out";
$value6 = "Session Preparation";
$value7 = "Search Appointments";

$value = isset($_POST['next']) ? $_POST['next'] : "";
echo $value;

if ($value == $value1) {
    header('Location: ../html/forms/add_appointment.php');
}

if ($value == $value2) {
    header('Location: print_appts.php');
}

if ($value == $value3a) {
    $endOfSeason = 1;
    $sql = "UPDATE advisors SET setEndOfSeason='" . $endOfSeason.  "' WHERE Email='" . $_SESSION['advisorEmail'] . "'";
    mysql_query($sql, $conn);
    header('Location: view/advisor_view.php');
}
if ($value == $value3b) {
    $endOfSeason = 0;
    $sql = "UPDATE advisors SET setEndOfSeason='" . $endOfSeason.  "' WHERE Email='" . $_SESSION['advisorEmail'] . "'";
    mysql_query($sql, $conn);
    header('Location: view/advisor_view.php');
}
if ($value == $value4) {
    header('Location: student_summary.php');
}
if ($value == $value5) {
    header('Location: ../html/forms/first_page.html');
}
if ($value == $value6) {
    header('Location: session_prep.php');
}
if ($value == $value7) {
    header('Location: search_appts.php');
}
?>