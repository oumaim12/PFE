<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up()
    {
        Schema::create('orders', function (Blueprint $table) {
            $table->id(); // Auto-incrementing primary key
            $table->foreignId('user_id')->constrained('users')->onDelete('cascade');
            $table->foreignId('motorcycle_id')->constrained('motorcycles')->onDelete('cascade');
            $table->decimal('total_price', 10, 2);
            $table->enum('status', ['En cours', 'Expédiée', 'Livrée', 'Annulée'])->default('En cours');
            $table->enum('payment_method', ['Carte bancaire', 'Mobile Money', 'Cash à la livraison']);
            $table->timestamps(); // Adds created_at & updated_at
        });
    }

    public function down()
    {
        Schema::dropIfExists('orders');
    }
};
