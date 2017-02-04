<html>
<head>
    <title>Student Summary</title>
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
<body id="wrapper" style="width: 95%; top: 10px; left: 0; right: 0; bottom: 0; margin: 0 auto auto auto;">

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
$sql = "SELECT * FROM  `students` ORDER BY `lastName` ASC";
$rs = mysql_query($sql, $conn);
$student = mysql_fetch_array($rs);

// Print out the titles of the table
if ($student) {
    echo "<h3>Student List</h3>";
    echo "<table style='margin: 0 auto'>";
    echo "<tr>";
    echo "<th>Last Name</th>";
    echo "<th>First Name</th>";
    echo "<th>Email</th>";
    echo "<th>Student ID</th>";
    echo "<th>Has Appointment</th>";
    echo "</tr>";

    // Print out the information about each student signed up
    while ($student) {
        echo "<tr>";
        echo "<td>" . $student['lastName'] . "</td>";
        echo "<td>" . $student['firstName'] . "</td>";
        echo "<td>" . $student['Email'] . "</td>";
        echo "<td>" . $student['studentID'] . "</td>";
        if (is_null($student['Appt'])) {
            echo "<td>No</td>";
        } else {
            echo "<td>Yes</td>";
        }
        echo "</tr>";
        $student = mysql_fetch_array($rs);
    }
    echo "</table>";
}

?>
<p><a href="view/advisor_view.php"> Go Back to Advisor View </a></p>


</body>
</html>
