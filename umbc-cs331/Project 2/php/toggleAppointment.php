<?php
include_once "mysql_connect.php";
$apptID = $_POST['ID'];
$isAvailable = $_POST['available'];
$isAvailable = -($isAvailable - 1);
$sql = "UPDATE appointments SET isAvailable='".$isAvailable."' WHERE id='".$apptID."'";
mysql_query($sql, $conn);
header("Location: view/advisor_view.php");
?>