// lib/screens/mes_motos_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/moto.dart';
import '../models/model_moto.dart';
import '../providers/moto_provider.dart';
import 'moto_parts_screen.dart';

class MesMotosScreen extends StatefulWidget {
  @override
  _MesMotosScreenState createState() => _MesMotosScreenState();
}

class _MesMotosScreenState extends State<MesMotosScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Charge les motos du client au démarrage
      Provider.of<MotoProvider>(context, listen: false).loadClientMotos();
      Provider.of<MotoProvider>(context, listen: false).loadAvailableModels();
    });
  }

  void _showDeleteConfirmation(Moto moto) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text('Supprimer la moto', style: TextStyle(color: Colors.white)),
        content: Text(
          'Êtes-vous sûr de vouloir supprimer cette moto ?',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Annuler', style: TextStyle(color: Colors.grey)),
          ),
          Consumer<MotoProvider>(
            builder: (context, provider, child) {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: provider.isLoading
                    ? null
                    : () async {
                        final result = await provider.deleteMoto(moto.id);
                        Navigator.pop(context);
                        
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(result['message']),
                            backgroundColor: result['success'] ? Colors.green : Colors.red,
                          ),
                        );
                      },
                child: Text('Supprimer'),
              );
            },
          ),
        ],
      ),
    );
  }

  void _navigateToPartsList(Moto moto) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MotoPartsScreen(moto: moto),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Consumer<MotoProvider>(
        builder: (context, motoProvider, child) {
          if (motoProvider.isLoading) {
            return Center(child: CircularProgressIndicator(color: Colors.red));
          }

          if (motoProvider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, color: Colors.red, size: 48),
                  SizedBox(height: 16),
                  Text(
                    'Erreur: ${motoProvider.error}',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () => motoProvider.loadClientMotos(),
                    child: Text('Réessayer'),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mes Motos',
                  style: TextStyle(
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  'Gérez vos motos pour trouver rapidement des pièces compatibles',
                  style: TextStyle(
                    fontSize: screenWidth * 0.035,
                    color: Colors.grey[400],
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                if (motoProvider.motos.isEmpty)
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.motorcycle,
                          size: screenWidth * 0.3,
                          color: Colors.grey,
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Text(
                          'Vous n\'avez pas encore ajouté de moto',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: motoProvider.motos.length,
                    itemBuilder: (context, index) {
                      // Card for each motorcycle
                      final moto = motoProvider.motos[index];
                      final model = moto.model; // Peut être null
                      final marque = model?.marque ?? 'Inconnu';
                      final annee = model?.annee.toString() ?? 'Année inconnue';
                      
                      return Card(
                        color: Colors.grey[900],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.01,
                          horizontal: screenWidth * 0.02,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(screenWidth * 0.04),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: moto.image != null && moto.image!.isNotEmpty
                                    ? Image.network(
                                        moto.image!,
                                        width: screenWidth * 0.25,
                                        height: screenWidth * 0.25,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Container(
                                            width: screenWidth * 0.25,
                                            height: screenWidth * 0.25,
                                            color: Colors.grey[700],
                                            child: Icon(
                                              Icons.image_not_supported,
                                              color: Colors.grey[500],
                                              size: screenWidth * 0.1,
                                            ),
                                          );
                                        },
                                      )
                                    : Container(
                                        width: screenWidth * 0.25,
                                        height: screenWidth * 0.25,
                                        color: Colors.grey[700],
                                        child: Icon(
                                          Icons.motorcycle,
                                          color: Colors.grey[500],
                                          size: screenWidth * 0.1,
                                        ),
                                      ),
                              ),
                              SizedBox(width: screenWidth * 0.04),
                              // Wrap the text in a Flexible widget so it doesn't force overflow
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '$marque',
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.05,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: screenHeight * 0.005),
                                    Text(
                                      'Année: $annee',
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.04,
                                        color: Colors.grey[400],
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: screenHeight * 0.01),
                                    ElevatedButton.icon(
                                      icon: Icon(Icons.shopping_cart, size: 18),
                                      label: Text('Acheter des pièces'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 8,
                                        ),
                                      ),
                                      onPressed: () => _navigateToPartsList(moto),
                                    ),
                                  ],
                                ),
                              ),
                              // Constrain the PopupMenuButton with a SizedBox
                              SizedBox(
                                width: screenWidth * 0.1,
                                child: PopupMenuButton<String>(
                                  icon: Icon(Icons.more_vert, color: Colors.white),
                                  color: Colors.grey[800],
                                  onSelected: (value) {
                                    if (value == 'parts') {
                                      _navigateToPartsList(moto);
                                    } else if (value == 'delete') {
                                      _showDeleteConfirmation(moto);
                                    }
                                  },
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      value: 'parts',
                                      child: Text(
                                        'Voir les pièces compatibles',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: 'delete',
                                      child: Text(
                                        'Supprimer',
                                        style: TextStyle(color: Colors.red),
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
                  ),
              ],
            ),
          );
        },
      ),
      // Le bouton flottant a été supprimé
    );
  }
}