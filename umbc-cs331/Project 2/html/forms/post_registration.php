<?php
if (!isset($_SESSION)) {
    session_start();
}
include_once("../../php/mysql_connect.php");
if (isset($_POST['submit_post_register'])) {
    $email = $_SESSION['studentEmail'];
    $plans = ($_POST['plans']);
    $questions = ($_POST['questions']);
    $sql = "UPDATE students SET Plans='" . $plans . "', Questions='" . $questions . "' WHERE Email='" . $email . "'";
    $rs = mysql_query($sql, $conn);
    header("Location: ../../php/view/student_view.php");
}
?>

    <html lang="en">
    <head>
        <meta charset="UTF-8"/>
        <title>Advising Homepage</title>
        <link rel='stylesheet' type='text/css' href='../standard.css'/>
        <link rel="icon" type="image/png" href="../corner.png"/>
    </head>
    <div style="overflow:hidden">
        <img src="../../html/background.jpg" style="overflow:hidden;"/>
    </div>
    <body id="background">
        <!--<p style='clear:both;'><img src='umbc50logo.jpg' height='13%' width='25%'/></p>-->

        <left>
            <div id="wrapper" style = "width: 65%">

                <h1>Student Registration</h1>
                <?php
                // Check if there are advisors that have not set the end of the season flag
                $sql = "SELECT * FROM advisors WHERE setEndOfSeason=0";
                $numInSeason = mysql_num_rows(mysql_query($sql, $conn));
                // If all advisors have said that the season has ended, just show an away message
                if ($numInSeason == 0) {
                    // Remove the student
                    $sql = "DELETE FROM  `students` WHERE `Email`='" . $_SESSION['studentEmail'] . "'";
                    $rs = mysql_query($sql, $conn);
                    ?>

                    Advisors are not accepting appointments at this time.<br>
                    <input id="backtoRegister" type="button" value="Back"
                           onclick="window.location='../../html/forms/register_student.php';"/>

                    <?php
                } else {
                    $sql = "SELECT * FROM students WHERE Email='" . $_SESSION['studentEmail'] . "'";
                    $major = mysql_fetch_array(mysql_query($sql, $conn))['Major'];
                    if ($major == "Other") {
                        // Remove the student because they are not in a valid major
                        $sql = "DELETE FROM  `students` WHERE `Email`='" . $_SESSION['studentEmail'] . "'";
                        $rs = mysql_query($sql, $conn);
                        ?>

                        You have indicated that you plan to pursue a<br>
                        major other than one of the following, beginning<br>
                        next semester:<br>
                        <ul>
                            <li>Biological Sciences B.A.</li>
                            <li>Biological Sciences B.S.</li>
                            <li>Biochemistry & Molecular Biology B.S.</li>
                            <li>Bioinformatics & Computational Biology B.S.</li>
                            <li>Biology Education B.A.</li>
                        </ul>

                        In order to obtain the BEST advice about course
                        selection, degree progress, and academic policy,
                        please meet with a representative of the
                        department that administers your NEW major.<br><br>
                        You can find advising contact information for your
                        new major on the Office for Academic and
                        Pre-Professional Advising Office’s
                        <a href="http://advising.umbc.edu/departmental-advising/">Departmental Advising
                            page</a>. That contact person/office will be
                                    able to give you instructions on how to schedule
                                    an advising appointment with someone in that
                                    area.<br><br>

                        Good luck with your new major!<br><br>

                        If you selected “Other” in error, click the button to
                        return to the previous screen<br><br>

                        <input id="backtoRegister" type="button" value="Back"
                               onclick="window.location='../../html/forms/register_student.php';"/>

                        <?php
                    } else {
                        ?>
                        <form method="post" action="post_registration.php">

                            What are your current post-UMBC plans? For example: Medical School, Teach
                            middle school science, Research career, Master’s/PhD, etc.<br>
                            <textarea maxlength="1000" rows="6" style="width: 65%" name="plans"
                                      required></textarea><br>
                            Do you have any questions or concerns that you would like to discuss during
                            your advising session? For example: Withdrawing from a course, adding a
                            second major, etc.<br>
                            <textarea maxlength="1000" rows="6" style="width: 65%" name="questions"></textarea>
                            <br><br>
                            Note: Certain questions and concerns may require more time for discussion than a student’s
                            Registration Advising appointment will allow. If your question or
                            concern is complex, or is sensitive in nature, you may be asked to schedule a
                            follow-up appointment with an advisor to address it fully.
                            <br><br>
                            <input type="submit" value="Submit" name="submit_post_register"/>
                        </form>
                    <?php }
                } ?>

            </div>
    </left>
    </body>
    </html>
<?php include('../../html/footer.html'); ?>