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
	<!------------build the container for the homepage to contain itself in---------->
	<div class="container main">
	<div id="nav">
		<form action="processStudentHomepage.php" method="post" name="Home">
		<?php

			<!-------------All the buttons for redirects, goes through processStudentHomepage-------->
			echo "<button type='submit' name='selection' class='button main selection' value='View'>View my appointment</button><br>";
			echo "<button type='submit' name='selection' class='button main selection' value='Cancel'>Cancel my appointment</button><br>";
			echo "<button type='submit' name='selection' class='button main selection' value='Search'>Search for appointment</button><br>";
			echo "<button type='submit' name='selection' class='button main selection' value='Edit'>Edit student information</button><br>";
			echo "<button type='submit' name='selection' class='button main selection' value='Sign Up'>Sign Up for an Appointment</button><br>";

		?>
		</form>
	</div>
	<div id="section">
		
		<!--------------Custom Welcome screen---------->
		<h1><?php echo "Welcome, {$_SESSION['SIDNumber']}!";  ?> </h1>
		<?php
			//kick back the bad signup message if you tried to do something you shouldn't
			if($_SESSION['badSignup'] == TRUE)
			{
				echo"You've already scheduled something or that appointment was full!";
				$_SESSION['badSignup'] = FALSE;
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