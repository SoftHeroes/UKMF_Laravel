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
})->name('admin');

Route::post('/userLogin', 'login\LoginController@userLogin');

Route::post('/resendOTP', 'login\LoginController@resendOTP');

Route::post('/resetPassword', 'login\LoginController@resetPassword');

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

Route::get('/forgetPassword/{phoneNumber}', function ($phoneNumber) {
    return view('forgetPassword', compact('phoneNumber'));
})->name('forgetPassword');

Route::get('/dashboard/{username}', function ($username) {
    return view('dashboard', compact('username'));
})->name('dashboard');
