<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Commande extends Model
{
    use HasFactory;

    protected $fillable = [
        'schema_id',
        'quantite',
        'client_id',
        'status',
    ];

    // Relation avec le client
    public function client()
    {
        return $this->belongsTo(Client::class);
    }

    // Relation avec la pièce de rechange
    public function schema()
    {
        return $this->belongsTo(Schema::class);
    }
}