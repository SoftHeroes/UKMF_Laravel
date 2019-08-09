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

    public function resetPassword(Request $request)
    {
        // USP_userPasswordReset

        $phoneNumber     = 'NULL';
        $otp             = 'NULL';
        $newPassword     = 'NULL';
        $confirmPassword = 'NULL';
        $source          = 'NULL';
        $language        = 'NULL';

        if (!isEmpty($request->input("phoneNumber"))) {
            $phoneNumber = "'" . trim($request->input("phoneNumber")) . "'";
        }
        if (!isEmpty($request->input("otp"))) {
            $otp = "'" . trim($request->input("otp")) . "'";
        }
        if (!isEmpty($request->input("newPassword"))) {
            $newPassword = "'" . trim($request->input("newPassword")) . "'";
        }
        if (!isEmpty($request->input("confirmPassword"))) {
            $confirmPassword = "'" . trim($request->input("confirmPassword")) . "'";
        }
        if (!isEmpty($request->input("source"))) {
            $source = "'" . trim($request->input("source")) . "'";
        }
        if (!isEmpty($request->input("language"))) {
            $language = "'" . trim($request->input("language")) . "'";
        }

        $response =  DB::select("call USP_userPasswordReset(" . $phoneNumber . "," . $otp . "," . $newPassword . "," . $confirmPassword . "," . $source . "," . $language . ");");

        if ($response[0]->ErrorFound == "NO") {
            return redirect()->route('adminWithAlert', ['showAlert' => 1]);
        } else {
            $error = \Illuminate\Validation\ValidationException::withMessages([$response[0]->Message]);
            throw $error;
        }
        $error = \Illuminate\Validation\ValidationException::withMessages(['Unable to reset password']);
        throw $error;
    }


    public function resendOTP(Request $request)
    {

        $this->sendOTPProvider = new SendOTPProvider($request);
        $sendSMSResponse = $this->sendOTPProvider->sendSMS($request);

        if ($sendSMSResponse->ErrorFound == 'YES') {
            $error = \Illuminate\Validation\ValidationException::withMessages([$sendSMSResponse->Message]);
            throw $error;
        } else {

            $sendTo = 'NULL';
            $OTP = 'NULL';

            if (!isEmpty($request->input("phoneNumber"))) {
                $sendTo = "'" . trim($request->input("phoneNumber")) . "'";
            }
            if (!isEmpty($sendSMSResponse->OTP)) {
                $OTP = "'" . trim($sendSMSResponse->OTP) . "'";
            }
            $response =  DB::select("call USP_userOTPLogger(" . $sendTo . "," . $OTP . ");");

            if ($response[0]->ErrorFound == "YES") {
                $error = \Illuminate\Validation\ValidationException::withMessages(['Unable to send sms']);
                throw $error;
            } else {
                return redirect()->route(
                    'forgetPassword',
                    [
                        'phoneNumber' => $request->input('phoneNumber'),
                        'source' => $request->input('source'),
                        'templateName' => $request->input('templateName'),
                        'language' => $request->input('language')
                    ]
                );
            }
            $error = \Illuminate\Validation\ValidationException::withMessages(['Unable to send sms']);
            throw $error;
        }
    }

    public function userLogin(Request $request)
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

        $ErrorFound = 'NULL';
        if (!isEmpty($response[0]->ErrorFound)) {
            $ErrorFound = "'" . trim($response[0]->ErrorFound) . "'";
        }

        DB::select("call USP_markLogin(" . $username . "," . $ErrorFound . ");");

        if ($ErrorFound == "'NO'") {
            return redirect()->route('dashboard', ['username' => $response[0]->Username]);
        } else {
            $error = \Illuminate\Validation\ValidationException::withMessages([$response[0]->Message]);
            throw $error;
        }
    }
}
