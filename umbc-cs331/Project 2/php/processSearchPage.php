<!-- processes advisors choice of how to search by appointment -->
<?php
session_start();

$value1 = "Group appointment";
$value2 = "Date of appointment";
$value3 = "Session Leader";

$value = isset($_POST['next']) ? $_POST['next'] : "";

if($value == $value1) {
  $_SESSION['search'] = "group";
}

else if ($value == $value2) {
  $_SESSION['search'] = "date";
}

else if($value == $value3) {
  $_SESSION['search'] = "advisor";
}

header('Location: search_appts.php');

?>