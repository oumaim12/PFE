<x-app-layout>
    {{--  <!-- Custom CSS for Dark Mode -->
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
        .form-control, .form-select {
            padding: 10px 15px;
            border-radius: 4px;
            border: 1px solid var(--border-color);
            background-color: var(--input-bg);
            color: var(--text-color);
        }
        
        .form-control:focus, .form-select:focus {
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
        
        .btn-primary:hover, .btn-primary:focus {
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
        
        /* Client card */
        .client-stats {
            display: flex;
            justify-content: space-between;
            margin-bottom: 1rem;
        }
        
        .stat-item {
            text-align: center;
            flex: 1;
            padding: 10px;
            border-right: 1px solid var(--border-color);
        }
        
        .stat-item:last-child {
            border-right: none;
        }
        
        .stat-value {
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 0.25rem;
        }
        
        .stat-label {
            font-size: 0.875rem;
            color: #aaaaaa;
        }
        
        /* Modal */
        .modal-content {
            background-color: var(--card-bg);
            color: var(--text-color);
            border-color: var(--border-color);
        }
        
        .modal-header, .modal-footer {
            border-color: var(--border-color);
        }
        
        .btn-close {
            filter: invert(1) grayscale(100%) brightness(200%);
        }
    </style>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Top Navbar -->
        <div class="top-navbar">
            <div class="page-title">
                <h4 class="mb-0">Gestion des Clients</h4>
            </div>
            <div class="user-info">
                <img src="{{ asset('images/avatar.jpg') }}" alt="User Avatar">
                <div>
                    <strong>{{ Auth::user()->name ?? 'Admin Utilisateur' }}</strong>
                    <div class="text-muted small">Administrateur</div>
                </div>
            </div>
        </div>
        
        <!-- Breadcrumb navigation -->
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="{{ route('dashboard') }}"><i class="fas fa-tachometer-alt me-2"></i>Tableau de bord</a></li>
                <li class="breadcrumb-item active" aria-current="page"><i class="fas fa-users me-2"></i>Clients</li>
            </ol>
        </nav>
        
        <!-- Page Content -->
        <div class="container-fluid">
            <!-- Stats Cards -->
            <div class="row mb-4">
                <div class="col-md-3">
                    <div class="card">
                        <div class="card-body">
                            <div class="d-flex align-items-center">
                                <div class="rounded-circle p-3 bg-primary bg-opacity-25 me-3">
                                    <i class="fas fa-users fa-2x text-primary"></i>
                                </div>
                                <div>
                                    <h3 class="mb-0">{{ $total_clients ?? '0' }}</h3>
                                    <div class="text-muted">Total clients</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-3">
                    <div class="card">
                        <div class="card-body">
                            <div class="d-flex align-items-center">
                                <div class="rounded-circle p-3 bg-success bg-opacity-25 me-3">
                                    <i class="fas fa-user-plus fa-2x text-success"></i>
                                </div>
                                <div>
                                    <h3 class="mb-0">{{ $nouveaux_clients ?? '0' }}</h3>
                                    <div class="text-muted">Nouveaux ce mois</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-3">
                    <div class="card">
                        <div class="card-body">
                            <div class="d-flex align-items-center">
                                <div class="rounded-circle p-3 bg-warning bg-opacity-25 me-3">
                                    <i class="fas fa-shopping-cart fa-2x text-warning"></i>
                                </div>
                                <div>
                                    <h3 class="mb-0">{{ $commandes_mois ?? '0' }}</h3>
                                    <div class="text-muted">Commandes ce mois</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-3">
                    <div class="card">
                        <div class="card-body">
                            <div class="d-flex align-items-center">
                                <div class="rounded-circle p-3 bg-info bg-opacity-25 me-3">
                                    <i class="fas fa-euro-sign fa-2x text-info"></i>
                                </div>
                                <div>
                                    <h3 class="mb-0">{{ number_format($ca_moyen ?? 0, 2, ',', ' ') }} €</h3>
                                    <div class="text-muted">Panier moyen</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="row mb-4">
                <div class="col-md-6">
                    <h1>Liste des Clients</h1>
                </div>
                <div class="col-md-6 text-md-end">
                    <a href="{{ route('clients.create') }}" class="btn btn-primary">
                        <i class="fas fa-plus"></i> Nouveau client
                    </a>
                    <a href="{{ route('clients.export') }}" class="btn btn-success ms-2">
                        <i class="fas fa-file-excel"></i> Exporter
                    </a>
                </div>
            </div>
            
            <!-- Filters and Search -->
            <div class="card mb-4">
                <div class="card-body">
                    <form action="{{ route('clients.index') }}" method="GET">
                        <div class="row g-3">
                            <div class="col-md-4">
                                <label for="type" class="form-label">Type</label>
                                <select name="type" id="type" class="form-select">
                                    <option value="">Tous les types</option>
                                    <option value="particulier" {{ request('type') == 'particulier' ? 'selected' : '' }}>Particulier</option>
                                    <option value="professionnel" {{ request('type') == 'professionnel' ? 'selected' : '' }}>Professionnel</option>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <label for="activite" class="form-label">Activité</label>
                                <select name="activite" id="activite" class="form-select">
                                    <option value="">Toutes les activités</option>
                                    <option value="actif" {{ request('activite') == 'actif' ? 'selected' : '' }}>Clients actifs</option>
                                    <option value="inactif" {{ request('activite') == 'inactif' ? 'selected' : '' }}>Clients inactifs</option>
                            </div>
                            <div class="col-md-4">
                                <label for="search" class="form-label">Recherche</label>
                                <div class="search-box">
                                    <input type="text" name="search" id="search" class="form-control" placeholder="Nom, email, téléphone..." value="{{ request('search') }}">
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-search"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            
            <!-- Clients Table -->
            <div class="card">
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover table-striped">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Nom</th>
                                    <th>Email</th>
                                    <th>Téléphone</th>
                                    <th>Type</th>
                                    <th>Statut</th>
                                    <th>Date d'inscription</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                @forelse($clients ?? [] as $client)
                                <tr>
                                    <td>{{ $client->id }}</td>
                                    <td>{{ $client->nom }}</td>
                                    <td>{{ $client->email }}</td>
                                    <td>{{ $client->telephone }}</td>
                                    <td>
                                        <span class="badge {{ $client->type == 'professionnel' ? 'badge-info' : 'badge-secondary' }}">
                                            {{ ucfirst($client->type) }}
                                        </span>
                                    </td>
                                    <td>
                                        <span class="badge {{ $client->actif ? 'badge-success' : 'badge-danger' }}">
                                            {{ $client->actif ? 'Actif' : 'Inactif' }}
                                        </span>
                                    </td>
                                    <td>{{ $client->created_at->format('d/m/Y') }}</td>
                                    <td>
                                        <div class="btn-group" role="group">
                                            <a href="{{ route('clients.show', $client) }}" class="btn btn-sm btn-info" title="Voir">
                                                <i class="fas fa-eye"></i>
                                            </a>
                                            <a href="{{ route('clients.edit', $client) }}" class="btn btn-sm btn-warning" title="Modifier">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <button type="button" class="btn btn-sm btn-danger" data-bs-toggle="modal" data-bs-target="#deleteModal-{{ $client->id }}" title="Supprimer">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </div>
                                        
                                        <!-- Delete Modal -->
                                        <div class="modal fade" id="deleteModal-{{ $client->id }}" tabindex="-1" aria-labelledby="deleteModalLabel-{{ $client->id }}" aria-hidden="true">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="deleteModalLabel-{{ $client->id }}">Confirmation de suppression</h5>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        Êtes-vous sûr de vouloir supprimer le client {{ $client->nom }} ?
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
                                                        <form action="{{ route('clients.destroy', $client) }}" method="POST">
                                                            @csrf
                                                            @method('DELETE')
                                                            <button type="submit" class="btn btn-danger">Supprimer</button>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                @empty
                                <tr>
                                    <td colspan="8" class="text-center">Aucun client trouvé</td>
                                </tr>
                                @endforelse
                            </tbody>
                        </table>
                    </div>
                    
                    <!-- Pagination -->
                    <div class="d-flex justify-content-end mt-3">
                        {{ $clients->links() ?? '' }}
                    </div>
                </div>
            </div>
        </div>
    </div> --}}
</x-app-layout> 