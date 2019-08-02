<?php

namespace App\Http\Controllers\login;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Rules\ValideUsername;

class LoginController extends Controller
{

    public function resendPassword(Request $request)
    {
        return $request->input('otp') . ' ' . $request->input('confirmPassword') . ' ' . $request->input('newPassword');
    }

    public function forgetPassword(Request $request)
    {
        $this->validate($request, [
            'phoneNumber' => 'required|min:15|max:35',
        ], [
            'phoneNumber.required' => ' The first name field is required.',
            'phoneNumber.min' => ' The first name must be at least 15 characters.',
            'phoneNumber.max' => ' The first name may not be greater than 35 characters.',
        ]);

        return view('forgetPassword');
    }

    public function login(Request $request)
    {


        return view('dashboard');
    }
}
