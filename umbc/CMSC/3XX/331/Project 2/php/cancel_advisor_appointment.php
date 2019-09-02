<!-- cancel_advisor_appointment.php -->
<!-- This file will Delete the appointment from the appointments table and then update the students table to make sure the student is not in an appointment that does not exist -->

<?php
include ('mysql_connect.php');

$apptID = $_POST['ID'];

// Deletes appointment from the appointment table
$sql = "DELETE FROM appointments WHERE id=$apptID";

mysql_query($sql, $conn);

// Finds the Usernames that are attending the deleted appointment
$sql = "SELECT Email FROM students WHERE Appt=$apptID";

$rs = mysql_query($sql, $conn);

// Cycle through the selected students and change them in the data base 
while ( $row = mysql_fetch_array($rs) ) {
  $username = $row['Email'];

  echo $username;
  // Updates the table so that the Usernames of the deleted appointment have there appt set to NULL
  $sql = "UPDATE students SET Appt=NULL WHERE Email='$username'";
  echo $username;
  mysql_query($sql, $conn);
  
}

// Return to the advisor view 
header('Location:view/advisor_view.php');

?>