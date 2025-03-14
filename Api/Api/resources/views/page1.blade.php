<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Moto Parts Admin - Dashboard</title>
    
    <!-- Favicon -->
    <link rel="icon" href="assets/images/favicon.ico" type="image/x-icon">
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- DataTables -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap5.min.css">
    
    <!-- Custom CSS -->
    <style>
        :root {
            --primary-color: #d9232d;
            --secondary-color: #333333;
            --light-color: #f4f4f4;
            --dark-color: #1a1a1a;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
            overflow-x: hidden;
        }
        
        /* Sidebar */
        .sidebar {
            position: fixed;
            height: 100%;
            width: 250px;
            background-color: var(--dark-color);
            color: white;
            top: 0;
            left: 0;
            padding-top: 20px;
            transition: all 0.3s;
            z-index: 999;
        }
        
        .sidebar .logo {
            padding: 15px 25px;
            margin-bottom: 20px;
            font-size: 22px;
            font-weight: bold;
            color: white;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }
        
        .sidebar ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        
        .sidebar ul li {
            padding: 0;
        }
        
        .sidebar ul li a {
            padding: 12px 25px;
            color: #cccccc;
            display: block;
            text-decoration: none;
            transition: all 0.3s;
            font-size: 15px;
        }
        
        .sidebar ul li a:hover,
        .sidebar ul li a.active {
            color: white;
            background-color: rgba(255, 255, 255, 0.1);
            border-left: 4px solid var(--primary-color);
        }
        
        .sidebar ul li a i {
            margin-right: 10px;
            width: 20px;
            text-align: center;
        }
        
        /* Main Content */
        .main-content {
            margin-left: 250px;
            padding: 20px;
            min-height: 100vh;
            transition: all 0.3s;
        }
        
        /* Navbar */
        .top-navbar {
            background-color: white;
            padding: 15px 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .menu-toggle {
            display: none;
            color: var(--secondary-color);
            font-size: 24px;
            cursor: pointer;
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
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s;
            margin-bottom: 20px;
        }
        
        .card:hover {
            transform: translateY(-5px);
        }
        
        .card-header {
            background-color: white;
            border-bottom: 1px solid #eee;
            padding: 15px 20px;
            font-weight: bold;
            border-radius: 10px 10px 0 0 !important;
        }
        
        .card-body {
            padding: 20px;
        }
        
        /* Stats Cards */
        .stats-card {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
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
            color: #6c757d;
        }
        
        .stats-card .stats-info h3 {
            margin: 5px 0 0;
            font-size: 24px;
            font-weight: bold;
        }
        
        /* Tables */
        .table {
            width: 100%;
            margin-bottom: 0;
        }
        
        .table th {
            font-weight: 600;
            color: var(--secondary-color);
            border-top: none;
            background-color: #f9f9f9;
        }
        
        .table td, .table th {
            padding: 12px 15px;
            vertical-align: middle;
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
            background-color: #ffeeba;
            color: #856404;
        }
        
        .status-confirmed {
            background-color: #d4edda;
            color: #155724;
        }
        
        .status-processing {
            background-color: #cce5ff;
            color: #004085;
        }
        
        .status-delivered {
            background-color: #c3e6cb;
            color: #155724;
        }
        
        .status-cancelled {
            background-color: #f8d7da;
            color: #721c24;
        }
        
        /* Responsive */
        @media (max-width: 992px) {
            .sidebar {
                left: -250px;
            }
            
            .main-content {
                margin-left: 0;
            }
            
            .sidebar.active {
                left: 0;
            }
            
            .main-content.active {
                margin-left: 250px;
            }
            
            .menu-toggle {
                display: block;
            }
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="logo">
            <i class="fas fa-motorcycle me-2"></i> Moto Parts
        </div>
        <ul>
            <li>
                <a href="index.html" class="active">
                    <i class="fas fa-tachometer-alt"></i> Tableau de bord
                </a>
            </li>
        </ul>
    </div>
    
    <!-- Main Content -->
    <div class="main-content">
        <!-- Top Navbar -->
        <div class="top-navbar">
            <div class="menu-toggle">
                <i class="fas fa-bars"></i>
            </div>
            <div class="user-info">
                <img src="assets/images/avatar.jpg" alt="User Avatar">
                <div>
                    <strong>Admin Utilisateur</strong>
                    <div class="text-muted small">Administrateur</div>
                </div>
            </div>
        </div>
        
        <!-- Page Content -->
        <div class="container-fluid">
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
                            <a href="orders.html" class="btn btn-sm btn-primary">
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
                                                <a href="order-details.html" class="text-primary fw-bold">
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
                                                <a href="order-details.html" class="text-primary fw-bold">
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
                                                <a href="order-details.html" class="text-primary fw-bold">
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
                                                <a href="order-details.html" class="text-primary fw-bold">
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
                                                <a href="order-details.html" class="text-primary fw-bold">
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
                            <a href="products.html" class="btn btn-sm btn-primary">
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
                                                <a href="product-edit.html" class="text-primary fw-bold">
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
                                                <a href="product-edit.html" class="text-primary fw-bold">
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
                                                <a href="product-edit.html" class="text-primary fw-bold">
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
                                                <a href="product-edit.html" class="text-primary fw-bold">
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
                                                <a href="product-edit.html" class="text-primary fw-bold">
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
            // Toggle Sidebar
            $('.menu-toggle').click(function() {
                $('.sidebar').toggleClass('active');
                $('.main-content').toggleClass('active');
            });
            
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
    </script>
</body>
</html>
            <li>
                <a href="products.html">
                    <i class="fas fa-cogs"></i> Pièces détachées
                </a>
            </li>
            <li>
                <a href="categories.html">
                    <i class="fas fa-tags"></i> Catégories
                </a>
            </li>
            <li>
                <a href="orders.html">
                    <i class="fas fa-shopping-cart"></i> Commandes
                </a>
            </li>
            <li>
                <a href="clients.html">
                    <i class="fas fa-users"></i> Clients
                </a>
            </li>
            <li>
                <a href="login.html">
                    <i class="fas fa-sign-out-alt"></i> Déconnexion
                </a>
            </li>