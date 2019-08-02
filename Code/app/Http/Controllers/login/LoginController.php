<?php

namespace App\Http\Controllers\login;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Route;
use App\Providers\SendOTPProvider;

require_once app_path() . '/Helpers/Logger.php';
require_once app_path() . '/Helpers/basic.php';


class LoginController extends Controller
{
    private $sendOTPProvider;

    public function resendPassword(Request $request)
    {
        return $request->input('otp') . ' ' . $request->input('confirmPassword') . ' ' . $request->input('newPassword');
    }

    public function forgetPassword(Request $request)
    {
        $this->sendOTPProvider = new SendOTPProvider($request);

        return $this->sendOTPProvider->sendOTP($request);
        return redirect()->action('SmsController@sentSMS');
    }

    public function login(Request $request)
    {

        date_default_timezone_set('Asia/Kolkata');
        $RequestTime = substr(date('Y-m-d h:i:s.U', time()), 0, 25);

        $username   = 'NULL';
        $password   = 'NULL';
        $source     = 'NULL';
        $language   = 'NULL';

        if (!isEmpty($request->input("username"))) {
            $username = "'" . trim($request->input("username")) . "'";
        }

        if (!isEmpty($request->input("password"))) {
            $password = "'" . trim($request->input("password")) . "'";
        }

        if (!isEmpty($request->input("source"))) {
            $source = "'" . trim($request->input("source")) . "'";
        }

        if (!isEmpty($request->input("language"))) {
            $language = "'" . trim($request->input("language")) . "'";
        }

        $response =  DB::select("call USP_userLogin(" . $username . "," . $password . "," . $source . "," . $language . ");");

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
            $response[0]->UserPhoneNumber,
            $response[0]->UserEmail,
            'null'
        );

        if ($response[0]->ErrorFound == 'YES') {
            $error = \Illuminate\Validation\ValidationException::withMessages([$response[0]->Message]);
            throw $error;
        } else {
            return view('dashboard');
        }
    }
}
