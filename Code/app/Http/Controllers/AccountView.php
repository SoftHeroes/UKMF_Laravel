<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Providers\accountManagment\searchAccounts;
use Illuminate\Http\Request;
use Illuminate\Validation\ValidationException;

class AccountView extends Controller
{
    private $searchAccountsProvider;

    public function accountSearch(Request $request)
    {
        $this->searchAccountsProvider = new SearchAccounts($request);
        $responseObject = $this->searchAccountsProvider->searchAccount($request);
        if( $responseObject->result->ErrorFound == "YES")
        {
            $error = ValidationException::withMessages([$responseObject->result->Message]);
            throw $error;
        }
        elseif( count($responseObject->accounts) == 0 ){
            $error = ValidationException::withMessages(["No Account found!"]);
            throw $error;
        }
        else{
            return json_encode($responseObject);
        }

        $error = ValidationException::withMessages(["Server not responding"]);
        throw $error;
    }
}
