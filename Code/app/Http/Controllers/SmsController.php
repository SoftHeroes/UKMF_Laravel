<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\MessageMaster;

require_once app_path() . '/Helpers/APICall.php';
require_once app_path() . '/Helpers/Logger.php';

class SmsController extends Controller
{
    public function sentSMS(Request $request)
    {
        $source = $request->input("source");
        $templateName = $request->input("templateName");
        $phoneNumber = $request->input("phoneNumber");
        $language = $request->input("language");

        $APIdata =  DB::select("call USP_getSMSURL('".$source."','".$templateName."','".$phoneNumber."','".$language."');");
        

        if($APIdata[0]->ErrorFound == 'YES')
        {
            $response = array("Code" => $APIdata[0]->Code,"ErrorFound" => $APIdata[0]->ErrorFound,"Message" => $APIdata[0]->Message,"version" => $APIdata[0]->version,"language" => $APIdata[0]->language,"ErrorMessage" => $APIdata[0]->ErrorMessage);
            return response()->json($response);
        }
        else
        {
            $APIExecuteResponse = json_decode(APIExecute($APIdata[0]->Method,$APIdata[0]->URL,null), true);
            
            if( $APIExecuteResponse[$APIdata[0]->ResponseStatusTag] == '200')
            {
                $response = DB::select( DB::raw(" SELECT `Code`,`ErrorFound`,`Message`,`version`,`language`,".$APIdata[0]->OTP." as OTP FROM messagemaster WHERE Code = 'ERR00030' AND language = '$language'") );
            }
            else
            {
                $response = DB::select( DB::raw(" SELECT `Code`,`ErrorFound`,`Message`,`version`,`language`,".$APIdata[0]->OTP." as OTP FROM messagemaster WHERE Code = 'ERR00031' AND language = '$language' ") );
            }
            
            Log_SMSAPISetupActivityLogs($APIdata[0]->APIID,$APIExecuteResponse[$APIdata[0]->ResponseStatusTag],$APIExecuteResponse[$APIdata[0]->ResponseMessageTag],$APIdata[0]->URL,json_encode($APIExecuteResponse));

            return response()->json($response[0]);
        }
    }
}