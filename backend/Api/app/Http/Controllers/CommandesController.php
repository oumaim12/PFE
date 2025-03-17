<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class CommandesController extends Controller
{
    public function index(Request $request)
    {
        $query = Commande::with('client'); 

        if ($request->has('status') && $request->status !== '') {
            $query->where('status', $request->status);
        }

        $commandes = $query->orderBy('created_at', 'desc')->paginate(10);

        return view('commandes.index', compact('commandes'));
    }
    
    public function export()
    {
        return Excel::download(new Commandes, 'commandes.xlsx');
    }
}
