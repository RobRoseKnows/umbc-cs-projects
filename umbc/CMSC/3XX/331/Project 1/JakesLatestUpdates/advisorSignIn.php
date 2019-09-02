<?php
$headerTitle = "Advisor Sign In";
require("header.php");
include("CommonVariables.php");
?>

<form action='doAdvisorLogin.php' method='post' name='advisorLogin'>

   <label for='advIdNum'>Id Number: </label>
     <input type='text' id='advIdNum' name='advIdNum' pattern='[A-Z]{2}[0-9]{5}' required> <br>

   <label for='password'>Password: </label>
    <input type='password' id='password' name='password' required> <br>

   <input type='submit'>

</form>

<?php
  require('footer.php');
?>
