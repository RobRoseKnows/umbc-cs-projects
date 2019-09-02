<!-- This page is for the advisors to search through exisiting appointments. -->
<!-- They can search by group, date, or advisor-->

<?php 
   session_start(); 
require_once('mysql_connect.php');

//set timezone to the east coast
date_default_timezone_set('America/New_York');

if($_SESSION['search'] == "") {
  $_SESSION['search'] = "";
}
?>

<html>
<head><title>Search Appointments</title>
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
<body>

<div id="background">
<left><div id="wrapper">
<h1>CMNS Advising</h1>
<h2>What would you like to search by?</h2>
<center><table border="0">
<tr>
<form action="processSearchPage.php" method="post" name="Home">
  <td><input type="submit" name="next" class="button main selection" value="Group appointment"></td>

  <td><input type="submit" name="next" class="button main selection" value="Date of appointment"></td>

  <td><input type="submit" name="next" class="button main selection" value="Session Leader"></td>
</form>
</tr>
</table></center>

<?php

$searchVar = $_SESSION['search'];

if($searchVar != "") {
  //if the string isn't null, pull all the appointments from the table
  $sql = "SELECT * FROM appointments ORDER BY Date ASC, Time ASC";
  $rs = mysql_query($sql, $conn);

  $appt = mysql_fetch_array($rs);

  if($appt) {

    if($searchVar == "group") {
      //display appointments if they're a group
      echo"<h3> Group Appointments </h3>";
      echo "<center><table>";
      echo "<tr>";
      echo "<th>Session Leader</th>";
      echo "<th>Date</th>";
      echo "<th>Time</th>";
      echo "<th>Location</th>";
      echo "<th>#Students</th>";
      echo "<th>View Registered Students</th>";
      echo "</tr>";

      // Now this cycles through the section of the query                                  
      while ($appt) {
	//if it's a group, display all the info
	if($appt['isGroup'] == 1) {
	  echo "<tr>";
	  echo "<td>" . $appt['SessionLeader'] . "</td>";
	  echo "<td>" . $appt['Date'] . "</td>";
	  echo "<td>" . date("g:ia", strtotime($appt['Time'])) . "</td>";
	  echo "<td>" . $appt['Location'] . "</td>";
	  
	  // check if the appointment is a group appointment or not                          	
	  echo "<td>" . $appt['NumStudents'] . "</td>";
	  
	  $apptID = $appt['id'];
	  
	  // Print out the check students button if there are students signed up for the appointment                                                                                   
	  
	  if ($appt['NumStudents'] > 0)
	    {
	      echo "<td>";
	      echo "<form method=post action='view_students.php'>";
	      echo "<input type=hidden name='ID' value='$apptID' />";
	      echo "<input type=submit value='View Registered Students'/>";
	      echo "</form>";
	      echo "</td>";
	      
	      // If there are not any students signed up then tell the user that                  
	    } else {
	    echo "<td>No Students Registered</td>";
	  }
	}
	$appt = mysql_fetch_array($rs);
      }
      echo"</table></center>";
    } else if ($searchVar == "date") {
      //display appointments by date

      echo"<h3>Appointments Ordered by Date</h3>";
      echo "<center><table>";
      echo "<tr>";
      echo "<th>Date</th>";
      echo "<th>Session Leader</th>";
      echo "<th>Time</th>";
      echo "<th>Location</th>";
      echo "<th>Group</th>";
      echo "<th>#Students</th>";
      echo "<th>View Registered Students</th>";
      echo "</tr>";

      // Now this cycles through the section of the query
      while ($appt) {
	echo "<tr>";
	echo "<td>" . $appt['Date'] . "</td>";
	echo "<td>" . $appt['SessionLeader'] . "</td>";
	echo "<td>" . date("g:ia", strtotime($appt['Time'])) . "</td>";
	echo "<td>" . $appt['Location'] . "</td>";
	
	// check if the appointment is a group appointment or not
	if($appt['isGroup'] == 0) {
	  echo "<td>" . "No" . "</td>";
	} else {
	  echo "<td>" . "Yes" . "</td>";
	}
	
	echo "<td>" . $appt['NumStudents'] . "</td>";
	  
	$apptID = $appt['id'];
	  
	// Print out the check students button if there are students signed up for the appointment 
	  
	if ($appt['NumStudents'] > 0)
	  {
	    echo "<td>";
	    echo "<form method=post action='view_students.php'>";
	    echo "<input type=hidden name='ID' value='$apptID' />";
	    echo "<input type=submit value='View Registered Students'/>";
	    echo "</form>";
	    echo "</td>";
	    
	    // If there are not any students signed up then tell the user that
	  } else {
	  echo "<td>No Students Registered</td>";
	}
	$appt = mysql_fetch_array($rs);
      }
      echo"</table></center>";

    } else if ($searchVar == "advisor") {
      //display appointments by advisor

      echo"<h3> Group Appointments </h3>";
      echo "<center><table>";
      echo "<tr>";
      echo "<th>Session Leader</th>";
      echo "<th>Date</th>";
      echo "<th>Time</th>";
      echo "<th>Location</th>";
      echo "<th>Group</th>";
      echo "<th>#Students</th>";
      echo "<th>View Registered Students</th>";
      echo "</tr>";

      // Now this cycles through the section of the query
      while ($appt) {
	echo "<tr>";
	echo "<td>". $appt['SessionLeader'] . "</td>";
	echo "<td>" . $appt['Date'] . "</td>";
	echo "<td>" . date("g:ia", strtotime($appt['Time'])) . "</td>";
	echo "<td>" . $appt['Location'] . "</td>";
	
	// check if the appointment is a group appointment or not
	if($appt['isGroup'] == 0) {
	  echo "<td>" . "No" . "</td>";
	} else {
	  echo "<td>" . "Yes" . "</td>";
	}
	
	echo "<td>" . $appt['NumStudents'] . "</td>";
	  
	$apptID = $appt['id'];
	  
	// Print out the check students button if there are students signed up for the appointment 
	  
	if ($appt['NumStudents'] > 0)
	  {
	    echo "<td>";
	    echo "<form method=post action='view/view_students.php'>";
	    echo "<input type=hidden name='ID' value='$apptID' />";
	    echo "<input type=submit value='View Registered Students'/>";
	    echo "</form>";
	    echo "</td>";
	    
	    // If there are not any students signed up then tell the user that
	  } else {
	  echo "<td>No Students Registered</td>";
	}
	$appt = mysql_fetch_array($rs);
      }
      echo"</table></center>";

    }
  }
}
?>
 
<p><a href="view/advisor_view.php"> Go Back to Advisor View </a></p>
<h3 style='color: #FF0000;'>Copyright umbc.edu</h3>

</div>
</left>
</div>
</body>
</html>
