<!-- login_student.html --> 
<!-- This file will get a username from the user then compare it to the database, if there is a match then the user will be logged in --> 

<?php include ('../header.html'); 
session_start();
?>

<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>Advising Homepage</title>
    <link rel='stylesheet' type='text/css' href='../standard.css'/>
    <link rel="icon" type="image/png" href="../corner.png" />
  </head>
  <div style="overflow:hidden">
    <img src="../../html/background.jpg" style="overflow:hidden;"/>
  </div>
  <body id="background">

  <!--<p style='clear:both;'><img src='umbc50logo.jpg' height='13%' width='25%'/></p>-->


<left><div id="wrapper">

<h1>Welcome to CMNS Advising</h1>
<h1>Student Login</h1>

<!-- Prints out the error message which tells the student what they did incorrectly -->
<h2>
<?php 
if( isset($_SESSION["error_message"]))
{
echo( "ERROR: " . $_SESSION["error_message"]);
session_destroy();
}
?>
</h2>
<div id="form1">
    <form method=post action='../../php/validate/validate_student_login.php'>
      <!-- Gets the only necessary data, a username from the user --> 
      <pre><h4>UMBC Email: <input type=text name="email"/></h4></pre>
      <pre><h4>Password: <input type=password name="password"/></h4></pre>
      <p><input type=submit value="Submit"/></p>
    </form>
	</div>

        <!-- Hyperlink to the register students page -->   
	<p style='color: #FF0000;'> Not signed up? Click <a href = "register_student.php">here</a> to register.</p>

	<h3 style='color: #FF0000;'>Copyright © umbc.edu</h3>
</div>
</left>
</div>
</body>
</html>
<?php include ('../footer.html'); ?>
