<?php
$title = "Advisor Sign Up";
$debug = false;
require("./header.php");
require "includes/CommonMethods.php";
$COMMON = new CommonMethods($debug);

?>

<form action='logic/doAdvisorRegister.php' method='post' name='advisorSignUp'>
    <!--get email from advisor-->
    <label for='advEmail'>Email: </label>
    <input type='email' id='advEmail' pattern=<?php echo("'$umbcEmailPattern'"); ?> required placeholder='example@umbc.edu'> <br>

  <!--get advisor's title-->
  <label for='advTitle'>Title: </label>
    <select id='advTitle' name='advTitle'>
        <option value='dr'>Dr.</option>
        <option value='miss'>Miss.</option>
        <option value='mr'>Mr.</option>
        <option value='ms'>Ms.</option>
    </select> <br>

  <!--collect other information from advisor necessary to populate database-->
  <label for='advIdNum'>Id Number: </label>
    <input type='text' id='advIdNum' name='advIdNum' pattern=<?php echo("'$umbcIdPattern'"); ?> required> <br>

  <label for='fName'>First Name: </label>
    <input type='text' id='fName' name='fName' required> <br>

  <label for='lName'>Last Name: </label>
    <input type='text' id='lName' name='lName' required> <br>

  <label for='office'>Office: </label>
    <input type='text' id='office' name='office' required> <br>

  <label for='password'>Password: </label>
    <input type='password' id='password' name='password' required> <br>

  <!--have advisor re-enter password to ensure they match (done on logic page)-->
  <label for='rePassword'>Retype Password: </label>
    <input type='password' id='rePassword' name='rePassword' required> <br>

    <? //This ternary statement tries to prevent a non-advisor from creating an advisor. ?>
  <input type='submit' <?php echo(!$COMMON->isAdvisor($_SESSION["ADVIDNumber"]) ? "disabled" : "")?>>

</form>

<?php
  require('footer.php');
?>
