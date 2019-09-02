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
		<h1>Appointment Registration</h1>

	<!--Button Validation Check-->
	    <div class="finishButton">
			<form action = "doSignupAppt.php" method = "post" name = "signup">
				<div class="field">
					<label for="apptNum">Appointment Number</label>
					<input id="apptNum" size="30" maxlength="255" type="text" name="apptNum" >
				</div>
	
				<div class="nextButton">
					<input type="submit" name="Go" class="button large go" value="Go">
				</div>
			</form>
	    </div>
	</div>
	</form>
  </body>
</html>