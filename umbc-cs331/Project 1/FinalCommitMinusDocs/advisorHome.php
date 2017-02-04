<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>Student Advising Home</title>
	<link rel='stylesheet' type='text/css' href='standard.css'/>
  </head>
  <body>
	<div class="container">
	<?php
		include('./header.php');
	?>

	<!------Build the container for everything to go in---->
	<div class="container main">
	<div id="nav">
		<!-------------Passess all buttons to the process page for redirection----------->
		<form action="processAdvisorHomepage.php" method="post" name="Home">
	  
			<input type="submit" name="next" class="button main selection" value="Schedule appointments"><br>
			<input type="submit" name="next" class="button main selection" value="Print schedule for a day"><br>
			<!--------------------Edit appts was not required and will be implemented in a future release----->
			<!-- <input type="submit" name="next" class="button main selection" value="Edit appointments"><br> -->
			<input type="submit" name="next" class="button main selection" value="Search for an appointment"><br>
		
		</form>
	</div>
	<div id="section">
		<!---------------Uses stored session var from doAdvisorLogin.php to print welcome message----------->
		<!---------------Also has a stored flag for lazy days where nothing is in the scedule--------------->
		<h1><?php echo "Welcome, {$_SESSION['ADVIDNumber']}!";  ?> </h1>
		<?php 
			if($_SESSION['PRINTFAIL'] == TRUE)
			{
				echo"No schedule to print today, nothing scheduled yet!";
				$_SESSION['PRINTFAIL'] = FALSE;
			}
		?>

	</div>
	</div>
	<?php
		include('./footer.php');
	?>
	</div>
  </body>
</html>






