// lib/screens/moto_parts_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/moto.dart';
import '../models/schema.dart';
// import '../models/cart_item.dart';
import '../services/api_service.dart';
import '../providers/cart_provider.dart';
import '../screens/cart_page.dart';

class MotoPartsScreen extends StatefulWidget {
  final Moto moto;

  MotoPartsScreen({required this.moto});

  @override
  _MotoPartsScreenState createState() => _MotoPartsScreenState();
}

class _MotoPartsScreenState extends State<MotoPartsScreen> {
  List<Schema> _compatibleSchemas = [];
  bool _isLoading = true;
  String? _error;

  // Dans la méthode initState de MotoPartsScreen
@override
void initState() {
  super.initState();
  print("Initializing MotoPartsScreen for moto: ${widget.moto.id}");
  _loadCompatibleSchemas();
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
    for (var schema in schemas) {
      print("Schema: ${schema.id} - ${schema.nom}");
    }
    
    setState(() {
      _compatibleSchemas = schemas;
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

  @override
  Widget build(BuildContext context) {
    // final screenWidth = MediaQuery.of(context).size.width;
    final modelName = widget.moto.model?.marque ?? 'Moto';
    final modelYear = widget.moto.model?.annee.toString() ?? '';
    
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text('Pièces pour $modelName $modelYear', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.red),
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
              : _compatibleSchemas.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.build_circle_outlined, color: Colors.grey, size: 64),
                          SizedBox(height: 16),
                          Text(
                            'Aucune pièce compatible trouvée',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ],
                      ),
                    )
                  : CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Pièces compatibles',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Ces pièces sont garanties compatibles avec votre ${widget.moto.model?.marque ?? "moto"}',
                                  style: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SliverPadding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final schema = _compatibleSchemas[index];
                                return Card(
                                  color: Colors.grey[900],
                                  margin: EdgeInsets.only(bottom: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Image du schéma (si disponible)
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(8),
                                          child: schema.moto?.image != null 
                                              ? Image.network(
                                                  schema.moto!.image!,
                                                  width: 100,
                                                  height: 100,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error, stackTrace) {
                                                    return Container(
                                                      width: 100,
                                                      height: 100,
                                                      color: Colors.grey[800],
                                                      child: Icon(
                                                        Icons.image_not_supported,
                                                        color: Colors.grey[500],
                                                      ),
                                                    );
                                                  },
                                                )
                                              : Container(
                                                  width: 100,
                                                  height: 100,
                                                  color: Colors.grey[800],
                                                  child: Icon(
                                                    Icons.build,
                                                    color: Colors.grey[500],
                                                  ),
                                                ),
                                        ),
                                        SizedBox(width: 12),
                                        // Détails du schéma
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                schema.nom,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(height: 4),
                                              Text(
                                                "Version: ${schema.version}",
                                                style: TextStyle(
                                                  color: Colors.grey[400],
                                                  fontSize: 14,
                                                ),
                                              ),
                                              SizedBox(height: 8),
                                              Text(
                                                "Prix: ${schema.price.toStringAsFixed(2)} €",
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(height: 8),
                                              ElevatedButton.icon(
                                                onPressed: () => _addToCart(schema),
                                                icon: Icon(Icons.add_shopping_cart, size: 16),
                                                label: Text('Ajouter au panier'),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.red,
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 8,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              childCount: _compatibleSchemas.length,
                            ),
                          ),
                        ),
                      ],
                    ),
    );
  }
}