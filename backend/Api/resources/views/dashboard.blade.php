<x-app-layout>
   {{--  <!-- Custom CSS -->
    <style>
        :root {
            --primary-color: #d9232d;
            --secondary-color: #6c757d;
            --light-color: #f4f4f4;
            --dark-color: #1a1a1a;
            --dark-bg: #121212;
            --card-bg: #1e1e1e;
            --text-color: #e0e0e0;
            --border-color: #2c2c2c;
            --table-bg: #252525;
            --table-header-bg: #2c2c2c;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--dark-bg);
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
        
        /* Top Navbar */
        .top-navbar {
            background-color: var(--card-bg);
            padding: 15px 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
            border-radius: 8px;
            display: flex;
            justify-content: flex-end;
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
        
        .user-info div {
            color: var(--text-color);
        }
        
        .text-muted {
            color: var(--secondary-color) !important;
        }
        
        /* Cards */
        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s;
            margin-bottom: 20px;
            background-color: var(--card-bg);
            color: var(--text-color);
        }
        
        .card:hover {
            transform: translateY(-5px);
        }
        
        .card-header {
            background-color: var(--card-bg);
            border-bottom: 1px solid var(--border-color);
            padding: 15px 20px;
            font-weight: bold;
            border-radius: 10px 10px 0 0 !important;
            color: var(--text-color);
        }
        
        .card-body {
            padding: 20px;
        }
        
        /* Stats Cards */
        .stats-card {
            background-color: var(--card-bg);
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
            padding: 20px;
            text-align: center;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            transition: all 0.3s;
        }
        
        .stats-card:hover {
            transform: translateY(-5px);
        }
        
        .stats-card .icon {
            width: 60px;
            height: 60px;
            line-height: 60px;
            border-radius: 50%;
            font-size: 24px;
            margin-right: 15px;
            display: inline-block;
            color: white;
        }
        
        .stats-card.primary .icon {
            background-color: var(--primary-color);
        }
        
        .stats-card.success .icon {
            background-color: #28a745;
        }
        
        .stats-card.warning .icon {
            background-color: #ffc107;
        }
        
        .stats-card.info .icon {
            background-color: #17a2b8;
        }
        
        .stats-card .stats-info {
            text-align: left;
            flex-grow: 1;
        }
        
        .stats-card .stats-info h5 {
            margin: 0;
            font-size: 14px;
            color: var(--secondary-color);
        }
        
        .stats-card .stats-info h3 {
            margin: 5px 0 0;
            font-size: 24px;
            font-weight: bold;
            color: var(--text-color);
        }
        
        /* Tables */
        .table {
            width: 100%;
            margin-bottom: 0;
            color: var(--text-color);
        }
        
        .table th {
            font-weight: 600;
            color: var(--text-color);
            border-top: none;
            background-color: var(--table-header-bg);
            border-color: var(--border-color);
        }
        
        .table td, .table th {
            padding: 12px 15px;
            vertical-align: middle;
            border-color: var(--border-color);
        }
        
        .table-hover tbody tr:hover {
            background-color: rgba(255, 255, 255, 0.05);
        }
        
        .table-action-btn {
            width: 30px;
            height: 30px;
            padding: 0;
            line-height: 30px;
            text-align: center;
            border-radius: 50%;
            margin: 0 3px;
        }
        
        /* Status Labels */
        .status {
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }
        
        .status-pending {
            background-color: rgba(255, 193, 7, 0.2);
            color: #ffc107;
        }
        
        .status-confirmed {
            background-color: rgba(23, 162, 184, 0.2);
            color: #17a2b8;
        }
        
        .status-processing {
            background-color: rgba(0, 123, 255, 0.2);
            color: #007bff;
        }
        
        .status-delivered {
            background-color: rgba(40, 167, 69, 0.2);
            color: #28a745;
        }
        
        .status-cancelled {
            background-color: rgba(220, 53, 69, 0.2);
            color: #dc3545;
        }
        
        /* Buttons */
        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }
        
        .btn-primary:hover {
            background-color: #b01c24;
            border-color: #b01c24;
        }
        
        .btn-outline-secondary {
            color: var(--text-color);
            border-color: var(--secondary-color);
        }
        
        .btn-outline-secondary:hover {
            background-color: var(--secondary-color);
            color: var(--text-color);
        }
        
        /* Links */
        a.text-primary {
            color: #2196f3 !important;
        }
        
        a.text-primary:hover {
            color: #0d8aee !important;
        }
        
        /* Badges */
        .badge {
            padding: 5px 8px;
        }
        
        /* Charts */
        canvas {
            filter: invert(0.9) hue-rotate(180deg);
        }
    </style>

    <!-- Main Content -->
    <div class="main-content py-6">
        <!-- Page Content -->
        <div class="container-fluid px-4">
            <div class="row">
                <div class="col-12">
                    <h1 class="mb-4">Tableau de bord</h1>
                </div>
            </div>

            <!-- Stats Cards -->
            <div class="row">
                <div class="col-md-3">
                    <div class="stats-card primary">
                        <div class="icon">
                            <i class="fas fa-cogs"></i>
                        </div>
                        <div class="stats-info">
                            <h5>Total Pièces</h5>
                            <h3>584</h3>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-3">
                    <div class="stats-card success">
                        <div class="icon">
                            <i class="fas fa-users"></i>
                        </div>
                        <div class="stats-info">
                            <h5>Total Clients</h5>
                            <h3>217</h3>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-3">
                    <div class="stats-card warning">
                        <div class="icon">
                            <i class="fas fa-shopping-cart"></i>
                        </div>
                        <div class="stats-info">
                            <h5>Total Commandes</h5>
                            <h3>346</h3>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-3">
                    <div class="stats-card info">
                        <div class="icon">
                            <i class="fas fa-money-bill-wave"></i>
                        </div>
                        <div class="stats-info">
                            <h5>Revenus Totaux</h5>
                            <h3>42 850,25 €</h3>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row mt-4">
                <!-- Sales Chart -->
                <div class="col-md-8">
                    <div class="card">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <span>Ventes des 6 derniers mois</span>
                            <div class="btn-group">
                                <button type="button" class="btn btn-sm btn-outline-secondary">
                                    <i class="fas fa-download"></i> Exporter
                                </button>
                            </div>
                        </div>
                        <div class="card-body">
                            <canvas id="salesChart" height="300"></canvas>
                        </div>
                    </div>
                </div>
                
                <!-- Orders By Status -->
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-header">
                            Commandes par statut
                        </div>
                        <div class="card-body">
                            <canvas id="orderStatusChart" height="300"></canvas>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row mt-4">
                <!-- Recent Orders -->
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <span>Commandes récentes</span>
                            <a href="{{ route('commandes') }}" class="btn btn-sm btn-primary">
                                Voir toutes
                            </a>
                        </div>
                        <div class="card-body p-0">
                            <div class="table-responsive">
                                <table class="table table-hover mb-0">
                                    <thead>
                                        <tr>
                                            <th>Numéro</th>
                                            <th>Client</th>
                                            <th>Montant</th>
                                            <th>Statut</th>
                                            <th>Date</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>
                                                <a href="{{ route('commandes') }}?cmd=CMD-001-2458" class="text-primary fw-bold">
                                                    CMD-001-2458
                                                </a>
                                            </td>
                                            <td>Martin Dupont</td>
                                            <td>258,75 €</td>
                                            <td>
                                                <span class="status status-pending">En attente</span>
                                            </td>
                                            <td>12/03/2023</td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <a href="{{ route('commandes') }}?cmd=CMD-002-1789" class="text-primary fw-bold">
                                                    CMD-002-1789
                                                </a>
                                            </td>
                                            <td>Sophie Lefevre</td>
                                            <td>412,99 €</td>
                                            <td>
                                                <span class="status status-confirmed">Validée</span>
                                            </td>
                                            <td>11/03/2023</td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <a href="{{ route('commandes') }}?cmd=CMD-003-3569" class="text-primary fw-bold">
                                                    CMD-003-3569
                                                </a>
                                            </td>
                                            <td>Jean Moreau</td>
                                            <td>145,50 €</td>
                                            <td>
                                                <span class="status status-delivered">Livrée</span>
                                            </td>
                                            <td>10/03/2023</td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <a href="{{ route('commandes') }}?cmd=CMD-004-7895" class="text-primary fw-bold">
                                                    CMD-004-7895
                                                </a>
                                            </td>
                                            <td>Marie Lambert</td>
                                            <td>78,25 €</td>
                                            <td>
                                                <span class="status status-processing">En cours</span>
                                            </td>
                                            <td>09/03/2023</td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <a href="{{ route('commandes') }}?cmd=CMD-005-4562" class="text-primary fw-bold">
                                                    CMD-005-4562
                                                </a>
                                            </td>
                                            <td>Pierre Durand</td>
                                            <td>325,80 €</td>
                                            <td>
                                                <span class="status status-cancelled">Annulée</span>
                                            </td>
                                            <td>08/03/2023</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                    
                <!-- Popular Products -->
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <span>Produits populaires</span>
                            <a href="{{ route('pieces.detachees') }}" class="btn btn-sm btn-primary">
                                Voir tous
                            </a>
                        </div>
                        <div class="card-body p-0">
                            <div class="table-responsive">
                                <table class="table table-hover mb-0">
                                    <thead>
                                        <tr>
                                            <th>Produit</th>
                                            <th>Référence</th>
                                            <th>Prix</th>
                                            <th>Vendus</th>
                                            <th>Stock</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>
                                                <a href="{{ route('pieces.detachees') }}?ref=PLQ-AV-001" class="text-primary fw-bold">
                                                    Plaquettes de frein avant
                                                </a>
                                            </td>
                                            <td>PLQ-AV-001</td>
                                            <td>45,90 €</td>
                                            <td><span class="badge bg-success">152</span></td>
                                            <td>
                                                <span class="badge bg-success">48</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <a href="{{ route('pieces.detachees') }}?ref=FILT-H-002" class="text-primary fw-bold">
                                                    Filtre à huile
                                                </a>
                                            </td>
                                            <td>FILT-H-002</td>
                                            <td>12,50 €</td>
                                            <td><span class="badge bg-success">138</span></td>
                                            <td>
                                                <span class="badge bg-warning">8</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <a href="{{ route('pieces.detachees') }}?ref=KIT-CH-003" class="text-primary fw-bold">
                                                    Kit chaîne
                                                </a>
                                            </td>
                                            <td>KIT-CH-003</td>
                                            <td>89,99 €</td>
                                            <td><span class="badge bg-success">94</span></td>
                                            <td>
                                                <span class="badge bg-success">26</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <a href="{{ route('pieces.detachees') }}?ref=DSQ-AR-004" class="text-primary fw-bold">
                                                    Disque de frein arrière
                                                </a>
                                            </td>
                                            <td>DSQ-AR-004</td>
                                            <td>75,00 €</td>
                                            <td><span class="badge bg-success">87</span></td>
                                            <td>
                                                <span class="badge bg-danger">0</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <a href="{{ route('pieces.detachees') }}?ref=BAT-12V-005" class="text-primary fw-bold">
                                                    Batterie 12V
                                                </a>
                                            </td>
                                            <td>BAT-12V-005</td>
                                            <td>69,90 €</td>
                                            <td><span class="badge bg-success">76</span></td>
                                            <td>
                                                <span class="badge bg-success">15</span>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.9.1/dist/chart.min.js"></script>
    
    <script>
        $(document).ready(function() {
            // Initialize DataTables
            $('.datatable').DataTable({
                language: {
                    url: '//cdn.datatables.net/plug-ins/1.13.4/i18n/fr-FR.json',
                },
                responsive: true
            });
        });
        
        // Sales Chart
        const salesCtx = document.getElementById('salesChart').getContext('2d');
        const salesChart = new Chart(salesCtx, {
            type: 'line',
            data: {
                labels: ['Oct', 'Nov', 'Déc', 'Jan', 'Fév', 'Mar'],
                datasets: [{
                    label: 'Ventes (€)',
                    data: [6500, 5900, 8000, 8100, 7200, 7500],
                    backgroundColor: 'rgba(217, 35, 45, 0.1)',
                    borderColor: '#d9232d',
                    borderWidth: 3,
                    pointBackgroundColor: '#d9232d',
                    pointBorderColor: '#fff',
                    pointRadius: 4,
                    tension: 0.3,
                    fill: true
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: false
                    },
                    tooltip: {
                        mode: 'index',
                        intersect: false,
                        callbacks: {
                            label: function(context) {
                                let label = context.dataset.label || '';
                                if (label) {
                                    label += ': ';
                                }
                                if (context.parsed.y !== null) {
                                    label += new Intl.NumberFormat('fr-FR', { style: 'currency', currency: 'EUR' }).format(context.parsed.y);
                                }
                                return label;
                            }
                        }
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            callback: function(value) {
                                return value + ' €';
                            }
                        }
                    }
                }
            }
        });

        // Order Status Chart
        const statusCtx = document.getElementById('orderStatusChart').getContext('2d');
        const orderStatusChart = new Chart(statusCtx, {
            type: 'doughnut',
            data: {
                labels: ['En attente', 'Validée', 'En cours', 'Livrée', 'Annulée'],
                datasets: [{
                    data: [42, 85, 68, 120, 31],
                    backgroundColor: [
                        '#ffc107',
                        '#17a2b8',
                        '#007bff',
                        '#28a745',
                        '#dc3545'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                cutout: '65%',
                plugins: {
                    legend: {
                        position: 'bottom'
                    }
                }
            }
        });
    </script> --}}
</x-app-layout> 