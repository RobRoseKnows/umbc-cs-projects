$checkCurrentApptQuery = "SELECT * FROM `Student Data` WHERE `ApptNum` IS NOT N\
ULL AND `StudentID` = $studIdNum";

$checkCurrentResult = $RUNNER->executeQuery($checkCurrentApptQuery, $_SERVER["S\
CRIPT_NAME"]);

if(mysql_num_rows($checkCurrentResult) > 0) {

  // Get rid of that user in the appointment they're already in.
  $removeStudentFromAppointment = "UPDATE `Appointment` SET `listOfStudents` = \
REPLACE(`listOfStudents`, ',$studIdNum', '')"
." WHERE INSTR(`listOfStudents`, ',$studIdNum') > 0";

  $RUNNER->executeQuery($removeStudentFromAppointment, $_SERVER["SCRIPT_NAME"])\
;
}

$addStudentQuery =
  "UPDATE `Appointment` SET `listOfStudents` ="
  ." ( CASE WHEN `listOfStudents`=''"
  ." THEN $studIdNum"
  ." ELSE concat(`listOfStudents`,',$studIdNum' ) END )"
  ." AND `numStudents` = `numStudents` + 1";

$RUNNER->executeQuery($addStudentQuery, $_SERVER["SCRIPT_NAME"]);


