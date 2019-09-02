<!-- view_students.php -->
<!-- This file prints out the students that are signed up for a specific appointment -->

<html>
<head>
    <title>View Students</title>
    <link rel='stylesheet' type='text/css' href='../../html/standard.css'/>
    <link rel='icon' type='image/png' href='../../html/corner.png'/>
    <style>
        table, th, td {
            border: 1px solid black;
        }

        td {
            text-align: center;
            vertical-align: middle;
        }

        form {
            position: relative;
            top: 8px;
        }
    </style>
</head>
<body
    style="background-color: #F3F2F2; width:100% height:auto; top: 0; left:0; padding: 10px; margin: 0px; border: 0px;">
<div id="wrapper" style="width:100%; top: 0; left:0; margin: 0px; border: 0px;">

    <?php
    require_once('mysql_connect.php');
    session_start();

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

    $advisors = mysql_query("SELECT * FROM advisors");
    $advisor = mysql_fetch_array($advisors);
    // For each advisor, print out the correct values
    while ($advisor) {
        echo "<table style='width:100%'>";
        echo "<tr>";
        echo "<td colspan='8'>" . $advisor["fullName"] . "</td>";
        echo "</tr>";
        echo "<tr>";
        echo "<th>Date of Session</th>";
        echo "<th>Time of Session</th>";
        echo "<th>Campus ID</th>";
        echo "<th>Last Name</th>";
        echo "<th>First Name</th>";
        echo "<th>Major</th>";
        echo "<th>Career Goal(s)</th>";
        echo "<th>Questions and Concerns</th>";
        echo "</tr>";
        // Get this advisor's appointments
        $appointments = mysql_query("SELECT * FROM appointments WHERE SessionLeader LIKE '%".$advisor["fullName"]."%'", $conn);
        $appointment = mysql_fetch_array($appointments);
        while($appointment) {
            $students = mysql_query("SELECT * FROM students WHERE Appt='".$appointment["id"]."'", $conn);
            $student = mysql_fetch_array($students);
            while($student) {
                echo "<tr>";
                echo "<td>" . date("l, F jS", strtotime($appointment['Date'])) . "</td>";
                echo "<td>" . $appointment['Time'] . $time_end[$appointment['Time']] . "</td>";
                echo "<td>" . $student['studentID'] . "</td>";
                echo "<td>" . $student['lastName'] . "</td>";
                echo "<td>" . $student['firstName'] . "</td>";
                echo "<td>" . $student['Major'] . "</td>";
                echo "<td><div style='white-space: normal;'>" . str_replace("\n", "<br>", $student['Plans']) . "</div></td>";
                echo "<td><div style='white-space: normal;'>" . str_replace("\n", "<br>", $student['Questions']) . "</div></td>";
                echo "</tr>";
                $student = mysql_fetch_array($students);
            }
            $appointment = mysql_fetch_array($appointments);
        }
        echo "</table><br>";
        $advisor = mysql_fetch_array($advisors);
    }


    ?>

    <p><a style="text-align: center; width:100%; margin: auto" href="view/advisor_view.php"> Go Back to Advisor View </a></p>

</div>
</body>
</html>