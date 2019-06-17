<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Route;
use App\Customer;

require_once app_path() . '/Helpers/Logger.php';

class API extends Controller
{
    public function getAll()
    {
        $response = Customer::all();
        return $response;
    }

    public function login(Request $request)
    {
        date_default_timezone_set('Asia/Kolkata');
        $RequestTime = date('Y-m-d h:i:s.U', time());


        $response =  DB::select("call USP_login('".$request->input("username")."',
                                                '".$request->input('password')."',
                                                '".$request->input('source')."',
                                                '".$request->input("language")."');");

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
            $response[0]->ErrorMessage
        );

        return response()->json($response[0]);
    }

    public function signup(Request $request)
    {
        date_default_timezone_set('Asia/Kolkata');
        $RequestTime = date('Y-m-d h:i:s.U', time());

        $response =  DB::select("call USP_signup   ('".$request->input("password")."',
                                                    '".$request->input("confirmPassword")."',
                                                    '".$request->input("firstName")."',
                                                    '".$request->input("middleName")."',
                                                    '".$request->input("lastName")."',
                                                    '".$request->input("emailID")."',
                                                    '".$request->input("phoneNumber")."',
                                                    '".$request->input("planID")."',
                                                    '".$request->input("language")."',
                                                    '".$request->input("source")."');");

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
            $response[0]->ErrorMessage
        );
                            
        return response()->json($response[0]);
    }
}