 <x-app-layout>
    {{-- <!-- Custom CSS for Dark Mode -->
    <style>
        :root {
            --primary-color: #d9232d;
            --secondary-color: #555555;
            --light-color: #2c2c2c;
            --dark-color: #1a1a1a;
            --text-color: #e0e0e0;
            --border-color: #444444;
            --input-bg: #333333;
            --card-bg: #2a2a2a;
            --success-color: #28a745;
            --warning-color: #ffc107;
            --danger-color: #dc3545;
            --info-color: #17a2b8;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #1e1e1e;
            color: var(--text-color);
            margin: 0;
            padding: 0;
            overflow-x: hidden;
        }

        /* Main Content */
        .main-content {
            padding: 20px;
            min-height: 100vh;
            transition: all 0.3s;
        }

        /* Top Bar */
        .top-navbar {
            background-color: var(--card-bg);
            padding: 15px 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
            border-radius: 8px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .user-info {
            display: flex;
            align-items: center;
        }

        .user-info img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            margin-right: 10px;
            object-fit: cover;
        }

        /* Cards */
        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
            transition: transform 0.3s;
            margin-bottom: 20px;
            background-color: var(--card-bg);
            color: var(--text-color);
        }

        .card:hover {
            transform: translateY(-5px);
        }

        .card-header {
            background-color: var(--dark-color);
            border-bottom: 1px solid var(--border-color);
            padding: 15px 20px;
            font-weight: bold;
            border-radius: 10px 10px 0 0 !important;
            color: var(--text-color);
        }

        .card-body {
            padding: 20px;
        }

        /* Tables */
        .table {
            color: var(--text-color);
            border-color: var(--border-color);
        }

        .table th {
            border-color: var(--border-color);
            background-color: var(--dark-color);
            color: var(--text-color);
            padding: 12px 15px;
        }

        .table td {
            border-color: var(--border-color);
            padding: 12px 15px;
            vertical-align: middle;
        }

        .table-striped tbody tr:nth-of-type(odd) {
            background-color: rgba(255, 255, 255, 0.05);
        }

        .table-hover tbody tr:hover {
            background-color: rgba(255, 255, 255, 0.075);
        }

        /* Forms */
        .form-control,
        .form-select {
            padding: 10px 15px;
            border-radius: 4px;
            border: 1px solid var(--border-color);
            background-color: var(--input-bg);
            color: var(--text-color);
        }

        .form-control:focus,
        .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(217, 35, 45, 0.25);
            background-color: var(--input-bg);
            color: var(--text-color);
        }

        /* Buttons */
        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }

        .btn-primary:hover,
        .btn-primary:focus {
            background-color: #c41f28;
            border-color: #c41f28;
        }

        .btn-secondary {
            background-color: var(--secondary-color);
            border-color: var(--secondary-color);
            color: var(--text-color);
        }

        .btn-success {
            background-color: var(--success-color);
            border-color: var(--success-color);
        }

        .btn-warning {
            background-color: var(--warning-color);
            border-color: var(--warning-color);
            color: #212529;
        }

        .btn-danger {
            background-color: var(--danger-color);
            border-color: var(--danger-color);
        }

        .btn-info {
            background-color: var(--info-color);
            border-color: var(--info-color);
        }

        /* Badges */
        .badge {
            font-weight: 500;
            padding: 0.5em 0.75em;
            border-radius: 4px;
        }

        .badge-success {
            background-color: var(--success-color);
            color: white;
        }

        .badge-warning {
            background-color: var(--warning-color);
            color: #212529;
        }

        .badge-danger {
            background-color: var(--danger-color);
            color: white;
        }

        .badge-info {
            background-color: var(--info-color);
            color: white;
        }

        .badge-secondary {
            background-color: var(--secondary-color);
            color: white;
        }

        /* Breadcrumb */
        .breadcrumb {
            background-color: var(--card-bg);
            padding: 10px 15px;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        .breadcrumb-item a {
            color: var(--primary-color);
            text-decoration: none;
        }

        .breadcrumb-item.active {
            color: var(--text-color);
        }

        /* Pagination */
        .pagination {
            margin-bottom: 0;
        }

        .page-item .page-link {
            color: var(--primary-color);
            background-color: var(--input-bg);
            border-color: var(--border-color);
        }

        .page-item.active .page-link {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            color: white;
        }

        .page-item.disabled .page-link {
            color: var(--secondary-color);
            background-color: var(--input-bg);
            border-color: var(--border-color);
        }

        /* Search box */
        .search-box {
            position: relative;
        }

        .search-box .btn {
            position: absolute;
            right: 0;
            top: 0;
            height: 100%;
            border-top-left-radius: 0;
            border-bottom-left-radius: 0;
        }
    </style>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Top Navbar -->
        <div class="top-navbar">
            <div class="page-title">
                <h4 class="mb-0">Gestion des Commandes</h4>
            </div>
            <div class="user-info">
                <img src="{{ asset('images/avatar.jpg') }}" alt="User Avatar">
                <div>
                    <strong>{{ Auth::user()->firstname ?? 'Admin Utilisateur' }}</strong>
                    <div class="text-muted small">Administrateur</div>
                </div>
            </div>
        </div>

        <!-- Page Content -->
        <div class="container-fluid">
            <div class="row mb-4">
                <div class="col-md-6">
                    <h1>Liste des Commandes</h1>
                </div>
                <div class="col-md-6 text-md-end">
                    <a href="{{ route('commandes.export') }}" class="btn btn-success">
                        <i class="fas fa-file-excel"></i> Exporter
                    </a>
                </div>
            </div>

            <!-- Filters and Search -->
            <div class="card mb-4">
                <div class="card-body">
                    <form action="{{ route('commandes') }}" method="GET">
                        <div class="row g-3">
                            <div class="col-md-3">
                                <label for="status" class="form-label">Statut</label>
                                <select name="status" id="status" class="form-select">
                                    <option value="">Tous les statuts</option>
                                    <option value="en_attente"
                                        {{ request('status') == 'en_attente' ? 'selected' : '' }}>En attente</option>
                                    <option value="en_traitement"
                                        {{ request('status') == 'en_traitement' ? 'selected' : '' }}>En traitement
                                    </option>
                                    <option value="expedie" {{ request('status') == 'expedie' ? 'selected' : '' }}>
                                        Expédié</option>
                                    <option value="livre" {{ request('status') == 'livre' ? 'selected' : '' }}>Livré
                                    </option>
                                    <option value="annule" {{ request('status') == 'annule' ? 'selected' : '' }}>Annulé
                                    </option>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <label for="date_debut" class="form-label">Date début</label>
                                <input type="date" class="form-control" id="date_debut" name="date_debut"
                                    value="{{ request('date_debut') }}">
                            </div>
                            <div class="col-md-3">
                                <label for="date_fin" class="form-label">Date fin</label>
                                <input type="date" class="form-control" id="date_fin" name="date_fin"
                                    value="{{ request('date_fin') }}">
                            </div>
                            <div class="col-md-3">
                                <label for="search" class="form-label">Recherche</label>
                                <div class="search-box">
                                    <input type="text" class="form-control" id="search" name="search"
                                        placeholder="Référence, client..." value="{{ request('search') }}">
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-search"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Orders Table -->
            <div class="card">
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th>#Référence</th>
                                    <th>Date</th>
                                    <th>Client</th>
                                    <th>Total</th>
                                    <th>Statut</th>
                                    <th>Paiement</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                @forelse($commandes as $commande)
                                    <tr>
                                        <td><strong>{{ $commande->reference }}</strong></td>
                                        <td>{{ $commande->created_at->format('d/m/Y') }}</td>
                                        <td>{{ $commande->client->nom }} {{ $commande->client->prenom }}</td>
                                        <td>{{ number_format($commande->total, 2, ',', ' ') }} €</td>
                                        <td>
                                            @if ($commande->status == 'en_attente')
                                                <span class="badge badge-warning">En attente</span>
                                            @elseif($commande->status == 'en_traitement')
                                                <span class="badge badge-info">En traitement</span>
                                            @elseif($commande->status == 'expedie')
                                                <span class="badge badge-primary">Expédiée</span>
                                            @elseif($commande->status == 'livre')
                                                <span class="badge badge-success">Livrée</span>
                                            @elseif($commande->status == 'annule')
                                                <span class="badge badge-danger">Annulée</span>
                                            @endif
                                        </td>
                                        <td>
                                            @if ($commande->paiement_status == 'paye')
                                                <span class="badge badge-success">Payé</span>
                                            @elseif($commande->paiement_status == 'en_attente')
                                                <span class="badge badge-warning">En attente</span>
                                            @elseif($commande->paiement_status == 'refuse')
                                                <span class="badge badge-danger">Refusé</span>
                                            @endif
                                        </td>
                                        <td>
                                            <div class="btn-group" role="group">
                                                <a href="{{ route('commandes.show', $commande->id) }}"
                                                    class="btn btn-sm btn-info" title="Voir">
                                                    <i class="fas fa-eye"></i>
                                                </a>
                                                <a href="{{ route('commandes.edit', $commande->id) }}"
                                                    class="btn btn-sm btn-primary" title="Modifier">
                                                    <i class="fas fa-edit"></i>
                                                </a>
                                                <button type="button" class="btn btn-sm btn-danger"
                                                    data-bs-toggle="modal"
                                                    data-bs-target="#deleteModal{{ $commande->id }}" title="Supprimer">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </div>

                                            <!-- Delete Modal -->
                                            <div class="modal fade" id="deleteModal{{ $commande->id }}" tabindex="-1"
                                                aria-labelledby="deleteModalLabel{{ $commande->id }}"
                                                aria-hidden="true">
                                                <div class="modal-dialog">
                                                    <div class="modal-content bg-dark text-light">
                                                        <div class="modal-header border-secondary">
                                                            <h5 class="modal-title"
                                                                id="deleteModalLabel{{ $commande->id }}">Confirmation
                                                                de suppression</h5>
                                                            <button type="button" class="btn-close btn-close-white"
                                                                data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            Êtes-vous sûr de vouloir supprimer la commande
                                                            <strong>{{ $commande->reference }}</strong> ?
                                                        </div>
                                                        <div class="modal-footer border-secondary">
                                                            <button type="button" class="btn btn-secondary"
                                                                data-bs-dismiss="modal">Annuler</button>
                                                            <form
                                                                action="{{ route('commandes.destroy', $commande->id) }}"
                                                                method="POST" class="d-inline">
                                                                @csrf
                                                                @method('DELETE')
                                                                <button type="submit"
                                                                    class="btn btn-danger">Supprimer</button>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                @empty
                                    <tr>
                                        <td colspan="7" class="text-center py-4">
                                            <i class="fas fa-inbox fa-3x mb-3 text-muted"></i>
                                            <p>Aucune commande trouvée</p>
                                        </td>
                                    </tr>
                                @endforelse
                            </tbody>
                        </table>
                    </div>

                    <!-- Pagination -->
                    <div class="d-flex justify-content-between align-items-center mt-4">
                        <div>
                            Affichage de {{ $commandes->firstItem() ?? 0 }} à {{ $commandes->lastItem() ?? 0 }} sur
                            {{ $commandes->total() }} commandes
                        </div>
                        <div>
                            {{ $commandes->appends(request()->query())->links() }}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Auto-submit form when status or date changes
            const statusSelect = document.getElementById('status');
            const dateDebut = document.getElementById('date_debut');
            const dateFin = document.getElementById('date_fin');

            statusSelect.addEventListener('change', function() {
                this.form.submit();
            });

            dateDebut.addEventListener('change', function() {
                if (dateFin.value) {
                    this.form.submit();
                }
            });

            dateFin.addEventListener('change', function() {
                if (dateDebut.value) {
                    this.form.submit();
                }
            });
        });
    </script> --}}
</x-app-layout>
