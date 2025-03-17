<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class CommandesController extends Controller
{
    public function index(Request $request)
    {
        return view('commandes.index');
    }

}
