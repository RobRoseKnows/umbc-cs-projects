<?php
  $title = "Advisor Login";
  require("./header.php");
?>

<form action='logic/doAdvisorLogin.php' method='post' name='advisorLogin'>

   <!--have advisor submit their user id and password-->
   <label for='advIdNum'>Id Number: </label>
     <input type='text' id='advIdNum' name='advIdNum' pattern=<?php echo("'$umbcIdPattern'"); ?> required> <br>

   <label for='password'>Password: </label>
    <input type='password' id='password' name='password' required> <br>

   <input type='submit'>

</form>

<?php
  require('./footer.php');
?>
