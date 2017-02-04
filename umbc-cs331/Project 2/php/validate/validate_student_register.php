<!-- validate_student.php -->
<!-- This file checks if the student registering is entering valid information -->
<?php

session_start();
include('../../CommonMethods.php');
$debug = false;
$COMMON = new Common($debug);

// Finds all the usernames from the database
$email = $_POST['email'];
$sql = "SELECT * FROM `students` WHERE `Email` = '$email'";
$rs = $COMMON->executeQuery($sql, $_SERVER["SCRIPT_NAME"]);
$num_rows = mysql_num_rows($rs);
$row = mysql_fetch_row($rs);

//By default no errors
$errors = FALSE;
$_SESSION["error_message"] = "ERRORS: <br>";
$major = $_POST['major'];
$firstName = $_POST['firstName'];
$lastName = $_POST['lastName'];
$studentID = $_POST['studentID'];
$password = $_POST['password'];
$rePass = $_POST['rePassword'];
$prefName = $_POST['prefName'];


//Loop through usernames, check for match
if ($num_rows > 0) {
    //Match found - BAD - there is an error
    $errors = TRUE;
    $_SESSION["error_message"] .= "Email already taken<br>";
}

//Username left blank check
if ($email == "") {
    $errors = TRUE;
    $_SESSION["error_message"] .= "Email field can't be blank.<br>";
}

//Major left blank check
if ($major == "") {
    $errors = TRUE;
    $_SESSION["error_message"] .= "Major field can't be left blank.<br>";
}
// First name left blank check
if ($firstName == "") {
    $errors = TRUE;
    $_SESSION["error_message"] .= "First Name field can't be left blank.<br>";
}

// Last name left blank check
if ($lastName == "") {
    $errors = TRUE;
    $_SESSION["error_message"] .= "Last Name field can't be left blank.<br>";
}

// StudentID left blank check
if ($studentID == "") {
    $errors = TRUE;
    $_SESSION["error_message"] .= "Student ID field can't be left blank.<br>";
}

// email left blank check
if ($email == "") {
    $errors = TRUE;
    $_SESSION["error_message"] .= "Email field can't be left blank.<br>";
}

//passwords given do not match
if ($password != $rePass) {
    $errors = TRUE;
    $_SESSION["error_message"] .= "Passwords do not match.<br>";
}

if ($errors != TRUE) {
    echo 1234;
    $_SESSION["studentEmail"] = $email;
    $hashedPass = md5($password);
    //No errors - GOOD - Continue to the additional info page
    $sql = "INSERT INTO `students` (`Email`, `Major`, `firstName`, `lastName`, `studentID`, `Password`, `prefName`) VALUES ('$email', '$major', '$firstName', '$lastName', '$studentID', '$hashedPass', '$prefName')";
    $rs = $COMMON->executeQuery($sql, $_SERVER["SCRIPT_NAME"]);
    header("Location: ../../html/forms/post_registration.php");


} else {
    // Go to the register_student.php file
    header('Location: ../../html/forms/register_student.php');
}
?>
