<?php

namespace App\Http\Controllers\login;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class LoginController extends Controller
{

    public function resendPassword(Request $request)
    {
        return $request->input('otp') . ' ' . $request->input('confirmPassword') . ' ' . $request->input('newPassword');
    }

    public function forgetPassword(Request $request)
    {
        $request->input('phoneNumber');
        return view('forgetPassword');
    }
}
