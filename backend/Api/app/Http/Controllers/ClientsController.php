<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class ClientsController extends Controller
{
    public function index()
    {
        // Return the clients view (adjust the view path as needed)
        return view('clients.index');
    }
}
