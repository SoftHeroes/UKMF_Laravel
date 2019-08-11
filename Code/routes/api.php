<?php

use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});

Route::get("/GetAllCustomers", "CustomerAPI@getAll");
Route::post("/LoginCustomer", "CustomerAPI@login");
Route::post("/SignupCustomer", "CustomerAPI@signup");
Route::post('/send-sms', "SmsController@sentSMS");
Route::post('/SearchAccount', 'AccountView@searchAccount');
