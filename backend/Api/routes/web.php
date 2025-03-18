<?php

use App\Http\Controllers\ProfileController;
use App\Http\Controllers\DashboardController;
use App\Http\Controllers\PiecesDetacheesController;
use App\Http\Controllers\CommandesController;
use App\Http\Controllers\ClientsController;
use App\Http\Controllers\SchemaController;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});


    Route::get('/dashboard', [\App\Http\Controllers\Admin\DashboardController::class, 'index'])->name('dashboard');
    
    // Routes pour les schemas (pièces détachées)
    Route::resource('schemas', SchemaController::class);
    
    // Routes pour les clients
    Route::resource('clients', ClientsController::class);
    
    // Routes pour les commandes
    Route::resource('commandes', CommandesController::class);


Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
});

require __DIR__.'/auth.php';
