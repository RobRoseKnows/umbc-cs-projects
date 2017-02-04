<?php

$title = "Schedule Group";
require("./header.php");

?>
<div id="login">
    <div id="form">
        <div class="top">
            <h1>Create Appointment Slots</h1>

            <form action="doCreateAppointment.php" method="post" name="Confirm">
                <div class="field">

                    <input id="Date" type="date" name="Date" placeholder="mm-dd-yyyy" min="2016-10-15" max="2017-6-30" required autofocus> (mm-dd-yyyy)

                </div>

                <div class="field">

                    <h2>At Times:</h2><br>

		<!--//placed back in since time as an array caused issues elsewhere-->
                    <label><input type="checkbox" name="time[]" value="08:00"> 8:00AM - 8:30AM </label><br>
		<label><input type="checkbox" name="time[]" value="08:30"> 8:30AM - 9:00AM </label><br>
		<label><input type="checkbox" name="time[]" value="09:00"> 9:00AM - 9:30AM </label><br>
		<label><input type="checkbox" name="time[]" value="09:30"> 9:30AM - 10:00AM </label><br>
		<label><input type="checkbox" name="time[]" value="10:00"> 10:00AM - 10:30AM </label><br>
		<label><input type="checkbox" name="time[]" value="10:30"> 10:30AM - 11:00AM </label><br>
		<label><input type="checkbox" name="time[]" value="11:00"> 11:00AM - 11:30AM </label><br>
		<label><input type="checkbox" name="time[]" value="11:30"> 11:30AM - 12:00PM </label><br>
		<label><input type="checkbox" name="time[]" value="12:00"> 12:00PM - 12:30PM </label><br>
		<label><input type="checkbox" name="time[]" value="12:30"> 12:30PM - 1:00PM </label><br>
		<label><input type="checkbox" name="time[]" value="13:00"> 1:00PM - 1:30PM </label><br>
		<label><input type="checkbox" name="time[]" value="13:30"> 1:30PM - 2:00PM </label><br>
		<label><input type="checkbox" name="time[]" value="14:00"> 2:00PM - 2:30PM </label><br>
		<label><input type="checkbox" name="time[]" value="14:30"> 2:30PM - 3:00PM </label><br>
		<label><input type="checkbox" name="time[]" value="15:00"> 3:00PM - 3:30PM </label><br>
		<label><input type="checkbox" name="time[]" value="15:30"> 3:30PM - 4:00PM </label><br>                </div>

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

                <div class="field">
			<label><input type="checkbox" name="Group" value="Group"> Group?</label><br>
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
