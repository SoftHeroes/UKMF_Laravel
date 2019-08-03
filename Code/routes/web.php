<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/admin', function () {
    return view('admin');
});

Route::post('/resendOTP', 'login\LoginController@resendOTP');

Route::post('/resetPassword', 'login\LoginController@resetPassword');

Route::get('/forgetPassword/{phoneNumber}', function ($phoneNumber) {
    return view('forgetPassword');
});

Route::get('/search', function () {
    return view('search');
});

Route::get('/viewaccounts', function () {
    return view('viewaccounts');
});

Route::get('/updateaccounts', function () {
    return view('updateaccounts');
});

Route::get('/createaccounts', function () {
    return view('createaccounts');
});
