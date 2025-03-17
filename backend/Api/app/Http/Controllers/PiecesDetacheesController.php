<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class PiecesDetacheesController extends Controller
{
    public function index()
    {
        // Return the pieces détachées view (adjust the view path as needed)
        return view('pieces-detachees.index');
    }
    
    public function store()
    {
        return view('pieces-detachees.store');
    }
}
