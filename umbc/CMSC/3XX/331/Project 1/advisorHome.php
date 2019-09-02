<?php
	$title = "Advisor Home";
	include('./header.php');
?>

	<div class="container main">
	<div id="nav">
        <nav class="action-options">
            <a href="createAppointment.php">Schedule an appointment</a>
            <a href="viewSchedule.php">View Schedule</a>
            <a href="findAppointment.php">Delete/Search for an appointment</a>
            <a href="advisorRegister.php">Create new Advisor Account</a>
        </nav>
	</div>
	<div id="section">
		<h1><?php echo "Welcome, {$_SESSION['ADVIDNumber']}!";  ?> </h1>

	</div>
	</div>

<?php
	include("./footer.php");
?>





