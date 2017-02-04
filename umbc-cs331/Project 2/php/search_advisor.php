<!-- search_advisor.php -->
<!-- This file get the advisors by name and posts to them schedule_by_advisor.php
     this will eventually put them in a dropdown box -->

<!--<?php
include ('../html/header.html'); ?>-->

<html>
<head>
    <title>View Appointments</title>
    <link rel='stylesheet' type='text/css' href='../html/standard.css'/>
    <link rel='icon' type='image/png' href='../html/corner.png'/>
</head>
<div style="overflow:hidden">
    <img src="../html/background.jpg" style="overflow:hidden;"/>
</div>
<body id="background">
    <left><div id="wrapper" style="width:65%">
            <h1>CMNS Advising</h1>

            <?php
            // connect to the database
            include ('mysql_connect.php');
            // make a query that will select all rows from the advisors table
            $sql = "SELECT * FROM advisors";
            $rs = mysql_query($sql, $conn);
            ?>
            <h2>Choose An Advisor</h2>
            <form method=post action='schedule_by_advisor.php'>
                <select name="advisor">
                    <?php
                    // Prints out all the names of the advisors
                    while ($advisor = mysql_fetch_array($rs)) {
                        echo "<option value='" . $advisor['Email'] . "'>" . $advisor['fullName'] . " - " . $advisor['Username'] . "</option>";
                    }
                    ?>
                </select>
                <input type=submit value="Submit"/>
            </form>

            <h3 style='color: #FF0000;'>Copyright umbc.edu</h3>

        </div>
    </left>
</div>
</body>
</html>

<?php include('../html/footer.html'); ?>