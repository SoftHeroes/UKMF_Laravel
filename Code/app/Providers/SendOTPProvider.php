<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Route;

class SendOTPProvider extends ServiceProvider
{
    /**
     * Register services.
     *
     * @return void
     */
    public function register()
    {
        //
    }

    public function sendOTP($request)
    {
        date_default_timezone_set('Asia/Kolkata');
        $RequestTime = substr(date('Y-m-d h:i:s.U', time()), 0, 25);

        $source = 'NULL';
        $templateName = 'NULL';
        $phoneNumber = 'NULL';
        $language = 'NULL';

        if (!isEmpty($request->input("source"))) {
            $source = "'" . $request->input("source") . "'";
        }
        if (!isEmpty($request->input("templateName"))) {
            $templateName = "'" . $request->input("templateName") . "'";
        }
        if (!isEmpty($request->input("phoneNumber"))) {
            $phoneNumber = "'" . $request->input("phoneNumber") . "'";
        }
        if (!isEmpty($request->input("language"))) {
            $language = "'" . $request->input("language") . "'";
        }

        $APIData =  DB::select("call USP_getSMSURL(" . $source . "," . $templateName . "," . $phoneNumber . "," . $language . ");");


        if ($APIData[0]->ErrorFound == 'YES') {
            $response = array((object) array("Code" => $APIData[0]->Code, "ErrorFound" => $APIData[0]->ErrorFound, "Message" => $APIData[0]->Message, "version" => $APIData[0]->version, "language" => $APIData[0]->language, "ErrorMessage" => $APIData[0]->ErrorMessage));
        } else {
            $APIExecuteResponse = json_decode(APIExecute($APIData[0]->Method, $APIData[0]->URL, null), true);

            if ($APIData[0]->ErrorMessage == null) {
                $APIData[0]->ErrorMessage = 'null';
            }

            if ($APIExecuteResponse[$APIData[0]->ResponseStatusTag] == '200') {
                $response = DB::select(DB::raw(" SELECT `Code`,`ErrorFound`,`Message`,`version`,`language`," . "'" . $APIData[0]->AlreadyRegisteredUser . "'" . " as AlreadyRegisteredUser," . $APIData[0]->ErrorMessage . " as ErrorMessage," . $APIData[0]->OTP . " as OTP FROM MessageMaster WHERE Code = 'ERR00030' AND language = $language"));
            } else {
                $response = DB::select(DB::raw(" SELECT `Code`,`ErrorFound`,`Message`,`version`,`language`," . "'" . $APIData[0]->AlreadyRegisteredUser . "'" . " as AlreadyRegisteredUser," . $APIData[0]->ErrorMessage . " as ErrorMessage," . $APIData[0]->OTP . " as OTP FROM MessageMaster WHERE Code = 'ERR00031' AND language = $language "));
            }

            Log_SMSAPISetupActivityLogs($RequestTime, $phoneNumber, $APIData[0]->APIID, $APIExecuteResponse[$APIData[0]->ResponseStatusTag], $APIExecuteResponse[$APIData[0]->ResponseMessageTag], $APIData[0]->URL, json_encode($APIExecuteResponse));
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

    /**
     * Bootstrap services.
     *
     * @return void
     */
    public function boot()
    {
        //
    }
}
