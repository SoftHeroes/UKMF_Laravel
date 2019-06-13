<?php
use Illuminate\Support\Facades\DB;

    function Log_SMSAPISetupActivityLogs($ServiceID,$ResponseCode,$ResponseMessage,$Request,$Response)
    {
        DB::table('SMSAPISetupActivityLogs')->insert(
            [
                'serviceID' => $ServiceID,
                'responseCode' => $ResponseCode,
                'responseMessage' => $ResponseMessage,
                'request' => $Request,
                'response' => $Response
            ]
        );
    }
?>