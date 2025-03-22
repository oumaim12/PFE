<?php

namespace App\Http\Controllers\Api;

use App\Models\Commande;
use App\Models\Schema;
use App\Models\Client;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Http\Controllers\Controller;

class CommandeController extends Controller
{
    /**
     * Creer une nouvelle commande.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function createCommande(Request $request)
    {
        // Validation des données
        $validator = Validator::make($request->all(), [
            'schema_id' => 'required|exists:schemas,id',
            'quantite' => 'required|integer|min:1',
            'client_id' => 'required|exists:clients,id',
        ]);
        
        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'message' => 'Erreur de validation',
                'errors' => $validator->errors()
            ], 422);
        }
       

        $schema = Schema::find($request->schema_id);
        if (!$schema) {
            return response()->json([
                'success' => false,
                'message' => 'Schéma non trouvé'
            ], 404);
        }
        
        
        $commande = new Commande();
        $commande->schema_id = $request->schema_id;
        $commande->quantite = $request->quantite;
        $commande->total = $schema->prix; 
        $commande->client_id = $request->client_id;
        
        $commande->save();
        
        return response()->json([
            'success' => true,
            'message' => 'Commande créée avec succès',
            'data' => $commande
        ], 201);
    }
}