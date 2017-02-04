<!-- validate_appointment.php -->
<!-- This file will make sure that an advisor does not input an invalid appointment -->
<html>
<head>
<?php

require_once('../mysql_connect.php');
session_start();

$email = $_SESSION['advisorEmail'];
// Creates the query to get the information from the appointments database where the username is equal to the current session username
$sql = "SELECT * FROM appointments WHERE `AdvisorEmail` = '$email'";
$rs = mysql_query($sql, $conn);
$errors = False;
$error_message = "";

// Set the time zone to the east coast 
date_default_timezone_set('America/New_York');

// Post all the information input by the advisor
$date = $_POST['date'];
$time = $_POST['time'];
$location = $_POST['location'];
$leader = $_POST['leader'];
$maxAttendees = $_POST['maxAttend'];
$group = ($maxAttendees > 1) ? 1 : 0;

// Create a date for today 
$today = date_create();
$todayStr = date_format($today, 'Y-m-d');
$currTime = date_format($today, 'G:i');

//Time not already scheduled check
while($row = mysql_fetch_assoc($rs))
{
    echo(var_dump($row));
  if (($time == $row['Time'] && $date == $row['Date']) && !(isset($_POST['ID']) && $row['id'] == $_POST['ID']))
  {
    //Match found - BAD - there is an error
    $errors = True;
    $error_message = "This appointment is already scheduled<br>";
  }
}

//Date left blank check
if ($date == "") 
{
  $errors = True;
  $error_message .= "Date field can't be blank.<br>";
}

//Date already past 
if($date <= $todayStr && $time <= $currTime && $error_message == "")
{
  $errors = True;
  $error_message .= "You may not schedule appointments in the past.<br>";
}

//Location left blank check
if ($location == "") 
{
  $errors = True;
  $error_message .= "Location field can't be blank.<br>";
}

// If there are errors 
if(!$errors)
{
    if(isset($_POST['ID'])){
        $escaped_id = ($_POST['ID']);

        // Notify students with this appointment
        $sql = "UPDATE students SET appointmentChanged=1 WHERE Appt='$escaped_id'";
        mysql_query($sql, $conn);

        // If the appointment's max attendees changed, make sure there are not
        // too many students by removing some if needed
        $appt = mysql_fetch_array(mysql_query("SELECT * from appointments where id=".$escaped_id, $conn));
        $students = mysql_query("SELECT * FROM students WHERE Appt=".$appt["id"]);
        while($appt['NumStudents'] > $appt['MaxAttendees']){
            $student = mysql_fetch_array($students);
            mysql_query("UPDATE students SET Appt = NULL, appointmentChanged=1 WHERE id=".$student['id'], $conn);
            mysql_query("UPDATE appointments SET NumStudents=NumStudents-1 WHERE id=".$appt['id'], $conn);
            $appt = mysql_fetch_array(mysql_query("SELECT * from appointments where id=".$escaped_id, $conn));
        }

        // Modify an existing appointment
        $sql = "UPDATE appointments
                SET `Date`='%s', 
                    `Time`='%s', 
                    Location='%s', 
                    isGroup='%s', 
                    SessionLeader='%s', 
                    AdvisorEmail='%s', 
                    MaxAttendees='%s' 
                    WHERE id='$escaped_id'";
    }
    else {
        // Insert a new appointment into the appointments table
        $sql = "INSERT INTO appointments 
                (`Date`, `Time`, Location, isGroup, SessionLeader, AdvisorEmail, MaxAttendees) 
                VALUES ('%s', '%s', '%s', '%s', '%s', '%s', '%s')";
    }
  $formatted = sprintf($sql, $date, $time, $location, $group, $leader, $email, $maxAttendees);

  $rs = mysql_query($formatted, $conn);

  // Go back to the advisor_view.php 
  header('Location:../view/advisor_view.php');
}
else
{
    $_SESSION['appointmentError'] = $error_message;
  // Go to the error page for add appoinment 
  require('../../html/forms/add_appointment.php');
}
?>
</head>
</html>
