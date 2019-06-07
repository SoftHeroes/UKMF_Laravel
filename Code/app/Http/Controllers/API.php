<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Customer;

class API extends Controller
{
    public function getAll()
    {
        $response = Customer::all();
        return $response;
    }

    public function login(Request $request)
    {
        $response =  DB::select("call USP_login('".$request->input("username")."',
                                                '".$request->input('password')."',
                                                '".$request->input("language")."');");
        return $response;
    }

    public function signup(Request $request)
    {

        $response =  DB::select("call USP_signup   ('".$request->input("password")."',
                                                    '".$request->input("confirmPassword")."',
                                                    '".$request->input("firstName")."',
                                                    '".$request->input("middleName")."',
                                                    '".$request->input("lastName")."',
                                                    '".$request->input("emailID")."',
                                                    '".$request->input("phoneNumber")."',
                                                    '".$request->input("planID")."',
                                                    '".$request->input("language")."');");
        return $response;
    }
}