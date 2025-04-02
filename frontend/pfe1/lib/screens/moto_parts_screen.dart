import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/moto.dart';
import '../models/schema.dart';
import '../services/api_service.dart';
import '../providers/cart_provider.dart';
import '../screens/cart_page.dart';

class MotoPartsScreen extends StatefulWidget {
  final Moto moto;
  final Schema? parentSchema; // Optional parent schema for navigation

  MotoPartsScreen({
    required this.moto,
    this.parentSchema,
  });

  @override
  _MotoPartsScreenState createState() => _MotoPartsScreenState();
}

class _MotoPartsScreenState extends State<MotoPartsScreen> {
  List<Schema> _allSchemas = [];
  List<Schema> _currentLevelSchemas = []; // Schemas to display at current level
  List<Schema> _filteredSchemas = []; // Schemas after filtering
  bool _isLoading = true;
  String? _error;

  // Filter state
  String _searchQuery = '';
  String _sortBy = 'name'; // Default sort by name
  bool _sortAscending = true;

  // Text editing controller for search
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    print("Initializing MotoPartsScreen for moto: ${widget.moto.id}");
    _loadCompatibleSchemas();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadCompatibleSchemas() async {
    print("Loading compatible schemas for moto: ${widget.moto.id}");
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final schemas = await ApiService.getCompatibleSchemas(widget.moto.id);
      
      print("Received ${schemas.length} schemas");
      
      setState(() {
        _allSchemas = schemas;
        
        // Filter schemas based on current navigation level
        if (widget.parentSchema != null) {
          // Show child schemas of the parent
          _currentLevelSchemas = _allSchemas.where(
            (schema) => schema.parentId == widget.parentSchema!.id
          ).toList();
          
          print("Displaying ${_currentLevelSchemas.length} child schemas of parent: ${widget.parentSchema!.nom}");
        } else {
          // Show root schemas (no parent)
          _currentLevelSchemas = _allSchemas.where(
            (schema) => schema.parentId == null
          ).toList();
          
          print("Displaying ${_currentLevelSchemas.length} root schemas");
        }
        
        // Initial filtering and sorting
        _applyFiltersAndSort();
        _isLoading = false;
      });
    } catch (e) {
      print("Error loading schemas: $e");
      setState(() {
        _error = "Erreur lors du chargement des pièces: $e";
        _isLoading = false;
      });
    }
  }

  void _applyFiltersAndSort() {
    // First filter by search query
    if (_searchQuery.isEmpty) {
      _filteredSchemas = List.from(_currentLevelSchemas);
    } else {
      _filteredSchemas = _currentLevelSchemas.where((schema) {
        return schema.nom.toLowerCase().contains(_searchQuery.toLowerCase()) ||
               schema.version.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }

    // Then sort the filtered list
    _filteredSchemas.sort((a, b) {
      int result;
      switch (_sortBy) {
        case 'name':
          result = a.nom.compareTo(b.nom);
          break;
        case 'price':
          result = a.price.compareTo(b.price);
          break;
        case 'version':
          result = a.version.compareTo(b.version);
          break;
        default:
          result = a.nom.compareTo(b.nom);
      }
      return _sortAscending ? result : -result;
    });
  }

  void _navigateToChildSchemas(Schema parentSchema) {
    // Navigate to the same screen but with a parent schema specified
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MotoPartsScreen(
          moto: widget.moto,
          parentSchema: parentSchema,
        ),
      ),
    );
  }

  bool _hasChildSchemas(Schema schema) {
    // Check if the schema has any children
    return _allSchemas.any((s) => s.parentId == schema.id);
  }

  void _addToCart(Schema schema) {
    // Ajout du schéma au panier via le provider
    Provider.of<CartProvider>(context, listen: false).addItem(schema);
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${schema.nom} ajouté au panier"),
        backgroundColor: Colors.green,
        action: SnackBarAction(
          label: "VOIR LE PANIER",
          textColor: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CartPage()),
            );
          },
        ),
      ),
    );
  }

  void _showSortFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Trier et filtrer",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Trier par",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      _buildSortChip('name', 'Nom', setModalState),
                      SizedBox(width: 8),
                      _buildSortChip('price', 'Prix', setModalState),
                      SizedBox(width: 8),
                      _buildSortChip('version', 'Version', setModalState),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Ordre",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      ChoiceChip(
                        label: Text('Croissant'),
                        selected: _sortAscending,
                        onSelected: (selected) {
                          if (selected) {
                            setModalState(() => _sortAscending = true);
                          }
                        },
                        backgroundColor: Colors.grey[800],
                        selectedColor: Colors.red,
                      ),
                      SizedBox(width: 8),
                      ChoiceChip(
                        label: Text('Décroissant'),
                        selected: !_sortAscending,
                        onSelected: (selected) {
                          if (selected) {
                            setModalState(() => _sortAscending = false);
                          }
                        },
                        backgroundColor: Colors.grey[800],
                        selectedColor: Colors.red,
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Annuler',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _applyFiltersAndSort();
                          });
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: Text('Appliquer'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSortChip(String value, String label, StateSetter setModalState) {
    return ChoiceChip(
      label: Text(label),
      selected: _sortBy == value,
      onSelected: (selected) {
        if (selected) {
          setModalState(() => _sortBy = value);
        }
      },
      backgroundColor: Colors.grey[800],
      selectedColor: Colors.red,
    );
  }

  @override
  Widget build(BuildContext context) {
    final modelName = widget.moto.model?.marque ?? 'Moto';
    final modelYear = widget.moto.model?.annee.toString() ?? '';
    
    // Dynamic title based on navigation level
    final title = widget.parentSchema != null 
        ? '${widget.parentSchema!.nom}'
        : 'Pièces pour $modelName $modelYear';
    
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text(title, style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.red),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list, color: Colors.red),
            onPressed: _showSortFilterBottomSheet,
            tooltip: 'Trier et filtrer',
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator(color: Colors.red))
          : _error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, color: Colors.red, size: 48),
                      SizedBox(height: 16),
                      Text(
                        'Erreur: $_error',
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                        onPressed: _loadCompatibleSchemas,
                        child: Text('Réessayer'),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    // Search bar
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        controller: _searchController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Rechercher une pièce...',
                          hintStyle: TextStyle(color: Colors.grey),
                          prefixIcon: Icon(Icons.search, color: Colors.grey),
                          suffixIcon: _searchQuery.isNotEmpty
                              ? IconButton(
                                  icon: Icon(Icons.clear, color: Colors.grey),
                                  onPressed: () {
                                    _searchController.clear();
                                    setState(() {
                                      _searchQuery = '';
                                      _applyFiltersAndSort();
                                    });
                                  },
                                )
                              : null,
                          filled: true,
                          fillColor: Colors.grey[850],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 0),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value;
                            _applyFiltersAndSort();
                          });
                        },
                      ),
                    ),
                    
                    // Breadcrumb for navigation
                    if (widget.parentSchema != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          borderRadius: BorderRadius.circular(4),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              children: [
                                Icon(Icons.arrow_back, color: Colors.red, size: 16),
                                SizedBox(width: 8),
                                Text(
                                  'Revenir au niveau supérieur',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      
                    // Header info
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.parentSchema != null
                                ? 'Composants de ${widget.parentSchema!.nom}'
                                : 'Pièces compatibles',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '${_filteredSchemas.length} résultats',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Empty state
                    if (_currentLevelSchemas.isEmpty)
                      Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.build_circle_outlined, color: Colors.grey, size: 64),
                              SizedBox(height: 16),
                              Text(
                                widget.parentSchema != null
                                    ? 'Aucune pièce dans cette catégorie'
                                    : 'Aucune pièce compatible trouvée',
                                style: TextStyle(color: Colors.white, fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                    // List of schemas
                    if (_currentLevelSchemas.isNotEmpty)
                      Expanded(
                        child: _filteredSchemas.isEmpty
                            ? Center(
                                child: Text(
                                  'Aucun résultat trouvé pour "$_searchQuery"',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              )
                            : ListView.separated(
                                itemCount: _filteredSchemas.length,
                                separatorBuilder: (context, index) => Divider(
                                  color: Colors.grey[800],
                                  height: 1,
                                ),
                                itemBuilder: (context, index) {
                                  final schema = _filteredSchemas[index];
                                  final hasChildren = _hasChildSchemas(schema);
                                  
                                  return ListTile(
                                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    onTap: hasChildren ? () => _navigateToChildSchemas(schema) : null,
                                    title: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            schema.nom,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        if (hasChildren)
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: Colors.blue.withOpacity(0.2),
                                              borderRadius: BorderRadius.circular(12),
                                              border: Border.all(color: Colors.blue, width: 1),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  "Composants",
                                                  style: TextStyle(color: Colors.blue, fontSize: 12),
                                                ),
                                                Icon(Icons.chevron_right, color: Colors.blue, size: 16),
                                              ],
                                            ),
                                          ),
                                      ],
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 4),
                                        Text(
                                          "Version: ${schema.version}",
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          "${schema.price.toStringAsFixed(2)} €",
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    trailing: IconButton(
                                      icon: Icon(Icons.add_shopping_cart, color: Colors.red),
                                      onPressed: () => _addToCart(schema),
                                      tooltip: 'Ajouter au panier',
                                    ),
                                  );
                                },
                              ),
                      ),
                  ],
                ),
    );
  }
}