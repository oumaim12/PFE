<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

// Modèle pour les pièces de rechange (Schema)
class Schema extends Model
{
    use HasFactory;

    protected $fillable = [
        'nom',
        'parent_id',
        'version',
    ];

    // Relation avec la pièce parente
    public function parent()
    {
        return $this->belongsTo(Schema::class, 'parent_id');
    }

    // Relation avec les pièces enfants
    public function enfants()
    {
        return $this->hasMany(Schema::class, 'parent_id');
    }

    // Relation avec les commandes
    public function commandes()
    {
        return $this->hasMany(Commande::class);
    }
}