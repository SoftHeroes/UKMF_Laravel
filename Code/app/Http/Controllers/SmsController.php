<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
require_once app_path() . '/Helpers/API/APICall.php';

class SmsController extends Controller
{
    public function sentSMS(Request $request)
    {
        $source = $request->input("source");
        $templateName = $request->input("templateName");
        $phoneNumber = $request->input("phoneNumber");
        $language = $request->input("language");

        $APIdata =  DB::select("call USP_getSMSURL('".$source."','".$templateName."','".$phoneNumber."','".$language."');");
        

        $response = APIExecute($APIdata[0]->Method,$APIdata[0]->URL,null);

        return response()->json(json_decode($response));
    }
}