<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class CommandesController extends Controller
{
    public function index()
    {
        // Return the commandes view (adjust the view path as needed)
        return view('commandes.index');
    }
}
