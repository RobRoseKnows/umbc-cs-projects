<?php
include('../includes/QueryRunner.php');
$debug = true;
$RUNNER = new QueryRunner($debug);
//if the passwords given both match, create a new student
if(($_POST['password']) == ($_POST['rePassword'])) {
    $studIdNum = ($_POST['studIdNum']);
    $fName = ($_POST['fName']);
    $lName = ($_POST['lName']);
    $major = ($_POST['major']);
    $password = ($_POST['password']);
    $email = ($_POST['studEmail']);

    $checkQuery = "SELECT * FROM `Student Data` WHERE `StudentID` = '$studIdNum'";
    $checkResults = $RUNNER->executeQuery($checkQuery, $_SERVER["SCRIPT_NAME"]);

    // Check to make sure this student isn't in the system alreayd.
    if (mysql_num_rows($checkResults) > 0) {
        header('Location: studentHome.php');
    } else {

        $sql = "insert into `Student Data` (`ID`, `StudentID`, `FirstName`, `LastName`,`Password`, `ApptNum`,`Major`,`Email`) values (NULL, '$studIdNum', '$fName', '$lName', '" . md5($password) . "', NULL, '$major','$email')";
        $rs = $RUNNER->executeQuery($sql, $_SERVER["SCRIPT_NAME"]);

        header('Location: ../index.php');
    }
//otherwise, the passwords do not match and the user must be re-prompted
} else {
    header('Location: ../studentRegister.php');
}
?>
