<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\DB;

class AccountView extends Controller
{
    public function searchAccount(Request $request)
    {
        // $response =  DB::raw("call USP_searchAccount('h',NULL,'Jobanput',NULL,NULL,NULL,NULL,5,1,'Web','English');");
        // $pdo = DB::connection()->getPdo();
        // $pdo->setAttribute(\PDO::ATTR_EMULATE_PREPARES, true);
        // $stmt = $pdo->prepare("call USP_searchAccount('h',NULL,'Jobanput',NULL,NULL,NULL,NULL,5,1,'Web','English');", [\PDO::ATTR_CURSOR => \PDO::CURSOR_SCROLL]);
        // $response = $stmt->execute();
        // $results = [];
        // $results[] = $stmt->fetchAll(\PDO::FETCH_OBJ);
        // return response()->json(results);

        $response =  DB::statement("call USP_searchAccount('h',NULL,'Jobanput',NULL,NULL,NULL,NULL,5,1,'Web','English');");
        return response()->json($response[0]);

        // http://stackoverflow.com/a/28043584
    }
}
