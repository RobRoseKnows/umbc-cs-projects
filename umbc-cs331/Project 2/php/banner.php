<?php
if(isset($_GET['done'])) {
  require_once('../error_codes.php');
    
  $showBanner = false;
  $bannerClass = ErrorCodes::$TYPE_INFO;
  $bannerMsg = "NO MESSAGE";
  switch($_GET['done']) {
    
  case ErrorCodes::$DISEN_DEFAULT_CODE:
    $showBanner = true;
    $bannerClass = ErrorCodes::$TYPE_INFO;
    $bannerMsg = "Default code from disen_advising.php";
    break;

  // Result of starting the advising season.
  case ErrorCodes::$SUCCESS_ENABLE_ADVISING:
    $showBanner = true;
    $bannerClass = ErrorCodes::$TYPE_POSITIVE;
    $bannerMsg = "Successfully started advising season.";
    break;

  case ErrorCodes::$FAILURE_ENABLE_ADVISING_GENERIC:
    $showBanner = true;
    $bannerClass = ErrorCodes::$TYPE_NEGATIVE;
    $bannerMsg = "Failed to start advising season (Generic)";
    break;

  case ErrorCodes::$FAILUTE_ENABLE_ADVISING_NOT_ADVISOR:
    $showBanner = true;
    $bannerClass = ErrorCodes::$TYPE_NEGATIVE;
    $bannerMsg = "Failed to start advising season (You are not an advisor)";
    break;


  // Result of ending the advising season
  case ErrorCodes::$SUCCESS_DISABLE_ADVISING:
    $showBanner = true;
    $bannerClass = ErrorCodes::$TYPE_POSITIVE;
    $bannerMsg = "Successfully ended advising season.";
    break;

  case ErrorCodes::$FAILURE_DISABLE_ADVISING_GENERIC:
    $showBanner = true;
    $bannerClass = ErrorCodes::$TYPE_NEGATIVE;
    $bannerMsg = "Failed to end advising season (Generic)";
    break;

  case ErrorCodes::$FAILURE_DISABLE_ADVISING_NOT_ADVISOR:
    $showBanner = true;
    $bannerClass = ErrorCodes::$TYPE_NEGATIVE;
    $bannerMsg = "Failed to end advising season (You are not an advisor)";
    break;
  }

  if($showBanner) 
    {
      echo("<div id='banner' class='$bannerClass'>");
      echo("<div id='banner-content'>");
      echo($bannerMsg);
      echo("</div>");
      echo("</div>");
    }
}
?>