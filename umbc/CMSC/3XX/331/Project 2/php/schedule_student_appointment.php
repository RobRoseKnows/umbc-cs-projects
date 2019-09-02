<!-- schedule_student_appointment.php --> 
<!-- This code shows a form to look up advisors by the date --> 

<?php include ('../html/header.html'); ?>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>Advising Homepage</title>
    <link rel='stylesheet' type='text/css' href='../html/standard.css'/>
    <link rel="icon" type="image/png" href="../corner.png" />
  </head>
  <div style="overflow:hidden">
      <img src="../html/background.jpg" style="overflow:hidden;"/>
  </div>
  <body id="background">
<left><div id="wrapper">
<h1>Schedule an appointment </h1>
   <div id="form1">
    <form method=post action="get_appointments.php">
	<h4 style="font-family: monospace; font-size: 15px; padding: 1%; color: #FF0000; text-align: left;">Choose Week: <select name="week"/>
	<option value = 0 selected>this week</option>
	<option value = 1> next week</option>

	<!-- THIS CODE GETS THE NEXT TWO WEEK OPTIONS -->
	<?php  
        // Set time zone to the east coast
	date_default_timezone_set('America/New_York');
	$date = date_create(); // Today
	$daysToSunday = (7 - date_format($date, 'w')) % 7;
	$nextSunday = date_modify($date, "+$daysToSunday day");
	$newSunday = date_modify($nextSunday, '+7 day');
	echo "<option value = 2>week of ";
	$string = date_format($newSunday, 'l, M. j');
        echo $string;
	echo " </option> ";
	$newSunday2 = date_modify($newSunday, '+7 day');
	echo "<option value = 3>week of ";
        $string2 = date_format($newSunday2, 'l, M. j');
        echo $string2;
	echo " </option> ";
	?>
	<!-- END PHP -->
	</select>
	</h4>
	
    <h4 style="font-family: monospace; font-size: 15px; padding: 1%; color: #FF0000; text-align: left;">Group? <select name="group">
	  <option value=1>Yes</option>
	  <option value=0>No</option>
	  <option value=2 selected>Don't care</option>
		</select>
	</h4>
    <p><input type=submit value="Submit"/></p>
    </form>
</div>
    <!-- HyperLink to search appointments by advisor --> 
    <p><a href = "search_advisor.php"> Or Look Up By Advisor </a></p>

</div>
</left>
</body>
</html>	
<?php include ('../html/footer.html'); ?>