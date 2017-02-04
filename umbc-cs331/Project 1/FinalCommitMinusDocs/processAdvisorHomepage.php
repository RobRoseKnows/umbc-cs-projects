<?php
session_start();

//calls php file based on admin action
if($_POST["next"] == 'Schedule appointments'){
	header('Location: createAppointment.php');
}
elseif($_POST["next"] == 'Print schedule for a day'){
	header('Location: advisorPrintSchedule.php');
}
elseif($_POST["next"] == 'Edit appointments'){
	header('Location: advisorEditAppts.php');
}
elseif($_POST["next"] == 'Search for an appointment'){
	header('Location: findAppointment.php');
}


?>