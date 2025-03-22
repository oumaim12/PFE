<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Commande;
use App\Models\Cart;
use App\Models\CartItem;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;

class CommandeController extends Controller
{
    /**
     * Récupère toutes les commandes du client
     */
    public function getClientCommandes()
    {
        $client = Auth::user();
        
        $commandes = Commande::with(['schema', 'schema.moto', 'schema.moto.model'])
            ->where('client_id', $client->id)
            ->orderBy('created_at', 'desc')
            ->get();
            
        return response()->json([
            'success' => true,
            'commandes' => $commandes
        ]);
    }
    
    /**
     * Récupère les détails d'une commande spécifique
     */
    public function getCommande($id)
    {
        $client = Auth::user();
        
        $commande = Commande::with(['schema', 'schema.moto', 'schema.moto.model'])
            ->where('id', $id)
            ->where('client_id', $client->id)
            ->first();
            
        if (!$commande) {
            return response()->json([
                'success' => false,
                'message' => 'Commande non trouvée ou non autorisée'
            ], 404);
        }
        
        return response()->json([
            'success' => true,
            'commande' => $commande
        ]);
    }
    
    /**
     * Crée une nouvelle commande à partir du panier
     */
    public function createCommandeFromCart()
{
    try {
        $client = Auth::user();
        
        // Récupérer le panier
        $cart = Cart::with('items.schema')
            ->where('client_id', $client->id)
            ->first();
            
        if (!$cart || $cart->items->isEmpty()) {
            return response()->json([
                'success' => false,
                'message' => 'Le panier est vide'
            ], 400);
        }
        
        // Créer une commande pour chaque élément du panier
        $commandes = [];
        
        foreach ($cart->items as $item) {
            $commande = new Commande();
            $commande->client_id = $client->id;
            $commande->schema_id = $item->schema_id;
            $commande->quantite = $item->quantity;
            $commande->total = $item->quantity * ($item->schema ? $item->schema->price : 0);
            $commande->status = 'en_attente';
            $commande->save();
            
            $commandes[] = $commande;
        }
        
        // Vider le panier après création des commandes
        CartItem::where('cart_id', $cart->id)->delete();
        
        return response()->json([
            'success' => true,
            'message' => 'Commandes créées avec succès',
            'commandes' => $commandes
        ], 201);
    } catch (\Exception $e) {
        return response()->json([
            'success' => false,
            'message' => 'Une erreur est survenue',
            'error' => $e->getMessage()
        ], 500);
    }
}
    
    /**
     * Annule une commande
     */
    public function cancelCommande($id)
    {
        $client = Auth::user();
        
        $commande = Commande::where('id', $id)
            ->where('client_id', $client->id)
            ->where('status', 'en_attente')
            ->first();
            
        if (!$commande) {
            return response()->json([
                'success' => false,
                'message' => 'Commande non trouvée, non autorisée ou ne peut plus être annulée'
            ], 404);
        }
        
        $commande->status = 'annulee';
        $commande->save();
        
        return response()->json([
            'success' => true,
            'message' => 'Commande annulée avec succès',
            'commande' => $commande
        ]);
    }
}