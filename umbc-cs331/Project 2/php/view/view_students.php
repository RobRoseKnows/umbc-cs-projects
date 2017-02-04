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
<body style="background-color: #F3F2F2; width:100% height:auto; top: 0; left:0; padding: 10px; margin: 0px; border: 0px;">
<div id="wrapper" style="width:100%; top: 0; left:0; margin: 0px; border: 0px;">

    <?php
    require_once('../mysql_connect.php');
    session_start();

    $escaped_id = ($_POST['ID']);

    // Select all the students that have the selected appointment
    $sql = "SELECT * FROM students WHERE Appt='$escaped_id'";
    $rs = mysql_query($sql, $conn);
    $student = mysql_fetch_array($rs);

    // Print out the titles of the table
    if ($student) {
        echo "<h3>Students Registered</h3>";
        echo "<table>";
        echo "<tr>";
        echo "<th>First Name</th>";
        echo "<th>Last Name</th>";
        echo "<th>Major</th>";
        echo "<th>Student ID</th>";
        echo "<th>Career Goal(s)</th>";
        echo "<th>Questions and Concerns</th>";
        echo "<th>Remove Student</th>";
        echo "</tr>";

        // Print out the information about each student signed up
        while ($student) {
            echo "<tr>";
            echo "<td>" . $student['studentID'] . "</td>";
            echo "<td>" . $student['lastName'] . "</td>";
            echo "<td>" . $student['firstName'] . "</td>";
            echo "<td>" . $student['Major'] . "</td>";
            echo "<td><div style='white-space: normal;'>" . str_replace("\n", "<br>", $student['Plans']) . "</div></td>";
            echo "<td><div style='white-space: normal;'>" . str_replace("\n", "<br>", $student['Questions']) . "</div></td>";
            echo(
                "<td><form method='post' action='../delete_student.php'>
                    <input type='hidden' name='studentID' value='" . $student['id'] . "'/>
                    <input type='hidden' name='apptID' value='" . $_POST['ID'] . "'/>
                    <input type='submit' name='deleteStudent' value='Delete'/>
                </form></td>"
            );
            echo "</tr>";
            $student = mysql_fetch_array($rs);
        }
        echo "</table>";
    }

    ?>

    <p><a href="advisor_view.php"> Go Back to Advisor View </a></p>

</div>
</body>
</html>