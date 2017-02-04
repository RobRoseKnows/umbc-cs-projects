<?php
session_start();
include('CommonMethods.php');

$debug = false;
$COMMON = new Common($debug);

$sql = "select * from `Student Data`";
$rs = $COMMON->executeQuery($sql, $_SERVER["SCRIPT_NAME"]);

//Fetch student info
while($row = mysql_fetch_row($rs)){
	if($row[1] == $_SESSION["SIDNumber"]){
		
		$_SESSION["firstName"] = $row[2];
		$_SESSION["lastName"] = $row[3];
		$_SESSION["major"] = $row[6];
		$_SESSION["studEmail"]=$row[7];
		$_SESSION["SIDNumber"]=$row[1];
	}
}

?>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>Edit Student Information</title>
    	<link rel='stylesheet' type='text/css' href='standard.css'/>

  </head>
  <body>
    <div id="login">
      <div id="form">
	<!--Displays previously parsed information-->
			<div class="top">
			<h2>Edit Student Information<span class="login-create"></span></h2>
			<form action="processStudentEdit.php" method="post" name="Edit">
			<div class="field">
				<label for="firstName">First Name</label>
				<input id="firstName" size="30" maxlength="50" type="text" name="firstName" required value=<?php echo $_SESSION["firstName"]?>>
			</div>
			<div class="field">
			  <label for="lastName">Last Name</label>
			  <input id="lastName" size="30" maxlength="50" type="text" name="lastName" required value=<?php echo $_SESSION["lastName"]?>>
			</div>
			<div class="field">
				<label for="studEmail">E-mail</label>
				<input id="studEmail" size="30" maxlength="255" type="text" name="studEmail" required value=<?php echo $_SESSION["studEmail"]?>>
			</div>
			<div class="field">
				  <label for="major">Major</label>
				  <select id="major" name = "major">
					<option <?php if($_SESSION["major"] == 'Biochem'){echo("selected");}?> value='Biochem'>Biochemistry & Molecular Biology BS</option>
					<option <?php if($_SESSION["major"] == 'Bioinfo'){echo("selected");}?> value='Bioinfo'>Bioinformatics & Computational Biology BS</option>
					<option <?php if($_SESSION["major"] == 'BioBA'){echo("selected");}?> value='BioBA'>Biological Sciences BA</option>
					<option <?php if($_SESSION["major"] == 'BioBS'){echo("selected");}?> value='BioBS'>Biological Sciences BS</option>
					<option <?php if($_SESSION["major"] == 'Bioed'){echo("selected");}?> value='Bioed'>Biology Education BA</option>

					<option <?php if($_SESSION["major"] == 'ChemBA'){echo("selected");}?> value='ChemBA'>Chemistry BA</option>
					<option <?php if($_SESSION["major"] == 'ChemBS'){echo("selected");}?> value='ChemBS'>Chemistry BS</option>
					<option <?php if($_SESSION["major"] == 'Chemed'){echo("selected");}?> value='Chemed'>Chemistry Education BA</option>

				  </select>
			</div>
			<div class="nextButton">
				<input type="submit" name="save" class="button large go" value="Save">
			</div>
			</div>
		</form>
  </body>
  
</html>
