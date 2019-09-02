<?php
require_once('mysql_connect.php');
function check_advising_enabled() {
  $checkAdvisingQuery = "SELECT * FROM advisors WHERE `setEndOfSeason` = TRUE";
  $result = mysql_query($checkAdvisingQuery, $conn);
  $numRows = mysql_num_rows($result);
  if($numRows > 0) {
    header("Location: ../html/student_disable.html");
  }
}
check_advising_enabled();
?>