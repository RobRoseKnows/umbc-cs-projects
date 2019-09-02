<?php
session_start();

//Kills and unsets all session vars, boots back to index
session_unset();
session_destroy();

header('Location: index.html');
exit;

?>


