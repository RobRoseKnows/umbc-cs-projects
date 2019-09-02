<!--  schedule_by_advisor.php -->
<!--  This file contains both php and html code that will filter the appointments
      database by the advisor selected by the student  
-->

<html>
<head><title>Advising</title>
<link rel='stylesheet' type='text/css' href='../html/standard.css'/>
<link rel='icon' type='image/png' href='../../html/corner.png'/>
<style>
table, th, td {
border: 1px solid black;
}

td {
text-align:center; 
vertical-align:middle;
}

form {
position:relative;
top:8px;
}
</style>
</head>
<div style="overflow:hidden">
   <img src="../html/background.jpg" style="overflow:hidden;"/>
</div>
<body id="background">
<left><div id="wrapper" style="width:65%">
<h1>CMNS Advising</h1>

<?php

include ('mysql_connect.php');
// East cost timezone 
date_default_timezone_set('America/New_York');
//initalize varibales 
$username = $_POST['advisor'];

// Make a query to get advisors with the correct username
$sql = "SELECT fullName FROM advisors WHERE Email='$username'";
$rs = mysql_query($sql, $conn);
$fullName = mysql_fetch_array($rs)['fullName'];

// Make a query to get appointmenst where it has the correct advisor username
$sql = "SELECT * FROM appointments WHERE AdvisorEmail='$username' AND isFull=0";
$rs = mysql_query($sql, $conn);

?>

<!-- Prints out a table of the available appointments  -->
<?php echo "<h2> Showing available appointments for: <br/> $fullName ($username)</h2>"; ?>
<center><table>
<tr>
<th>Date</th>
<th>Time</th>
<th>Location</th>
<th>Group</th>
<th>#Students</th>
</tr>
<?php

 // Go line by line through the selected rows of the appointments 
while ($rs != false && $appt = mysql_fetch_array($rs))
{
  // Get whether the appointment is a group or not
  if ($appt['isGroup'] == 0) {
    $isGroup = "No";
  } else {
    $isGroup = "Yes";
  }
  // Print the important data about the appointment, date, time, locataion, isgroup, numstudents 
  echo "<tr>";
  echo "<td class='not_register'>" . $appt['Date'] . "</td>";
  echo "<td class='not_register'>" . date("g:ia", strtotime($appt['Time'])) . "</td>";
  echo "<td class='not_register'>" . $appt['Location'] . "</td>";
  echo "<td class='not_register'>" . $isGroup . "</td>";
  echo "<td class='not_register'>" . $appt['NumStudents'] . "</td>";
  $apptID = $appt['id'];
  ?>
    <td>
       <form method=post action="table_handler.php">
       <!--print out the apptID-->
       <?php echo "<input type=hidden name='ID' value=\"" . $apptID . "\"/>"; ?>
       <input type=submit value="Register"/>
       </form>
       </td>
    <?php
  echo "</tr>";
  }
?>

</table></center>

<h3 style='color: #FF0000;'>Copyright umbc.edu</h3>

</div>
</left>
</body>
</html>