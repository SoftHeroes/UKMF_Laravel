<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Providers\SendOTPProvider;


class SmsController extends Controller
{
    private $sendOTPProvider;

    public function sentSMS(Request $request)
    {
        $this->sendOTPProvider = new SendOTPProvider($request);

        return response()->json($this->sendOTPProvider->sendSMS($request));
    }
}
