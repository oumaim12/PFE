<?php

use App\Http\Controllers\ProfileController;
use App\Http\Controllers\DashboardController;
use App\Http\Controllers\PiecesDetacheesController;
use App\Http\Controllers\CommandesController;
use App\Http\Controllers\ClientsController;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});

Route::middleware(['auth'])->group(function () {

    Route::get('/dashboard', [DashboardController::class, 'index'])->name('dashboard');
    
    Route::get('/pieces-detachees', [PiecesDetacheesController::class, 'index'])->name('pieces.detachees');
    Route::post('/pieces-detachees', [PiecesDetacheesController::class, 'store'])->name('pieces.detachees.store');

    Route::get('/commandes', [CommandesController::class, 'index'])->name('commandes.index');
    Route::get('/commandes/export', [CommandeExportController::class, 'export'])->name('commandes.export');

    Route::get('/clients', [ClientsController::class, 'index'])->name('clients');

});

Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
});

require __DIR__.'/auth.php';
