<?php

namespace App\Http\Controllers;

use App\Models\Commande;
use App\Models\Client;
use App\Models\Schema;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Carbon\Carbon;

class CommandesController extends Controller
{
    /**
     * Affiche la liste des commandes
     *
     * @return \Illuminate\View\View
     */
    public function index(Request $request)
    {
        $query = Commande::query();

        // Relations à charger
        $query->with(['client', 'schema']);

        // Filtres
        if ($request->filled('client_id')) {
            $query->where('client_id', $request->input('client_id'));
        }

        if ($request->filled('schema_id')) {
            $query->where('schema_id', $request->input('schema_id'));
        }

        if ($request->filled('status')) {
            $query->where('status', $request->input('status'));
        }

        if ($request->filled('date_from')) {
            $query->whereDate('created_at', '>=', $request->input('date_from'));
        }

        if ($request->filled('date_to')) {
            $query->whereDate('created_at', '<=', $request->input('date_to'));
        }

        // Recherche par ID ou client
        if ($request->filled('search')) {
            $search = $request->input('search');
            $query->where(function($q) use ($search) {
                $q->where('id', 'LIKE', "%{$search}%")
                  ->orWhereHas('client', function($query) use ($search) {
                      $query->where('firstname', 'LIKE', "%{$search}%")
                            ->orWhere('lastname', 'LIKE', "%{$search}%")
                            ->orWhere('email', 'LIKE', "%{$search}%")
                            ->orWhere('phone', 'LIKE', "%{$search}%");
                  });
            });
        }

        // Tri
        $sortField = $request->input('sort', 'created_at');
        $sortDirection = $request->input('direction', 'desc');
        $query->orderBy($sortField, $sortDirection);

        // Pagination
        $commandes = $query->paginate(10)->withQueryString();

        // Données pour les filtres
        $clients = Client::orderBy('lastname')->get();
        $schemas = Schema::orderBy('nom')->get();
        $statuses = [
            'en_attente' => 'En attente',
            'en_traitement' => 'En traitement',
            'expediee' => 'Expédiée',
            'livree' => 'Livrée',
            'annulee' => 'Annulée'
        ];

        // Statistiques pour le tableau de bord
        $totalCommandes = Commande::count();
        $commandesEnAttente = Commande::where('status', 'en_attente')->count();
        $commandesEnTraitement = Commande::where('status', 'en_traitement')->count();
        $commandesExpediees = Commande::where('status', 'expediee')->count();
        $commandesLivrees = Commande::where('status', 'livree')->count();
        $commandesAnnulees = Commande::where('status', 'annulee')->count();

        return view('commandes.index', compact(
            'commandes',
            'clients',
            'schemas',
            'statuses',
            'totalCommandes',
            'commandesEnAttente',
            'commandesEnTraitement',
            'commandesExpediees',
            'commandesLivrees',
            'commandesAnnulees'
        ));
    }

    /**
     * Affiche le formulaire de création d'une commande
     *
     * @return \Illuminate\View\View
     */
    public function create()
    {
        $clients = Client::orderBy('lastname')->get();
        $schemas = Schema::orderBy('nom')->get();
        
        $statuses = [
            'en_attente' => 'En attente',
            'en_traitement' => 'En traitement',
            'expediee' => 'Expédiée',
            'livree' => 'Livrée',
            'annulee' => 'Annulée'
        ];

        return view('commandes.create', compact('clients', 'schemas', 'statuses'));
    }

