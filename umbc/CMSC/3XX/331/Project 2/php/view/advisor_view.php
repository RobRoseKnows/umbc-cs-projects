<?php
require_once('../mysql_connect.php');
session_start();
$_SESSION['search'] = "";
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
    <div id="wrapper">
        <h1>CMNS Advising</h1>

        <table border="0" style='margin: 0 auto'>

            <form action="../processAdvisorHomepage.php" method="post" name="Home">
                <tr>
                    <td><input type="submit" name="next" class="button main selection" value="Schedule Appointment">
                    </td>

                    <?php
                    echo '<td><input type="submit" name="next" class="button main selection" value="';
                    $sql = "SELECT * FROM advisors WHERE Email='" . $_SESSION["advisorEmail"] . "'";
                    $endOfSeason = mysql_fetch_array(mysql_query($sql, $conn))["setEndOfSeason"];
                    if ($endOfSeason == 0) {
                        echo "End Season";
                    } else {
                        echo "Start Season";
                    }
                    echo '"></td>';
                    ?>

                </tr>

                <tr>
                    <td><input type="submit" name="next" class="button main selection" value="Print Schedule"></td>
                    <td><input type="submit" name="next" class="button main selection" value="Students Summary"></td>
                </tr>
                <tr>
                    <td><input type="submit" name="next" class="button main selection" value="Session Preparation"></td>
                    <td><input type="submit" name="next" class="button main selection" value="Search Appointments"></td>
                </tr>
                <tr>
                    <td colspan="2"><input style="width:100%" type="submit" name="next" class="button main selection"
                                           value="Log Out"></td>
                </tr>
            </form>


        </table>

        <?php
        //advisor_view.php
        //This file shows the advisor what appointments they have scheduled


        // If there is no advisor logged in, go back to the login page
        if (!isset($_SESSION['advisorEmail'])) {
            header("Location: ../../html/forms/first_page.html");
        }

        // set the timezone to the east coast
        date_default_timezone_set('America/New_York');

        // Make sure all appointments have the correct isFull value set
        $sql = "UPDATE appointments SET isFull=1 WHERE NumStudents=MaxAttendees";
        mysql_query($sql, $conn);

        //Fetching appointments
        $sql = "SELECT * FROM appointments WHERE AdvisorEmail='" . $_SESSION['advisorEmail'] . "' ORDER BY DATE ASC, TIME ASC";
        $rs = mysql_query($sql, $conn);

        // Tell the user who they are logged in as
        echo "Logged in as: " . $_SESSION['advisorEmail'];


        // If there was no appointment, $rs will be false
        if ($rs) {
            // Get the appointments
            $appt = mysql_fetch_array($rs);

            // Prints out the titles of the table
            echo "<h3>Scheduled Appointments </h3>";
            echo "<table style='margin: 0 auto'>";
            echo "<tr>";
            echo "<th>Date</th>";
            echo "<th>Time</th>";
            echo "<th>Location</th>";
            echo "<th>Group</th>";
            echo "<th>#Students</th>";
            echo "<th>Options</th>";
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
            // Now this cycles through the section of the query
            while ($appt) {
                echo "<tr>";
                echo "<td style='white-space: nowrap'>" . date("l, F jS Y", strtotime($appt['Date'])) . "</td>";
                echo "<td style='white-space: nowrap'>" . $appt['Time'] . $time_end[$appt['Time']] . "</td>";
                echo "<td>" . $appt['Location'] . "</td>";

                // check if the appointment is a group appointment or not
                if ($appt['isGroup'] == 0)
                    echo "<td>" . "No" . "</td>";
                else
                    // not a group appointment
                    echo "<td>" . "Yes" . "</td>";

                echo "<td>" . $appt['NumStudents'] . "/" . $appt['MaxAttendees'] . "</td>";

                $apptID = $appt['id'];

                echo "<td>";
                // Print out the check students button if there are students signed up for the appointment
                if ($appt['NumStudents'] > 0) {

                    echo "<form method=post action='view_students.php'>";
                    echo "<input type=hidden name='ID' value='" . $apptID . "' />";
                    echo "<input type=submit value='View Registered Students'/>";
                    echo "</form>";


                    // If there are not any students signed up then tell the user that
                } else {
                    echo "No Students Registered";
                }
                echo "<form method=post action='../toggleAppointment.php'>";
                echo "<input type=hidden name='ID' value='" . $apptID . "' />";
                echo "<input type=hidden name='available' value='" . $appt['isAvailable'] . "' />";
                echo "<input type=submit value='";
                // If the appointment is available to be registered
                if ($appt['isAvailable'] == 1) {
                    echo "Disable Registration";
                } else {
                    echo "Enable Registration";
                }
                echo "'/>";
                echo "</form>";
                echo "</td>";


                ?>
                <td>
                    <form method=post action="../../html/forms/add_appointment.php">
                        <?php echo "<input type=hidden name='ID' value='$apptID' />"; ?>
                        <input type=submit name=editAppointment value="Edit"/>
                    </form>
                    <form method=post action="../cancel_advisor_appointment.php">
                        <?php echo "<input type=hidden name='ID' value='$apptID' />"; ?>
                        <input type=submit value="Cancel"/>
                    </form>
                </td>
                <?php
                echo "</tr>";
                $appt = mysql_fetch_array($rs);
            }
            echo "</table>";
        } else {
            echo "<h3>You have not scheduled any appointments</h3>";
        }
        ?>
        <p> Register an Advisor: Click <a href="../../html/forms/register_advisor.html">here</a> to register.</p>

        <h3 style='color: #FF0000;'>Copyright umbc.edu</h3>

    </div>
</left>
</body>
</html>
