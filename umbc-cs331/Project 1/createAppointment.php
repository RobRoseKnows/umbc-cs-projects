<?php

$title = "Schedule Group";
require("./header.php");

?>
<div id="login">
    <div id="form">
        <div class="top">
            <h1>Create Appointment Slots</h1>

            <form action="logic/doCreateAppointment.php" method="post" name="Confirm">
                <div class="field">

                    <input id="Date" type="date" name="Date" placeholder="mm-dd-yyyy" min="2016-10-15" max="2017-6-30" required autofocus> (mm-dd-yyyy)

                </div>

                <div class="field">

                    <h2>At Times:</h2><br>

                    <?php include("includes/static/timeCheckboxes.php"); // This is so we can keep all of the drop down values coordinated.?>

                </div>

                <!-- What majors to accept -->
                <div class="field">

                    <h2>For Majors:</h2><br>

                    <?php include("includes/static/majorsCheckboxes.php"); // This keeps all the dropdown values coordinated ?>

                </div>

                <div class="field">
                    <label>Student limit:
                        <input type="number" id="studentLimit" name="studentLimit" min="1" max="10" value="10" />
                    </label>
                </div>
                
                <div class="field">
                    <label>Location:
                        <input type="text" id="location" name="location"/>
                    </label>
                </div>

                <div class="nextButton">
                    <input type="submit" name="next" class="button large go" value="Create">
                </div>
            </form>
        </div>
    </div>

    <form method="link" action="advisorHome.php" name="home">
        <input type="submit" name="next" class="button large" value="Return to Home">
    </form>
</div>
<?php
require("./footer.php");
?>
