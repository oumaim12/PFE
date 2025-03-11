<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up()
    {
        Schema::create('motorcycle_parts', function (Blueprint $table) {
            $table->id(); // Auto-incrementing primary key
            $table->foreignId('motorcycle_id')->constrained('motorcycles')->onDelete('cascade');
            $table->foreignId('part_id')->constrained('parts')->onDelete('cascade');
            $table->timestamps(); // Adds created_at & updated_at
        });
    }

    public function down()
    {
        Schema::dropIfExists('motorcycle_parts');
    }
};
