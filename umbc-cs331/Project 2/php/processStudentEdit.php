<?php
if (!isset($_SESSION)) {
    session_start();
}


//makes changes
$preferred = $_POST["prefName"];
$email = $_SESSION["studentEmail"];

//Actually update student data
include_once "mysql_connect.php";
$sql = "update `students` set `prefName` = '$preferred', `Major` = '$major' where `Email` = '$email'";
$rs = mysql_query($sql, $conn);

header('Location: view/student_view.php');
?>