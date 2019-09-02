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
	<div class="container main">
	<div id="nav">
		<form action="processAdvisorHomepage.php" method="post" name="Home">
	  
			<input type="submit" name="next" class="button main selection" value="Schedule appointments"><br>
			<input type="submit" name="next" class="button main selection" value="Print schedule for a day"><br>
			<input type="submit" name="next" class="button main selection" value="Edit appointments"><br>
			<input type="submit" name="next" class="button main selection" value="Search for an appointment"><br>
		
		</form>
	</div>
	<div id="section">
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






