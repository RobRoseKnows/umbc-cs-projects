<?php
session_start();

$debug = true;

// You have to initialize Common on your own.
include('includes/CommonVariables.php');

if($title == null) {
  $title = "Student Advising Scheduler";
}

?><!DOCTYPE html>

<html lang="en">
    <head>
        
        <meta charset="UTF-8" />
        <link rel='stylesheet' type='text/css' href='./standard.css'/>
        <title><?php echo $title;?></title>
    
    </head>
    <body>