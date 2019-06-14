<?php
use Illuminate\Support\Facades\DB;

    function Log_SMSAPISetupActivityLogs($SMSAPIRequestTime,$SendTo,$ServiceID,$ResponseCode,$ResponseMessage,$Request,$Response)
    {

        date_default_timezone_set('Asia/Kolkata');
        $SMSAPIresponseTime = date('Y-m-d h:i:s', time());
        $TimeTaken = millisecsBetween($SMSAPIresponseTime,$SMSAPIRequestTime);
        echo $TimeTaken;

        DB::table('SMSAPISetupActivityLogs')->insert(
            [
                'sendTo' => $SendTo,
                'serviceID' => $ServiceID,
                'responseCode' => $ResponseCode,
                'responseMessage' => $ResponseMessage,
                'requestTime' => $SMSAPIRequestTime,
                'responseTime' => $SMSAPIresponseTime,
                'timeTaken' => 3434,
                'request' => $Request,
                'response' => $Response
            ]
        );
    }
?>