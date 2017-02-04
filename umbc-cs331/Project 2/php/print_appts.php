<html>
<head>
    <title>Print View</title>
    <link rel='stylesheet' type='text/css' href='../html/standard.css'/>
    <link rel="icon" type="image/png" href="../html/corner.png" />
    <style>
        table, th, td {
            border: 1px solid black;
        }

        td {
            text-align: left;
            vertical-align: middle;
        }

        form {
            position: relative;
            top: 8px;
        }
    </style>
</head>
<body>

<?php
//advisor_view.php
//This file shows the advisor what appointments they have scheduled

require_once('mysql_connect.php');
session_start();

// set the timezone to the east coast
date_default_timezone_set('America/New_York');

//Fetching appointments
$sql = "SELECT * FROM appointments WHERE AdvisorEmail='" . $_SESSION['advisorEmail'] . "' ORDER BY DATE ASC, TIME ASC";
$rs = mysql_query($sql, $conn);

$appt = mysql_fetch_array($rs);

// Select all the students that have appointments
$sql = "SELECT * FROM  `students` WHERE `Appt` IS NOT NULL ORDER BY `lastName` ASC";
$rs = mysql_query($sql, $conn);
$student = mysql_fetch_array($rs);

// Print out the titles of the table
if ($student) {
    echo "<h3>Advisor Appointment Schedule</h3>";
    echo "<table style='margin: 0 auto'>";
    echo "<tr>";
    echo "<th>Date of Session</th>";
    echo "<th>Time of Session</th>";
    echo "<th>Campus ID</th>";
    echo "<th>Last Name</th>";
    echo "<th>First Name</th>";
    echo "<th>Major</th>";
    echo "</tr>";

    $time_end = array(
        "08:00" => " am",
        "08:30" => " am",
        "09:00" => " am",
        "09:30" => " am",
        "10:00" => " am",
        "10:30" => " am",
        "11:00" => " am",
        "11:30" => " am",
        "12:00" => " pm",
        "12:30" => " pm",
        "01:00" => " pm",
        "01:30" => " pm",
        "02:00" => " pm",
        "02:30" => " pm",
        "03:00" => " pm",
        "03:30" => " pm",
        "04:00" => " pm",
        "04:30" => " pm",
        "05:00" => " pm"
    );
    // Print out the information about each student signed up
    while ($student) {
        $sql = "SELECT * FROM appointments WHERE id=" . $student['Appt'];
        $appt = mysql_fetch_array(mysql_query($sql, $conn));
        if ($appt) {
            echo "<tr>";
            echo "<td>" . date("l, F jS", strtotime($appt['Date'])) . "</td>";

            echo "<td>" . $appt['Time'] . $time_end[$appt['Time']] . "</td>";
            echo "<td>" . $student['studentID'] . "</td>";

            echo "<td>" . $student['lastName'] . "</td>";
            echo "<td>" . $student['firstName'] . "</td>";
            echo "<td>" . $student['Major'] . "</td>";
            echo "</tr>";
        }
        $student = mysql_fetch_array($rs);
    }
    echo "</table>";
}

?>
<p><a href="view/advisor_view.php"> Go Back to Advisor View </a></p>


</body>
</html>
