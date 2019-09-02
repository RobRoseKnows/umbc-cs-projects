<!-- student_view.php -->
<!-- This file shows the student what appointment they are signed up for and if they are not signed up give them the option to sign up -->
<?php
session_start();
include_once "../mysql_connect.php";
include('../check_disabled.php');
?>
<html>
<head>
    <title>View Appointments</title>
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
<div style="overflow:hidden">
    <img src="../../html/background.jpg" style="overflow:hidden;"/>
</div>
<body id="background">
<left>
    <div id="wrapper" style="width:65%;">
        <h1>CMNS Advising</h1>

        <?php
        if (isset($_SESSION["other_message"])) {
            echo("Notice: " . $_SESSION["other_message"]);
            echo("<br>");
        }
        ?>

        <table border="0" style='margin: 0 auto'>

            <form action="../processStudentHomepage.php" method="post" name="Home">
                <tr>
                    <?php
                    echo '<td><input type="submit" name="next" class="button main selection" value="';
                    $sql = "SELECT * FROM students WHERE Email='" . $_SESSION["studentEmail"] . "'";
                    $apptID = mysql_fetch_array(mysql_query($sql, $conn))["Appt"];
                    if(is_null($apptID)){
                        echo "Schedule Appointment";
                    } else {
                        echo "Cancel Appointment";
                    }
                    echo '"></td>';
                    ?>
                    <td><input type="submit" name="next" class="button main selection" value="Edit Account Info"></td>
                </tr>

                <tr>
                    <td colspan="2"><input style="width:100%" type="submit" name="next" class="button main selection" value="Log Out"></td>
                </tr>
            </form>


        </table>
        <?php


        // Set timezone to the east coast
        date_default_timezone_set('America/New_York');

        // Make sure all appointments have the correct isFull value set
        $sql = "UPDATE appointments SET isFull=1 WHERE NumStudents=MaxAttendees";
        mysql_query($sql, $conn);

        // Get all info about advisors
        $sql = "SELECT * FROM `advisors`";
        $rs = mysql_query($sql, $conn);



        if (mysql_fetch_array($rs)) {
            //Getting Appointment Number
            $sql = "SELECT `Appt` FROM `students` WHERE `Email`='" . $_SESSION["studentEmail"] . "'";
            $rs = mysql_query($sql, $conn);
            $row = mysql_fetch_row($rs);
            $studentApptNum = $row[0];
            $_SESSION['appt'] = $row[0];

            echo "<h4 style='font-family: monospace; font-size: 15px; padding: 1%; color: #FF0000; text-align: center;'>Logged in as: " . $_SESSION["studentEmail"] . "<br></h4>";

            if (!is_null(($studentApptNum))) {
                //print a table containing info about the student's appointment
                ?>
                <table style="margin:0 auto; width: 90%">
                <tr>
                    <th>Date</th>
                    <th>Time</th>
                    <th>Location</th>
                    <th>Advisor</th>
                </tr>
                <?php

                //Get the appointment information
                $sql2 = "SELECT `SessionLeader`, `Date`, `Time`, `Location` FROM `appointments` WHERE `id` = $studentApptNum";
                $rs2 = $rs = mysql_query($sql2, $conn);
                $myRow = mysql_fetch_row($rs2);

                echo "<tr>";
                echo "<td class='not_register'>" . date("l, F jS", strtotime($myRow[1])) . "</td>";
                echo "<td class='not_register'>" . $myRow[2] . "</td>";
                echo "<td class='not_register'>" . $myRow[3] . "</td>";
                echo "<td class='not_register'>" . $myRow[0] . "</td>";
                echo "</tr></table>";
                echo("Now that you have selected and scheduled your advising session, please fill out our Pre-Registration Sheet. Bring a completed copy of the sheet with you to your session. Thank you for scheduling your advising session.");
            } else {
                // Print a button to schedule an appointment

                echo '<tr><td>No Appointment Currently Scheduled</td></tr></table>';
            }
            ?>

        <?php } //handles the case if no advisors have made an appointment
        else {
            echo "Sorry, no advisors exist<br/>";
            echo "<pre> <a href = '../../html/forms/first_page.html'>Log Me Out</a></pre>";
        }
        ?>

        <h3 style='color: #FF0000;'>Copyright umbc.edu</h3>

    </div>
</left>
</body>
</html>

<?php include('../../html/footer.html'); ?>
