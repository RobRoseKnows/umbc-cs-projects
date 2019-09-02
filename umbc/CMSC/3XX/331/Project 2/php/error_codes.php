<?php

class ErrorCodes {

/************************************
 * Banner error type css classes    *
 ************************************/

public static $TYPE_INFO = "info";
public static $TYPE_POSITIVE = "positive";
public static $TYPE_NEGATIVE = "negative";

/************************************
 * disen_advising.php Codes         *
 ************************************/

public static $DISEN_DEFAULT_CODE = "disen_def";

// Enabled advising results from disen_advising.php

public static $SUCCESS_ENABLE_ADVISING = "enable_advising_succ";
public static $FAILURE_ENABLE_ADVISING_GENERIC = "enable_advising_fail_gen";
public static $FAILURE_ENABLE_ADVISING_NOT_ADVISOR = "enable_advising_fail_notadv";


// Disabled advising results from disen_advising.php

public static $SUCCESS_DISABLE_ADVISING = "disable_advising_succ";
public static $FAILURE_DISABLE_ADVISING_GENERIC = "disable_advising_fail_gen";
public static $FAILURE_DISABLE_ADVISING_NOT_ADVISOR = "disable_advising_fail_notadv";

}

?>
