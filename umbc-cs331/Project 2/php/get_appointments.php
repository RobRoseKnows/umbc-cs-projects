<!-- get_appointments.php -->
<!-- This file will filter and display the table of the filterd appointments -->

<html>
<head>
<title>Appointments</title>
  <link rel='stylesheet' type='text/css' href='../html/standard.css'/>
  <link rel='icon' type='image/png' href='../html/corner.png'/>
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
<left><div id="wrapper">
<h1>CMNS Advising</h1>

<!--<table border="0">
<tr>
<form action="processAdvisorHomepage.php" method="post" name="Home">
  <td><input type="submit" name="next" class="button main selection" value="Schedule appointment"></td>

  <td><input type="submit" name="next" class="button main selection" value="Print schedule"></td>

  <td><input type="submit" name="next" class="button main selection" value="Search appointments"></td>
</form>
</tr>
</table>-->

  
<?php

include ('mysql_connect.php');

date_default_timezone_set('America/New_York');
$date = date_create();
$x = ($_POST['week']*7);
$date = date_modify($date, "+$x day");
$date = date_format($date, 'Y-m-d');

$groupPref = $_POST['group'];
if($groupPref == 2)
{
  $sql = "SELECT * FROM appointments WHERE YEARWEEK(`Date`) = YEARWEEK('$date') AND isFull=0 AND isAvailable=1";
}
else
{
  $sql = "SELECT * FROM appointments WHERE YEARWEEK(`Date`) = YEARWEEK('$date') AND isFull=0 AND isAvailable=1 AND isGroup = " . $groupPref;
}
$rs = mysql_query($sql, $conn);
?>

<table>
<tr>
<th>Date</th>
<th>Time</th>
<th>Advisor</th>
<th>Location</th>
<th>Group</th>
<th>#Students</th>
</tr>

<?php

while ($appt = mysql_fetch_array($rs))
{

  if ($appt['isGroup'] == 0) {
    $isGroup = "No";
  } else {
    $isGroup = "Yes";
  }
  echo "<tr>";
  echo "<td class='not_register'>" . $appt['Date'] . "</td>";
  echo "<td class='not_register'>" . date("g:ia", strtotime($appt['Time'])) . "</td>";
  echo "<td class='not_register'>" . $appt['SessionLeader'] . "</td>";
  echo "<td class='not_register'>" . $appt['Location'] . "</td>";
  if($appt['isGroup'] == 0)
    echo "<td class='not_register'>" . "No" . "</td>";
  else
    echo "<td class='not_register'>" . "Yes" . "</td>";

  echo "<td class='not_register'>" . $appt['NumStudents'] . "</td>";
  $apptID = $appt['id'];
  ?>
    <td>
       <form method=post action="table_handler.php">
       <?php echo "<input type=hidden name='ID' value=\"" .$apptID . "\"/>"; ?>
       <input type=submit value="Register"/>
       </form>
       </td>
    <?php
  echo "</tr>";
}
?>
</table>
  
  <h3 style='color: #FF0000;'>Copyright umbc.edu</h3>

</div>
</left>
</body>
</html>
