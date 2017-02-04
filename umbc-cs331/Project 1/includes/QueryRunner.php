<?php

/**
 * Created by PhpStorm.
 * User: Robert
 * Date: 10/27/2016
 * Time: 4:03 PM
 */
class QueryRunner
{
    protected $conn;
    protected $debug;

    function QueryRunner($debug) {
        $this->debug = $debug;
        $rs = $this->connect("she3"); // db name really her
        return $rs;
    }


// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% */

    function connect($db)// connect to MySQL
    {
        $conn = @mysql_connect("studentdb-maria.gl.umbc.edu", "she3", "she3") or die("Could not connect to MySQL");
        $rs = @mysql_select_db($db, $conn) or die("Could not connect select $db database");
        $this->conn = $conn;
    }

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% */

    function executeQuery($sql, $filename) // execute query
    {
        if($this->debug == true) { echo("$sql <br>\n"); }
//        $escaped = @mysql_real_escape_string($sql);
        $rs = @mysql_query($sql, $this->conn) or die("Could not execute query '$sql' in $filename");
        return $rs;
    }
}