<?php
session_start();
include('CommonMethods.php');
$debug = true;
$COMMON = new Common($debug);
?>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>Print Schedule</title>
        	<link rel='stylesheet' type='text/css' href='standard.css'/>
  </head>
  <body>

	<!---------Generates the form to print the schedule in----------->
      <div id="form">
        <div class="top">
		      <h1>Print Schedule</h1>
	         <div class="field">

	<!---------------Resets printfail so that it doesn't not print------------>
	<?php

	
	$_SESSION['PRINTFAIL'] = FALSE;

	//sets current date and time as the East coast and sets format for date
	date_default_timezone_set('America/New_York');
  	$currentDate = date('Y-m-d');
	$id = ($_SESSION['ADVIDNumber']);


	//query for the advisor and all appointments from the appointment table for the day
	$sql = "SELECT * FROM `Appointment` WHERE `Day` LIKE '$currentDate' AND `advisorID` = '$id' ORDER BY `TimeSlot`";
        $rs = $COMMON->executeQuery($sql, $_SERVER["SCRIPT_NAME"]);
	$rowCount = mysql_num_rows($rs); 
	//if there's nothing to print, printfail flag throws up
	if($rowCount == 0) 
	{
		$_SESSION['PRINTFAIL'] = TRUE;
		header('Location: advisorHome.php');
	}

	//Prints out the appointments in a table
	echo("<h2>Appointments Today:</h2>");
	echo("<table border='1'><th colspan='4'>Appointments Today</th>\n");
	echo("<tr><td width='60px'>Time:</td><td>Majors Included:</td><td>Student ID</td><td>Location</td></tr>\n");

	//can iterate as many rows as times it can fetch
        while ($row = mysql_fetch_array($rs, MYSQL_NUM)) 
	{
		echo("<tr>");
		echo("<td>".$row[2]."</td>");
                echo("<td>".$row[4]."</td>");

		if($row[5]>1)
		{
			echo("<td>Group</td>");
		}
		else
		{
/*	    Can be later implemented to print names into the table instead of SIDs
			$sql2 = "SELECT * FROM `Student Data` WHERE `StudentID` LIKE '$row[7]'";
	        	$rs2 = $COMMON->executeQuery($sql2, $_SERVER["SCRIPT_NAME"]);
			$row2 = mysql_fetch_row($rs2);
			echo("<td>".$row2[1]."</td>");
*/
			echo("<td>".$row[7]."</td>");
		}
		echo("<td>".$row[1]."</td>");

		echo("</tr>");
	}
        echo("</table><br><br>");
	?>


	         </div>

        </form>
	</top>
	<!--------home button-------->
	<div class = "finishButton">
   	 <button onclick="location.href='advisorHome.php'">Home</button>

	</div>

  </body>
</html>
