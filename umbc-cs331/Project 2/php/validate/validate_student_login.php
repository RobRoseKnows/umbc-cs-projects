//validate_student_login.php
//This file will check if the student logging in is entering a valid value

<?php
session_start();

require_once('../mysql_connect.php');

$email = $_POST['email'];
$password = ($_POST['password']);
$truePassword = md5($password);

// Make the query to get the info out of advisors table
$sql = "SELECT * FROM `students` WHERE `Email` = '$email' AND `Password` = '$truePassword'";
$rs = mysql_query($sql, $conn);
$name_found = False;
$_SESSION["error_message"] = "";

//count of how many many rows are returned when query is run 
$num_rows = mysql_num_rows($rs);

echo "should print";

//if only one match, password correct
if ($num_rows == 1) {
    $name_found = True;
}

// This is the pass case
if ($name_found) {
    session_start();
    $_SESSION['studentEmail'] = $email;
    $student = mysql_fetch_assoc($rs);
    if($student['appointmentChanged'] == 1){
        $_SESSION['other_message'] = "Your appointment was changed by an advisor";
    }
    // go to the student_view.php page
    header('Location:../../php/view/student_view.php');
} // This is the fail case
else {
    // Check if the username was left blank
    if ($email == "") {
        echo "should print";
        $_SESSION["error_message"] = "Username field can't be blank.<br>";

    } // Check if the username or password was not found in the data base
    else {
        $_SESSION["error_message"] = "Username or password not recognized.<br>";
        echo "should print";
    }

    // go back to the login_student.html file
    header('Location: ../../html/forms/login_student.php');

}
?>
