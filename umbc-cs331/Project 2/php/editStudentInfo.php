<?php
session_start();
include('mysql_connect.php');


$email = $_SESSION['studentEmail'];

$sql = "select * from `students` WHERE Email='$email'";
$rs = mysql_query($sql, $conn);

//Fetch student info for session use

if (mysql_num_rows($rs) == 1) {
    $res_obj = mysql_fetch_array($rs);
    $firstName = $res_obj["firstName"];
    $lastName = $res_obj["lastName"];
    $prefName = $res_obj["prefName"];
    $major = $res_obj["Major"];
    $studEmail = $res_obj["Email"];
    $SIDNumber = $res_obj["studentID"];
}

?>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>Edit Account Information</title>
    <link rel='stylesheet' type='text/css' href='../html/standard.css'/>
    <link rel='icon' type='image/png' href='../html/standard.css'/>
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
    <img src="../html/background.jpg" style="overflow:hidden;"/>
</div>
<body id="background">
<left>
    <div id="wrapper">
        <!--Displays previously parsed information -->
        <!--Will Pass to procesStudentEdit.php to apply any and all changes -->
        <h2>Edit Student Information<span class="login-create"></span></h2>
        <form action="processStudentEdit.php" method="post" name="Edit"
              style="font-family: monospace; font-size: 15px; padding: 1%; color: #FF0000; text-align: left;">
            <?php
            echo '<h4>Preferred Name: <input type="text" name="prefName" value="'.$prefName.'"/></h4>';
            echo '<h4>Major: <br><select name="major">';

            $majors = array(
                "Biological Sciences BA",
                "Biological Sciences BS",
                "Biological Sciences BS",
                "Biochemistry & Molecular Biology BS",
                "Bioinformatics & Computational Biology BS",
                "Biology Education BA",
                "Chemistry BA",
                "Chemistry BS",
                "Chemistry Education BA"
            );
            foreach ($majors as $currentMajor) {
                echo "<option value='" . $currentMajor . "'";
                if ($major == $currentMajor) {
                    echo " selected";
                }
                echo ">" . $currentMajor . "</option>";
            }
            ?>
            <!-- This creates a drop down box of the possible major choices -->
            </select></h4>
            <pre><h4>Select the major that you intend to pursue
NEXT SEMESTER (this may be different from your
current officially declared major).
The major selected can be either your
primary or secondary major. If you are only
planning to pursue ONE major, and your
major of choice is not listed, please choose Other</h4></pre>

            <p><input type=submit value="Submit"/></p>


        </form>
    </div>
</left>
</body>

</html>
