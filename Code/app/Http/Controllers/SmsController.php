<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Route;

require_once app_path() . '/Helpers/APICall.php';
require_once app_path() . '/Helpers/Logger.php';
require_once app_path() . '/Helpers/Maths.php';

class SmsController extends Controller
{
    public function sentSMS(Request $request)
    {
        date_default_timezone_set('Asia/Kolkata');

        $source = $request->input("source");
        $templateName = $request->input("templateName");
        $phoneNumber = $request->input("phoneNumber");
        $language = $request->input("language");

        $APIdata =  DB::select("call USP_getSMSURL('".$source."','".$templateName."','".$phoneNumber."','".$language."');");
        

        if($APIdata[0]->ErrorFound == 'YES')
        {
            $response = array("Code" => $APIdata[0]->Code,"ErrorFound" => $APIdata[0]->ErrorFound,"Message" => $APIdata[0]->Message,"version" => $APIdata[0]->version,"language" => $APIdata[0]->language,"ErrorMessage" => $APIdata[0]->ErrorMessage);
        }
        else
        {
            $RequestTime = date('Y-m-d h:i:s.u', time());
            $APIExecuteResponse = json_decode(APIExecute($APIdata[0]->Method,$APIdata[0]->URL,null), true);

            if($APIdata[0]->ErrorMessage == null )
            {
                $APIdata[0]->ErrorMessage = 'null';
            }

            if($APIdata[0]->CustomerPassword == null )
            {
                $APIdata[0]->CustomerPassword = 'null';
            }

            if( $APIExecuteResponse[$APIdata[0]->ResponseStatusTag] == '200')
            {   
                $response = DB::select( DB::raw(" SELECT `Code`,`ErrorFound`,`Message`,`version`,`language`,"."'".$APIdata[0]->AlreadyRegisteredUser."'"." as AlreadyRegisteredUser,".$APIdata[0]->ErrorMessage ." as ErrorMessage,".$APIdata[0]->OTP." as OTP, ".$APIdata[0]->OTPExpiryTime." as OTPExpiryTime,".$APIdata[0]->resendOTPAttempts." as resendOTPAttempts,".$APIdata[0]->OTPAttempts." as OTPAttempts,".$APIdata[0]->userLockTiming." as userLockTiming,".$APIdata[0]->CustomerPassword." as CustomerPassword FROM MessageMaster WHERE Code = 'ERR00030' AND language = '$language'") );
            }
            else
            {
                $response = DB::select( DB::raw(" SELECT `Code`,`ErrorFound`,`Message`,`version`,`language`,"."'".$APIdata[0]->AlreadyRegisteredUser."'"." as AlreadyRegisteredUser,".$APIdata[0]->ErrorMessage ." as ErrorMessage,".$APIdata[0]->OTP." as OTP, ".$APIdata[0]->OTPExpiryTime." as OTPExpiryTime,".$APIdata[0]->resendOTPAttempts." as resendOTPAttempts,".$APIdata[0]->OTPAttempts." as OTPAttempts,".$APIdata[0]->userLockTiming." as userLockTiming,".$APIdata[0]->CustomerPassword." as CustomerPassword FROM MessageMaster WHERE Code = 'ERR00031' AND language = '$language' ") );
            }

            Log_SMSAPISetupActivityLogs($RequestTime,$phoneNumber,$APIdata[0]->APIID,$APIExecuteResponse[$APIdata[0]->ResponseStatusTag],$APIExecuteResponse[$APIdata[0]->ResponseMessageTag],$APIdata[0]->URL,json_encode($APIExecuteResponse));
        }

        Log_APIActivityLog(
            Route::getFacadeRoot()->current()->uri(),
            $request->method(),
            $response[0]->ErrorFound,
            $response[0]->Code,
            $response[0]->Message,
            $response[0]->version,
            $request->input('source'),
            $request->input("language"),
            $RequestTime,
            json_encode(json_decode($request->instance()->getContent())),
            json_encode($response[0]),
            $response[0]->ErrorMessage,
            $request->input("phoneNumber"),
            '',
            ''

        );
        
        return response()->json($response[0]);
    }
}