<?php
$title = "Appointment Search";
require("./header.php");
?>

  <form action='results.php' method='get' name='appointmentSearch'>
    <!-- Type, Location, Time, Day, Major -->
    <h1>Search for an appointment</h1><br>

    <label for='datePicker'>Date: </label>
    <input type='text' id='datePicker' name='datePicker' pattern=<?php echo("'$datePattern'"); ?> required placeholder='10/21/2015'> <br>

    <div>
      <h3>Time: </h3><br>
      <?php include("includes/static/timeCheckboxes.php"); ?>
    </div>

    <div>
      <h3>Major: </h3><br>
      <?php include("includes/static/majorsSelect.php"); ?>
    </div>

    <!-- Need: datePicker, individual, times, major, onlyOpen-->
    <label><input type="checkbox" id="onlyOpen" name="onlyOpen"> Show me only open sessions</label><br>

    <label><input type="checkbox" id="individual" name="individual"> Show me individual sessions only</label><br>

    <input type='submit'>
  </form>

<?php
require("./footer.php");
?>