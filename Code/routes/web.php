<?php
/*
|--------------------------------------------------------------------------
| Dashboard View Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your Dashboard.
|
*/
Route::get('/dashboard/{username}', function ($username) {
    return view('dashboard', compact('username'));
})->name('dashboard');


/*
|--------------------------------------------------------------------------
| Admin View
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your Admin.
|
*/
Route::get('/admin', function () {
    return redirect()->route('adminWithAlert', ['showAlert' => 0]);
})->name('admin');

Route::get('/adminLogin/{showAlert}', function ($showAlert) {
    return view('admin', compact('showAlert'));
})->name('adminWithAlert');

// Admin Logic View routes : START
Route::post('/userLogin', 'login\LoginController@userLogin');
// Admin Logic View routes : END


/*
|--------------------------------------------------------------------------
| Forget Password View
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your Forget Password.
|
*/
Route::get('/forgetPassword/{phoneNumber}/{source}/{templateName}/{language}', function ($phoneNumber, $source, $templateName, $language) {
    return view('forgetPassword', compact('phoneNumber', 'source', 'templateName', 'language'));
})->name('forgetPassword');

// Forget Password View routes : START
Route::get('/resendOTP', 'login\LoginController@resendOTP')->name('resendOTP');
Route::post('/resetPassword', 'login\LoginController@resetPassword');
// Forget Password View routes : END


/*
|--------------------------------------------------------------------------
| Account Managment View
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your Account Managment.
|
*/
Route::get('/viewAccounts', function () {
    return view('accountManagment/viewAccounts');
})->name('vViewAccounts');

Route::get('/updateAccounts', function () {
    return view('accountManagment/updateAccounts');
})->name('vUpdateAccounts');

Route::get('/createAccounts', function () {
    return view('accountManagment/createAccounts');
})->name('vCreateAccounts');

Route::get('/searchAccounts', function () {
    return view('accountManagment/searchAccounts');
})->name('vSearchAccounts');

// Account Managment Logic View routes : START
Route::post('/accountSearch', 'AccountView@accountSearch')->name('accountSearch');
// Account Managment Logic View routes : END
