<?php

$title="Appointment Search Results";
$debug=true;
require("./header.php");


$date = $_POST['datePicker'];
$majors = $_POST['major'];
if(isset($_POST['time']))
	$time = $_POST['time'];
else
	$time = '';

?>
<div class = "field">
<?php
if($date == '' || $time =='')
{
	?> <h1> Invalid Date or Time, please enter a date or time...</h1><?php
}

else
{

	if(isset($_POST['onlyOpen']))
	{

		if(isset($_POST['individual']) && ($_POST['individual']) == "ind")
		{
			$sql = "SELECT * FROM `Appointment` WHERE `Major` LIKE '%$majors%' AND `Day` = '$date' AND `TimeSlot` = '$time' AND `maxStudents` = '1' AND `numStudents` = '0'";
			$rs = $COMMON->executeQuery($sql, $_SERVER["SCRIPT_NAME"]);
		}
		else
		{
			$sql = "SELECT * FROM `Appointment` WHERE `Major` LIKE '%$majors%' AND `Day` = '$date' AND `TimeSlot` = '$time' AND `numStudents` < `maxStudents`";
			$rs = $COMMON->executeQuery($sql, $_SERVER["SCRIPT_NAME"]);

		}
	}
	else
	{
		if(isset($_POST['individual']) && ($_POST['individual']) == "ind")
		{
			$sql = "SELECT * FROM `Appointment` WHERE `Major` LIKE '%$majors%' AND `Day` = '$date' AND `TimeSlot` = '$time' AND `maxStudents` = '1'";
			$rs = $COMMON->executeQuery($sql, $_SERVER["SCRIPT_NAME"]);

		}
		else
		{
			$sql = "SELECT * FROM `Appointment` WHERE `Major` LIKE '%$majors%' AND `Day` = '$date' AND `TimeSlot` = '$time'";
			$rs = $COMMON->executeQuery($sql, $_SERVER["SCRIPT_NAME"]);

		}
		
	}
	

	$rowCount = mysql_num_rows($rs);
	if($rowCount < 0)
	{

	}

	else
	{
	
		echo("<h2>Appointments Returned:</h2>");
		echo("<table border='3'><th colspan='5'>Appointments Returned</th>\n");
		echo("<tr><td>Appt. Number</td><td width='60px'>Day:</td><td>Time:</td><td>Location</td><td>Student Count</td></tr>\n");

	        while ($row = mysql_fetch_array($rs, MYSQL_NUM)) 
		{
			echo("<tr>");
			echo("<td>".$row[0]."</td>");
			echo("<td>".$row[3]."</td>");
	                echo("<td>".$row[2]."</td>");
	                echo("<td>".$row[1]."</td>");
	                echo("<td>".$row[5]."</td>");
	
			echo("</tr>");
		}
	        echo("</table><br><br>");
	}
	

}
?>
</div>


<?php
/****************This will later be home buttons from the bottom of the results page depending on who you are**********
	if(isset($_SESSION['ADVIDNumber']))
	{?>
			    <div class="finishButton">
			<button onclick="location.href = 'advisorHome.php'" class="button large go" >Return to Home</button>
	    </div>
	<?php}
	if(isset($_SESSION['SIDNumber']))
	{?>
			    <div class="finishButton">
			<button onclick="location.href = 'studentHome.php'" class="button large go" >Return to Home</button>
	    </div>
		
	<?php
	}

*/
?>

<?php
require("./footer.php");

?>



