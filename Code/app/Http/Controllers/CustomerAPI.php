<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Route;
use App\Customer;

require_once app_path() . '/Helpers/Logger.php';
require_once app_path() . '/Helpers/basic.php';

class CustomerAPI extends Controller
{
    public function getAll()
    {
        $response = Customer::all();
        return $response;
    }

    public function login(Request $request)
    {
        date_default_timezone_set('Asia/Kolkata');
        $RequestTime = substr(date('Y-m-d h:i:s.U', time()), 0, 25);

        $username = 'NULL';
        $password = 'NULL';
        $source = 'NULL';
        $language = 'NULL';

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


        $response =  DB::select("call USP_login(" . $username . "," . $password . "," . $source . "," . $language . ");");

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
            $response[0]->CustomerPhoneNumber,
            $response[0]->CustomerEmail,
            $response[0]->CustomerUUID
        );

        return response()->json($response[0]);
    }

    public function signup(Request $request)
    {
        date_default_timezone_set('Asia/Kolkata');
        $RequestTime = substr(date('Y-m-d h:i:s.U', time()), 0, 25);

        $password = 'NULL';
        $confirmPassword = 'NULL';
        $firstName = 'NULL';
        $middleName = 'NULL';
        $lastName = 'NULL';
        $emailID = 'NULL';
        $phoneNumber = 'NULL';
        $planID = 'NULL';
        $language = 'NULL';
        $source = 'NULL';

        if (!isEmpty($request->input("password"))) {
            $password = "'" . trim($request->input("password")) . "'";
        }
        if (!isEmpty($request->input("confirmPassword"))) {
            $confirmPassword = "'" . trim($request->input("confirmPassword")) . "'";
        }
        if (!isEmpty($request->input("firstName"))) {
            $firstName = "'" . trim($request->input("firstName")) . "'";
        }
        if (!isEmpty($request->input("middleName"))) {
            $middleName = "'" . trim($request->input("middleName")) . "'";
        }
        if (!isEmpty($request->input("lastName"))) {
            $lastName = "'" . trim($request->input("lastName")) . "'";
        }
        if (!isEmpty($request->input("emailID"))) {
            $emailID = "'" . trim($request->input("emailID")) . "'";
        }
        if (!isEmpty($request->input("phoneNumber"))) {
            $phoneNumber = "'" . trim($request->input("phoneNumber")) . "'";
        }
        if (!isEmpty($request->input("planID"))) {
            $planID = "'" . trim($request->input("planID")) . "'";
        }
        if (!isEmpty($request->input("language"))) {
            $language = "'" . trim($request->input("language")) . "'";
        }
        if (!isEmpty($request->input("source"))) {
            $source = "'" . trim($request->input("source")) . "'";
        }

        $response =  DB::select("call USP_signup   (" . $password . "," . $confirmPassword . "," . $firstName . "," . $middleName . "," . $lastName . "," . $emailID . "," . $phoneNumber . "," . $planID . "," . $language . "," . $source . ");");



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
            $response[0]->CustomerPhoneNumber,
            $response[0]->CustomerEmailID,
            $response[0]->CustomerUUID

        );

        return response()->json($response[0]);
    }
}