    /**
     * Enregistre une nouvelle commande
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\RedirectResponse
     */
    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'client_id' => 'required|exists:clients,id',
            'schema_id' => 'required|exists:schemas,id',
            'quantite' => 'required|integer|min:1',
            'status' => 'required|in:en_attente,en_traitement,expediee,livree,annulee',
        ]);

        if ($validator->fails()) {
            return redirect()->route('commandes.create')
                ->withErrors($validator)
                ->withInput();
        }

        Commande::create([
            'client_id' => $request->client_id,
            'schema_id' => $request->schema_id,
            'quantite' => $request->quantite,
            'status' => $request->status,
        ]);

        return redirect()->route('commandes.index')
            ->with('success', 'Commande créée avec succès.');
    }

    /**
     * Affiche les détails d'une commande
     *
     * @param  \App\Models\Commande  $commande
     * @return \Illuminate\View\View
     */
    public function show(Commande $commande)
    {
        $commande->load(['client', 'schema']);
        
        // Historique des statuts (à implémenter si vous avez une table pour suivre l'historique)
        // $statusHistory = StatusHistory::where('commande_id', $commande->id)->orderBy('created_at', 'desc')->get();

        return view('commandes.show', compact('commande'));
    }

    /**
     * Affiche le formulaire d'édition d'une commande
     *
     * @param  \App\Models\Commande  $commande
     * @return \Illuminate\View\View
     */
    public function edit(Commande $commande)
    {
        $clients = Client::orderBy('lastname')->get();
        $schemas = Schema::orderBy('nom')->get();
        
        $statuses = [
            'en_attente' => 'En attente',
            'en_traitement' => 'En traitement',
            'expediee' => 'Expédiée',
            'livree' => 'Livrée',
            'annulee' => 'Annulée'
        ];

        return view('commandes.edit', compact('commande', 'clients', 'schemas', 'statuses'));
    }

    /**
     * Met à jour une commande
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Commande  $commande
     * @return \Illuminate\Http\RedirectResponse
     */
    public function update(Request $request, Commande $commande)
    {
        $validator = Validator::make($request->all(), [
            'client_id' => 'required|exists:clients,id',
            'schema_id' => 'required|exists:schemas,id',
            'quantite' => 'required|integer|min:1',
            'status' => 'required|in:en_attente,en_traitement,expediee,livree,annulee',
        ]);

        if ($validator->fails()) {
            return redirect()->route('commandes.edit', $commande->id)
                ->withErrors($validator)
                ->withInput();
        }

        // Vérifier si le statut a changé pour enregistrer l'historique
        $statusChanged = $commande->status !== $request->status;
        $oldStatus = $commande->status;

        $commande->update([
            'client_id' => $request->client_id,
            'schema_id' => $request->schema_id,
            'quantite' => $request->quantite,
            'status' => $request->status,
        ]);

        // Enregistrer l'historique des statuts si implémenté
        // if ($statusChanged) {
        //     StatusHistory::create([
        //         'commande_id' => $commande->id,
        //         'old_status' => $oldStatus,
        //         'new_status' => $request->status,
        //         'user_id' => auth()->id(),
        //         'notes' => $request->status_notes
        //     ]);
        // }

        return redirect()->route('commandes.index')
            ->with('success', 'Commande mise à jour avec succès.');
    }

    /**
     * Supprime une commande
     *
     * @param  \App\Models\Commande  $commande
     * @return \Illuminate\Http\RedirectResponse
     */
    public function destroy(Commande $commande)
    {
        $commande->delete();

        return redirect()->route('commandes.index')
            ->with('success', 'Commande supprimée avec succès.');
    }

    /**
     * Met à jour rapidement le statut d'une commande
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Commande  $commande
     * @return \Illuminate\Http\RedirectResponse
     */
    public function updateStatus(Request $request, Commande $commande)
    {
        $validator = Validator::make($request->all(), [
            'status' => 'required|in:en_attente,en_traitement,expediee,livree,annulee',
        ]);

        if ($validator->fails()) {
            return redirect()->back()
                ->withErrors($validator)
                ->withInput();
        }

        // Vérifier si le statut a changé pour enregistrer l'historique
        $statusChanged = $commande->status !== $request->status;
        $oldStatus = $commande->status;

        $commande->update([
            'status' => $request->status,
        ]);

        // Enregistrer l'historique des statuts si implémenté
        // if ($statusChanged) {
        //     StatusHistory::create([
        //         'commande_id' => $commande->id,
        //         'old_status' => $oldStatus,
        //         'new_status' => $request->status,
        //         'user_id' => auth()->id(),
        //         'notes' => $request->status_notes ?? null
        //     ]);
        // }

        return redirect()->back()
            ->with('success', 'Statut de la commande mis à jour avec succès.');
    }

    /**
     * Exporter les commandes au format CSV
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Symfony\Component\HttpFoundation\StreamedResponse
     */
    public function export(Request $request)
    {
        $headers = array(
            "Content-type" => "text/csv",
            "Content-Disposition" => "attachment; filename=commandes_export_" . date('Y-m-d') . ".csv",
            "Pragma" => "no-cache",
            "Cache-Control" => "must-revalidate, post-check=0, pre-check=0",
            "Expires" => "0"
        );

        // Récupérer les commandes selon les filtres
        $query = Commande::with(['client', 'schema']);

        if ($request->filled('client_id')) {
            $query->where('client_id', $request->input('client_id'));
        }

        if ($request->filled('schema_id')) {
            $query->where('schema_id', $request->input('schema_id'));
        }

        if ($request->filled('status')) {
            $query->where('status', $request->input('status'));
        }

        if ($request->filled('date_from')) {
            $query->whereDate('created_at', '>=', $request->input('date_from'));
        }

        if ($request->filled('date_to')) {
            $query->whereDate('created_at', '<=', $request->input('date_to'));
        }

        $commandes = $query->orderBy('created_at', 'desc')->get();

        $columns = array('ID', 'Client', 'Email', 'Téléphone', 'Pièce', 'Version', 'Quantité', 'Statut', 'Date de commande');

        $callback = function() use ($commandes, $columns) {
            $file = fopen('php://output', 'w');
            fputcsv($file, $columns);

            foreach ($commandes as $commande) {
                $statuts = [
                    'en_attente' => 'En attente',
                    'en_traitement' => 'En traitement',
                    'expediee' => 'Expédiée',
                    'livree' => 'Livrée',
                    'annulee' => 'Annulée'
                ];

                fputcsv($file, [
                    $commande->id,
                    $commande->client->firstname . ' ' . $commande->client->lastname,
                    $commande->client->email,
                    $commande->client->phone,
                    $commande->schema->nom,
                    $commande->schema->version,
                    $commande->quantite,
                    $statuts[$commande->status] ?? $commande->status,
                    $commande->created_at->format('d/m/Y H:i:s')
                ]);
            }
            fclose($file);
        };

        return response()->stream($callback, 200, $headers);
    }

    /**
     * Affiche le tableau de bord des commandes
     *
     * @return \Illuminate\View\View
     */
    public function dashboard()
    {
        // Statistiques des commandes
        $stats = [
            'total' => Commande::count(),
            'en_attente' => Commande::where('status', 'en_attente')->count(),
            'en_traitement' => Commande::where('status', 'en_traitement')->count(),
            'expediees' => Commande::where('status', 'expediee')->count(),
            'livrees' => Commande::where('status', 'livree')->count(),
            'annulees' => Commande::where('status', 'annulee')->count()
        ];

        // Commandes récentes
        $recentesCommandes = Commande::with(['client', 'schema'])
            ->orderBy('created_at', 'desc')
            ->limit(5)
            ->get();

        // Données pour graphique - Commandes par mois
        $commandesParMois = [];
        for ($i = 5; $i >= 0; $i--) {
            $date = Carbon::now()->subMonths($i);
            $count = Commande::whereYear('created_at', $date->year)
                ->whereMonth('created_at', $date->month)
                ->count();
            $commandesParMois[] = [
                'mois' => $date->format('M Y'),
                'nombre' => $count
            ];
        }

        // Top clients
        $topClients = Client::withCount('commandes')
            ->orderBy('commandes_count', 'desc')
            ->limit(5)
            ->get();

        // Top pièces
        $topPieces = Schema::withCount('commandes')
            ->orderBy('commandes_count', 'desc')
            ->limit(5)
            ->get();

        return view('commandes.dashboard', compact(
            'stats',
            'recentesCommandes',
            'commandesParMois',
            'topClients',
            'topPieces'
        ));
    }
}