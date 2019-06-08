<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class SmsController extends Controller
{
    public function sentSMS(Request $request)
    {
        $curl = curl_init();
        $phoneNumber = $request->input("phoneNumber");
        $MessageText = $request->input("MessageText");

        curl_setopt_array($curl, array(
            CURLOPT_URL => "https://www.fast2sms.com/dev/bulk?authorization=QmgTfZYwvXhoLz8l1aH2SUdM6Wpi9rBeVbt0RNsxJA54qGFPj3fRvBXC2LtnDy76JrweVkY8oW3QE4Pa&sender_id=FSTSMS&message=".urlencode($MessageText)."&language=english&route=p&numbers=".urlencode($phoneNumber),
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_ENCODING => "",
            CURLOPT_MAXREDIRS => 10,
            CURLOPT_TIMEOUT => 30,
            CURLOPT_SSL_VERIFYHOST => 0,
            CURLOPT_SSL_VERIFYPEER => 0,
            CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
            CURLOPT_CUSTOMREQUEST => "GET",
            CURLOPT_HTTPHEADER => array("cache-control: no-cache"),
        ));
        
        $response = curl_exec($curl);
        $err = curl_error($curl);
        
        curl_close($curl);
        
        if ($err) {
            return "cURL Error #:" . $err;
        } else {
            return $response;
        }
    }
}
