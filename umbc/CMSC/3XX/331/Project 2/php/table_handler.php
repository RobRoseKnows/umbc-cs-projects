<!-- table_handler.php -->
<!-- This file contains the information the will update the tables after a students signs up for an appointment -->

<?php
include('mysql_connect.php');
$apptID = $_POST['ID'];
session_start();

//query for isFull calc
$sql = "SELECT isGroup, NumStudents FROM appointments WHERE id=$apptID";
$rs = mysql_query($sql, $conn);
$appt = mysql_fetch_array($rs);

// This checks if the appointment is a group appointment 
if ($appt['isGroup'] == 1) {
  
  // This is if is Group is true
  if ($appt['NumStudents'] == 9) {

    // This is if the amount of students is one before full, so now that one more student is added 
    // isFull will be changed to true
    $sql = "UPDATE appointments SET isFull=1, NumStudents=(NumStudents+1) WHERE id=$apptID";
    mysql_query($sql, $conn);
  } else {

    // group but not full yet
    $sql = "UPDATE appointments SET NumStudents=(NumStudents+1) WHERE id=$apptID";
    mysql_query($sql, $conn);

  }
} else {
  
  // Not a group
  echo "Updating appointments table not Group<br/>";
  $sql = "UPDATE appointments SET NumStudents=1, isFull=1 WHERE id=$apptID";
  mysql_query($sql, $conn);

}

echo "updating students table <br/>";
  //update student
  $sql = "UPDATE students SET Appt = $apptID WHERE Email='" . $_SESSION['studentEmail'] . "'";
echo $sql;

  mysql_query($sql, $conn);
  
  header('Location:view/student_view.php');

?>