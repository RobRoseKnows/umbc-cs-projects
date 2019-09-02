<?php
session_start();
$debug = false;
include('./CommonMethods.php');
$COMMON = new Common($debug);
?>

<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>Cancel Appointment</title>
	<link rel='stylesheet' type='text/css' href='standard.css'/>

  </head>
  <body>
    <div id="login">
      <div id="form">
        <div class="top">
		<h1>Cancel Appointment</h1>
	    <div class="field">
	    <?php

			//Displays cancelling appt information
			echo "<h2>Cancel Appointment?</h2>";
					?>		
        </div>
	<!--Button Validation Check-->
	    <div class="finishButton">
			<form action = "studentCancelButton.php" method = "post" name = "Cancel">
			<input type="submit" name="cancel" class="button large go" value="Cancel">
			<input type="submit" name="cancel" class="button large" value="Keep">
			</form>
	    </div>
		</div>
		</form>
  </body>
</html>