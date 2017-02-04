<?php
$headerTitle = "Student Sign In";
require("header.php");
include("CommonVariables.php");
?>

<form action='doStudentLogin.php' method='post' name='studentLogin'>

   <label for='studIdNum'>Id Number: </label>
     <input type='text' id='studIdNum' name='studIdNum' pattern='[A-Z]{2}[0-9]{5}' required> <br>

  <label for='password'>Password: </label>
    <input type='password' id='password' name='password' required> <br>

   <input type='submit'>

</form>

<?php

  require('footer.php');
?>
