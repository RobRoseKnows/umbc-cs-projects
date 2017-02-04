<?php
session_start();

//makes appropriate calls for buttons on student UI
if($_POST["selection"] == 'View'){
	header('Location: studentViewAppt.php');
}
elseif($_POST["selection"] == 'Cancel'){
	header('Location: studentCancel.php');
}
elseif($_POST["selection"] == 'Search'){
	header('Location: findAppointment.php');
}
elseif($_POST["selection"] == 'Edit'){
	header('Location: editStudentInfo.php');
}
elseif($_POST["selection"] == 'Sign Up'){
	header('Location: studentSignupAppt.php');
}

?>