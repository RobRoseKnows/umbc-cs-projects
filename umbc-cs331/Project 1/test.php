<?php

include "includes/QueryRunner.php";

$RUNNER = new QueryRunner(true);
$query = "select * from `Student Data` where `StudentID` = 'AB12345' and `Password` = '5f4dcc3b5aa765d61d8327deb882cf99' ";
$rs = $RUNNER->executeQuery($query, $_SERVER["SCRIPT_NAME"]);

echo(mysql_num_rows($rs));
?>