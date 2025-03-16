<x-app-layout>
    <!-- Custom CSS for Dark Mode -->
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
        
        .form-text {
            color: #999999;
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
        
        .btn-secondary:hover, .btn-secondary:focus {
            background-color: #444444;
            border-color: #444444;
            color: var(--text-color);
        }
        
        /* Form Check (Switch) */
        .form-check-input {
            background-color: var(--input-bg);
            border-color: var(--border-color);
        }
        
        .form-check-input:checked {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }
        
        /* Labels */
        .form-label {
            color: var(--text-color);
        }
        
        /* Breadcrumb in place of sidebar navigation */
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
    </style>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Top Navbar -->
        <div class="top-navbar">
            <div class="page-title">
                <h4 class="mb-0">Administration des pièces détachées</h4>
            </div>
            <div class="user-info">
                <img src="{{ asset('images/avatar.jpg') }}" alt="User Avatar">
                <div>
                    <strong>{{ Auth::user()->name ?? 'Admin Utilisateur' }}</strong>
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
                    <a href="{{ route('products.index') }}" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i> Retour à la liste
                    </a>
                </div>
            </div>

            <div class="card">
                <div class="card-body">
                    <form action="{{ route('products.store') }}" method="POST" enctype="multipart/form-data">
                        @csrf
                        
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
                                    <small class="form-text">Format: JPG, PNG, GIF. Max: 2MB</small>
                                </div>
                                
                                <div class="mb-3">
                                    <div class="card">
                                        <div class="card-header">
                                            Aperçu de l'image
                                        </div>
                                        <div class="card-body text-center">
                                            <img id="image_preview" src="{{ asset('images/no-image.png') }}" alt="Aperçu" class="img-fluid" style="max-height: 200px">
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
                                <a href="{{ route('products.index') }}" class="btn btn-secondary">
                                    <i class="fas fa-times"></i> Annuler
                                </a>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Image Preview Script -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
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
</x-app-layout>