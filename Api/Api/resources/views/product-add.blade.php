<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Moto Parts Admin - Ajouter une pièce</title>
    
    <!-- Favicon -->
    <link rel="icon" href="assets/images/favicon.ico" type="image/x-icon">
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
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
        
        /* Forms */
        .form-control {
            padding: 10px 15px;
            border-radius: 4px;
            border: 1px solid #ced4da;
        }
        
        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(217, 35, 45, 0.25);
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
                <a href="index.html">
                    <i class="fas fa-tachometer-alt"></i> Tableau de bord
                </a>
            </li>
            <li>
                <a href="products.html" class="active">
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
            <div class="row mb-4">
                <div class="col-md-6">
                    <h1>Ajouter une pièce détachée</h1>
                </div>
                <div class="col-md-6 text-md-end">
                    <a href="products.html" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i> Retour à la liste
                    </a>
                </div>
            </div>

            <div class="card">
                <div class="card-body">
                    <form action="products.html" method="GET">
                        <div class="row">
                            <div class="col-md-8">
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label for="nom" class="form-label">Nom <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control" id="nom" name="nom" required>
                                    </div>
                                    
                                    <div class="col-md-6">
                                        <label for="reference" class="form-label">Référence <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control" id="reference" name="reference" required>
                                    </div>
                                </div>
                                
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label for="category_id" class="form-label">Catégorie <span class="text-danger">*</span></label>
                                        <select class="form-select" id="category_id" name="category_id" required>
                                            <option value="">Sélectionner une catégorie</option>
                                            <option value="1">Freinage</option>
                                            <option value="2">Filtration</option>
                                            <option value="3">Transmission</option>
                                            <option value="4">Électricité</option>
                                            <option value="5">Lubrifiants</option>
                                            <option value="6">Allumage</option>
                                        </select>
                                    </div>
                                    
                                    <div class="col-md-3">
                                        <label for="prix" class="form-label">Prix (€) <span class="text-danger">*</span></label>
                                        <input type="number" class="form-control" id="prix" name="prix" step="0.01" min="0" required>
                                    </div>
                                    
                                    <div class="col-md-3">
                                        <label for="stock" class="form-label">Stock <span class="text-danger">*</span></label>
                                        <input type="number" class="form-control" id="stock" name="stock" value="0" min="0" required>
                                    </div>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="description" class="form-label">Description</label>
                                    <textarea class="form-control" id="description" name="description" rows="5"></textarea>
                                </div>
                            </div>
                            
                            <div class="col-md-4">
                                <div class="mb-3">
                                    <label for="image" class="form-label">Image</label>
                                    <input type="file" class="form-control" id="image" name="image">
                                    <small class="form-text text-muted">Format: JPG, PNG, GIF. Max: 2MB</small>
                                </div>
                                
                                <div class="mb-3">
                                    <div class="card">
                                        <div class="card-header">
                                            Aperçu de l'image
                                        </div>
                                        <div class="card-body text-center">
                                            <img id="image_preview" src="assets/images/no-image.png" alt="Aperçu" class="img-fluid" style="max-height: 200px">
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="mb-3">
                                    <div class="form-check form-switch">
                                        <input class="form-check-input" type="checkbox" id="actif" name="actif" value="1" checked>
                                        <label class="form-check-label" for="actif">Produit actif</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="row mt-4">
                            <div class="col-12 text-center">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save"></i> Enregistrer
                                </button>
                                <a href="products.html" class="btn btn-secondary">
                                    <i class="fas fa-times"></i> Annuler
                                </a>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        $(document).ready(function() {
            // Toggle Sidebar
            $('.menu-toggle').click(function() {
                $('.sidebar').toggleClass('active');
                $('.main-content').toggleClass('active');
            });
            
            // Afficher l'aperçu de l'image
            document.getElementById('image').onchange = function (evt) {
                var tgt = evt.target || window.event.srcElement,
                    files = tgt.files;
                
                if (FileReader && files && files.length) {
                    var fr = new FileReader();
                    fr.onload = function () {
                        document.getElementById('image_preview').src = fr.result;
                    }
                    fr.readAsDataURL(files[0]);
                }
            }
        });
    </script>
</body>
</html>