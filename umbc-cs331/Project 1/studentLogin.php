<?php
$title = "Student Login";
require("./header.php");
?>

<form action='logic/doStudentLogin.php' method='post' name='studentLogin'>

   <!--gets information from student needed to authenticate login to their account-->
   <label for='studIdNum'>Id Number: </label>
     <input type='text' id='studIdNum' name='studIdNum' pattern=<?php echo("'$umbcIdPattern'"); ?> required> <br>

  <label for='password'>Password: </label>
    <input type='password' id='password' name='password' required> <br>

   <input type='submit'>

</form>

<?php
  require('footer.php');
?>
