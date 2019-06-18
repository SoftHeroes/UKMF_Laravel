<?php
use Illuminate\Support\Facades\DB;
require_once app_path() . '/Helpers/Maths.php';

    function Log_SMSAPISetupActivityLogs($SMSAPIRequestTime,$SendTo,$ServiceID,$ResponseCode,$ResponseMessage,$Request,$Response)
    {

        date_default_timezone_set('Asia/Kolkata');
        $SMSAPIresponseTime = date('Y-m-d h:i:s.u', time());
        $TimeTaken = millisecsBetween($SMSAPIresponseTime,$SMSAPIRequestTime);

        DB::table('SMSAPISetupActivityLogs')->insert(
            [
                'sendTo' => $SendTo,
                'serviceID' => $ServiceID,
                'responseCode' => $ResponseCode,
                'responseMessage' => $ResponseMessage,
                'requestTime' => $SMSAPIRequestTime,
                'responseTime' => $SMSAPIresponseTime,
                'timeTaken' => $TimeTaken,
                'request' => $Request,
                'response' => $Response
            ]
        );
    }

    function Log_APIActivityLog($Service,$Method,$ErrorFound,$ResponseCode,$ResponseMessage,$Version,$Source,$Language,$RequestTime,$Request,$Response,$Expectation)
    {

        date_default_timezone_set('Asia/Kolkata');
        echo '';
        $ResponseTime = date('Y-m-d h:i:s.u', time());
        $TimeTaken = millisecsBetween($ResponseTime,$RequestTime);

        echo '';
        DB::table('ActivityLog')->insert(
            [
                'service' => $Service,
                'method' => $Method,
                'errorFound' => $ErrorFound,
                'ResponseCode' => $ResponseCode,
                'responseMessage' => $ResponseMessage,
                'version' => $Version,
                'source' => $Source,
                'language' => $Language,
                'requestTime' => $RequestTime,
                'responseTime' => $ResponseTime,
                'timeTaken' => $TimeTaken,
                'request' => $Request,
                'response' => $Response,
                'expectation' => $Expectation
            ]
        );
    }
?>