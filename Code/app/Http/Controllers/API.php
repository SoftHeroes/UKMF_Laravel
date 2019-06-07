<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Customer;

class API extends Controller
{
    public function index()
    {
        $response = Customer::all();
        return $response;
    }
    public function insert(Request $request)
    {
        
        $response =  DB::select("call USP_login('".$request->input("username")."',
                                                '".$request->input('password')."',
                                                '".$request->input("language")."');");
        return $response;
    }
}