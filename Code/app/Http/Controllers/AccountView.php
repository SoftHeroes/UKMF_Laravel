<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\DB;

require_once app_path() . '/Helpers/basic.php';
class AccountView extends Controller
{
    public function searchAccount(Request $request)
    {

        $baseResultQuery = "SELECT Code,ErrorFound,Message,version,language FROM MessageMaster WHERE ";

        $FirstName = !isEmpty($request->input("firstName")) ? trim($request->input("firstName")) : 'NULL';
        $MiddleName = !isEmpty($request->input("middleName")) ? trim($request->input("middleName")) : 'NULL';
        $LastName = !isEmpty($request->input("lastName")) ? trim($request->input("lastName")) : 'NULL';
        $EmailAddress = !isEmpty($request->input("emailAddress")) ? trim($request->input("emailAddress")) : 'NULL';
        $PhoneNumber = !isEmpty($request->input("phoneNumber")) ? trim($request->input("phoneNumber")) : 'NULL';
        $PlainId = !isEmpty($request->input("plainId")) ? $request->input("plainId") : 'NULL';
        $UUID = !isEmpty($request->input("UUID")) ? trim($request->input("UUID")) : 'NULL';
        $BatchSize = !isEmpty($request->input("batchSize")) ? $request->input("batchSize") : 'NULL';
        $PageNumber = !isEmpty($request->input("pageNumber")) ?     $request->input("pageNumber") : 'NULL';
        $Source = !isEmpty($request->input("source")) ? trim($request->input("source")) : 'NULL';
        $Language = !isEmpty($request->input("language")) ? trim($request->input("language")) : 'NULL';

        // Language check block : START
        if (isEmpty($Language)) {
            $queryResult =  DB::select($baseResultQuery . " Code = 'ERR00012' AND language = 'English';");
            return response()->json(json_decode("{\"result\" :" . json_encode($queryResult[0]) . ",\"accounts\":null}"));
        }
        $QueryResultSet =  DB::select("select 1 from languageLookup where language = '" . $Language . "' ;");
        if (count($QueryResultSet) == 0) {
            $queryResult =  DB::select($baseResultQuery . " Code = 'ERR00009' AND language = 'English';");
            return response()->json(json_decode("{\"result\" :" . json_encode($queryResult[0]) . ",\"accounts\":null}"));
        }
        // Language check block : END
        if (isEmpty($Source)) {
            $queryResult =  DB::select($baseResultQuery . " Code = 'ERR00022' AND language = '" . $Language . "';");
            return response()->json(json_decode("{\"result\" :" . json_encode($queryResult[0]) . ",\"accounts\":null}"));
        } elseif (isEmpty($BatchSize)) {
            $queryResult =  DB::select($baseResultQuery . " Code = 'ERR00053' AND language = '" . $Language . "';");
            return response()->json(json_decode("{\"result\" :" . json_encode($queryResult[0]) . ",\"accounts\":null}"));
        } elseif (isEmpty($PageNumber)) {
            $queryResult =  DB::select($baseResultQuery . " Code = 'ERR00054' AND language = '" . $Language . "';");
            return response()->json(json_decode("{\"result\" :" . json_encode($queryResult[0]) . ",\"accounts\":null}"));
        } elseif (isEmpty($FirstName) && isEmpty($MiddleName) && isEmpty($LastName) && isEmpty($EmailAddress) && isEmpty($PhoneNumber) && isEmpty($UUID) && isEmpty($PlainId)) {
            $queryResult =  DB::select($baseResultQuery . " Code = 'ERR00057' AND language = '" . $Language . "';");
            return response()->json(json_decode("{\"result\" :" . json_encode($queryResult[0]) . ",\"accounts\":null}"));
        }
        $QueryResultSet =  DB::select(" SELECT 1 FROM lookUp WHERE name = '" . $Source . "' AND category = 'source' AND languageID =  getLanguageID('" . $Language . "' );");
        if (count($QueryResultSet) == 0) {
            $queryResult =  DB::select($baseResultQuery . " Code = 'ERR00033' AND language = '" . $Language . "';");
            return response()->json(json_decode("{\"result\" :" . json_encode($queryResult[0]) . ",\"accounts\":null}"));
        }
        // Input check block : START


        // Input check block : END
        if (!isEmpty($UUID)) {
            $UUID = "'" . $UUID . "'";
        }

        $queryString = "SELECT uniqueID,UUID,firstName, middleName, lastName,emailID, phoneNumber, creationDatetime, lastUpdateDatetime, PlanID, walletAmount, UUID FROM Customer WHERE PlanID = IFNULL(" . $PlainId . ",PlanID) AND UUID = IFNULL(" . $UUID . ",UUID) AND ( ";
        $queryString = $queryString . (isEmpty($FirstName) ? " 1 " : (" firstName LIKE '%" . $FirstName . "%' "));
        $queryString = $queryString . (isEmpty($MiddleName) ? " OR 1 " : ("OR middleName LIKE '%" . $MiddleName . "%' "));
        $queryString = $queryString . (isEmpty($LastName) ? " OR 1 " : ("OR lastName LIKE '%" . $LastName . "%' "));
        $queryString = $queryString . (isEmpty($EmailAddress) ? " OR 1 " : ("OR emailID LIKE '%" . $EmailAddress . "%' "));
        $queryString = $queryString . (isEmpty($PhoneNumber) ? " OR 1 " : ("OR phoneNumber LIKE '%" . $PhoneNumber . "%' )"));
        $queryString = $queryString . ") LIMIT " . $BatchSize . " OFFSET " . (($PageNumber - 1) * $BatchSize) . " ;";

        $queryResult =  DB::select($baseResultQuery . " Code = 'ERR00058' AND language = '" . $Language . "';");
        $queryAccounts =  DB::select($queryString);

        return response()->json(json_decode("{\"result\" :" . json_encode($queryResult[0]) . ",\"accounts\":" . json_encode($queryAccounts) . "}"));
    }
}
