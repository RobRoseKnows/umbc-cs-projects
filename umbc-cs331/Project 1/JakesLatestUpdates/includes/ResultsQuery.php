<?php

include("./CommonMethods.php");
include("./QueryRunner.php");

class SearchingClass
{
    protected $COMMON;
    protected $DEBUG;
    protected $RUNNER;

    function SearchingClass($debug) {
        $this->DEBUG = $debug;
        $this->COMMON = new CommonMethods($debug);
        $this->RUNNER = new QueryRunner($debug);
    }

    function searchFor($dict)
    {

        if (!isset($dict["datePicker"])) {
            header("Location: findAppointment.php");
            return null;
        } else {
            $date = $dict["datePicker"];

            $query = "SELECT * FROM `Appointment` WHERE (`Day` = '$date'";

            $clause = ") AND ( WHERE ";

            if (isset($dict["time"])) {
                $times = $dict["time"];
                foreach ($times as $time) {
                    $query .= "$clause `TimeSlot` = '$time'";
                    $clause = " OR ";
                }
            }

            $clause = ") AND ( WHERE ";

            if (isset($dict["major"])) {
                $major = $dict["major"];

                $query .= "$clause `Major` LIKE '%$major%'";
            }

            if (isset($dict["individual"])) {
                $query .= "$clause `maxStudents` = 1";
            } else {
                $query .= "$clause `maxStudents` > 1";
            }

            if(isset($dict["onlyOpen"])) {
                $query .= "$clause `numStudents` < `maxStudents`";
            }

            $query .= " ) SORT BY `TimeSlot` ASC";
            return $this->RUNNER->executeQuery($query, $_SERVER["SCRIPT_NAME"]);
        }
    }



    function lineForRow($row) {
        $apptId = $row["ID"];
        $location = $row["Location"];
        $timeSlot = $row["TimeSlot"];

        $numStudents = $row["numStudents"];
        $maxStudents = $row["maxStudents"];
        $slotsLeft = $maxStudents-$numStudents;

        $nameIdInput = "appt-option-$apptId";

        // If there are no slots left in an advising session, disable this option.
        $inputTag = "";
        if ($slotsLeft > 0) {
            $inputTag = "<input type='radio' name='appointment' id='$nameIdInput' value='$apptId'>";
        } else {
            $inputTag = "<input type='radio' name='appointment' id='$nameIdInput' value='$apptId' disabled>";
        }

        $labelOpenTag = "<label for='$nameIdInput'>";

        $label = "Time: $timeSlot - Location: $location";

        if($slotsLeft > 0) {
            $label .= " - $slotsLeft out of $maxStudents slots open.";
        } else {
            $label .= " - FULL";
        }

        $labelCloseTag = "</label>";
        $lineEnd = "<br>";

        // This puts all of the elements together and then returns it as a string.
        $finalOutput = $labelOpenTag."".$inputTag."".$label."".$labelCloseTag."".$lineEnd;
        return $finalOutput;
    }



    function echoTerms($dict) {
        $title = "Search for ";

        if(isset($dict["onlyOpen"])) {
            $title .= "open ";
        } else {
            $title .= "all ";
        }

        if (isset($dict["individual"])) {
            $title .= "individual appointments ";
        } else {
            $title .= "group appointments ";
        }

        if(isset($dict["datePicker"])) {
            $title .= "on: ".$dict["datePicker"];
        }

        if (isset($dict["time"])) {
            $times = $dict["time"];

            $clause = " at: ";
            foreach ($times as $time) {
                $title .= $clause.$time;
                $clause = "or ";
            }
        }

        if (isset($dict["major"])) {
            $major = $dict["major"];

            $title .= " for $major majors";
        }

        return $title;

    }
}
?>

