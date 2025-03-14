<?php

use Illuminate\Support\Facades\Route;

Route::get('/page1', function () {
    return view('page1');  // correspond au fichier resources/views/ma-page.blade.php
});
Route::get('/index', function () {
    return view('index');  // correspond au fichier resources/views/ma-page.blade.php
});

Route::get('/product-add', function () {
    return view('product-add');  // correspond au fichier resources/views/ma-page.blade.php
});
Route::get('/orders', function () {
    return view('orders');  // correspond au fichier resources/views/ma-page.blade.php
});

Route::get('/login', function () {
    return view('login');  // correspond au fichier resources/views/ma-page.blade.php
});