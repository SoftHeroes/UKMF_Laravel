<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Providers\SendOTPProvider;

require_once app_path() . '/Helpers/APICall.php';
require_once app_path() . '/Helpers/Logger.php';
require_once app_path() . '/Helpers/Maths.php';
require_once app_path() . '/Helpers/basic.php';

class SmsController extends Controller
{
    private $sendOTPProvider;

    public function sentSMS(Request $request)
    {
        $this->sendOTPProvider = new SendOTPProvider($request);

        return $this->sendOTPProvider->sendOTP($request);
    }
}
