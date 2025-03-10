<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up()
    {
        Schema::create('order_details', function (Blueprint $table) {
            $table->id(); // Auto-incrementing primary key
            $table->foreignId('order_id')->constrained('orders')->onDelete('cascade');
            $table->foreignId('part_id')->constrained('parts')->onDelete('cascade');
            $table->integer('quantity')->default(1);
            $table->decimal('price', 10, 2);
            $table->timestamps(); // Adds created_at & updated_at
        });
    }

    public function down()
    {
        Schema::dropIfExists('order_details');
    }
};
