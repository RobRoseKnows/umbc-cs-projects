<?php
$title = "Appointment Search";
require("./header.php");
$datePattern = '^(0[1-9]|1[012])[ .-/](0[1-9]|[12][0-9]|3[01])[-](19|20)\d\d';

?>

  <!----------Passes to results.php for parsin and handling----------->
  <form action='results.php' method='post' name='appointmentSearch'>
   
    <!-- Type, Location, Time, Day, Major -->
    <h1>Search for an appointment</h1>

    <label for='datePicker'>Date: </label>
    <input type='date' id='datePicker' name='datePicker' pattern=<?php echo("'$datePattern'"); ?> required placeholder='10/21/2015'> <br>

    <div>
		<!-----------------All times available---------->
      <h2>Time: </h2>
	        <label><input type="checkbox" name="time" value="08:00"> 8:00AM - 8:30AM </label><br>
		<label><input type="checkbox" name="time" value="08:30"> 8:30AM - 9:00AM </label><br>
		<label><input type="checkbox" name="time" value="09:00"> 9:00AM - 9:30AM </label><br>
		<label><input type="checkbox" name="time" value="09:30"> 9:30AM - 10:00AM </label><br>
		<label><input type="checkbox" name="time" value="10:00"> 10:00AM - 10:30AM </label><br>
		<label><input type="checkbox" name="time" value="10:30"> 10:30AM - 11:00AM </label><br>
		<label><input type="checkbox" name="time" value="11:00"> 11:00AM - 11:30AM </label><br>
		<label><input type="checkbox" name="time" value="11:30"> 11:30AM - 12:00PM </label><br>
		<label><input type="checkbox" name="time" value="12:00"> 12:00PM - 12:30PM </label><br>
		<label><input type="checkbox" name="time" value="12:30"> 12:30PM - 1:00PM </label><br>
		<label><input type="checkbox" name="time" value="13:00"> 1:00PM - 1:30PM </label><br>
		<label><input type="checkbox" name="time" value="13:30"> 1:30PM - 2:00PM </label><br>
		<label><input type="checkbox" name="time" value="14:00"> 2:00PM - 2:30PM </label><br>
		<label><input type="checkbox" name="time" value="14:30"> 2:30PM - 3:00PM </label><br>
		<label><input type="checkbox" name="time" value="15:00"> 3:00PM - 3:30PM </label><br>
		<label><input type="checkbox" name="time" value="15:30"> 3:30PM - 4:00PM </label><br>  
    </div>

    <div>
      <h2>Major: </h2>
      <?php include("includes/static/majorsSelect.php"); ?>
    </div>

    <!-- Need: datePicker, individual, times, major, onlyOpen-->
    <label><input type="checkbox" id="onlyOpen" name="onlyOpen" value = "open"> Show me only open sessions</label><br>

    <label><input type="checkbox" id="individual" name="individual" value = "ind"> Show me individual sessions only</label><br>

    <input type='submit'>

</div>
  </form>

	<!-----------------Unique Home buttons based on what Session variable is set...this doesn't work quite right---->
	<?php
	if(isset($_SESSION['ADVIDNumber']))
	{?>
			    <div class="finishButton">
			<button onclick="location.href = 'advisorHome.php'" class="button large go" >Return to Home</button>
	    </div>
		
	<?php}
	else
	{?>
			    <div class="finishButton">
			<button onclick="location.href = 'studentHome.php'" class="button large go" >Return to Home</button>
	    </div>
		
	<?php
	}
	?>


<?php
require("./footer.php");
?>