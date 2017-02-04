<?php

$title="Appointment Search Results";
$debug=false;
include_once("./header.php");
include_once("./includes/ResultsQuery.php");
include_once "./includes/CommonMethods.php";


if(isset($_GET['datePicker'])) {
    $SEARCH = new SearchingClass($debug);
    $dict = $_GET;
    $result = $SEARCH->searchFor($dict);

    // I realize this is a less desirable form, but it's the easiest to work with all the conditionals.
    echo("<h1>Search Results</h1>");
    echo("<h2>".$SEARCH->echoTerms($dict)."</h2>");

    if(mysql_num_rows($result) > 0) {
        ?>
        <h3>Results:</h3>
        <form action="logic/doAppointmentSignUp.php" method="post" name="appointmentSignUp">

            <?php

            $resultArr = mysql_fetch_array($result);
            foreach ($resultArr as $row) {
                echo($SEARCH->lineForRow($row));
            }

            $COMMON = new CommonMethods($debug);

            if($COMMON->isStudent($_SESSION["sid"])) {
                // THis allows a student to setup an appointment to see an advisor.
                echo("<input type='submit' name='next' value='Sign Up'>");
            } else if($COMMON->isAdvisor($_SESSION["sid"])){
                // This allows an advisor to delete an appointment from their schedule.
                echo("<input type='submit' name='next' value='Delete Appointment'>");
            }
            ?>

            <br>
            <a href="findAppointment.php">Search Again</a>

        </form>

        <?php

    } else {
        ?>
            <h3>No results found.</h3>
        <?php
    }
} else {
    echo("<h1>Search requires a date at minimum.</h1>");
}

require("./footer.php");

?>
