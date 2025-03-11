import 'package:flutter/material.dart';

class MesMotosScreen extends StatefulWidget {
  @override
  _MesMotosScreenState createState() => _MesMotosScreenState();
}

class _MesMotosScreenState extends State<MesMotosScreen> {
  // Liste fictive de motos
  final List<Map<String, dynamic>> _motos = [
    {
      'marque': 'Kawasaki',
      'modele': 'Ninja ZX-10R',
      'annee': '2022',
      'image': 'https://via.placeholder.com/150',
      'pieces_compatibles': 15,
    },
    {
      'marque': 'Honda',
      'modele': 'CBR1000RR',
      'annee': '2021',
      'image': 'https://via.placeholder.com/150',
      'pieces_compatibles': 23,
    },
    {
      'marque': 'Yamaha',
      'modele': 'MT-09',
      'annee': '2023',
      'image': 'https://via.placeholder.com/150',
      'pieces_compatibles': 18,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mes Motos',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Gérez vos motos pour trouver rapidement des pièces compatibles',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[400],
              ),
            ),
            SizedBox(height: 20),
            if (_motos.isEmpty)
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.motorcycle, size: 80, color: Colors.grey),
                    SizedBox(height: 16),
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
                itemCount: _motos.length + 1, // +1 pour la carte d'ajout
                itemBuilder: (context, index) {
                  if (index == _motos.length) {
                    // Carte pour ajouter une nouvelle moto
                    return Card(
                      color: Colors.grey[900],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.red.withOpacity(0.5), width: 1),
                      ),
                      child: InkWell(
                        onTap: () {
                          _showAddMotoDialog();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_circle,
                                size: 50,
                                color: Colors.red,
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Ajouter une moto',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  
                  // Carte pour chaque moto
                  final moto = _motos[index];
                  return Card(
                    color: Colors.grey[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              moto['image'],
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${moto['marque']} ${moto['modele']}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Année: ${moto['annee']}',
                                  style: TextStyle(
                                    color: Colors.grey[400],
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  '${moto['pieces_compatibles']} pièces compatibles',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          PopupMenuButton<String>(
                            icon: Icon(Icons.more_vert, color: Colors.white),
                            color: Colors.grey[800],
                            onSelected: (value) {
                              if (value == 'edit') {
                                _showEditMotoDialog(index);
                              } else if (value == 'delete') {
                                _showDeleteConfirmation(index);
                              } else if (value == 'parts') {
                                _navigateToParts(index);
                              }
                            },
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: 'parts',
                                child: Text('Voir les pièces compatibles', style: TextStyle(color: Colors.white)),
                              ),
                              PopupMenuItem(
                                value: 'edit',
                                child: Text('Modifier', style: TextStyle(color: Colors.white)),
                              ),
                              PopupMenuItem(
                                value: 'delete',
                                child: Text('Supprimer', style: TextStyle(color: Colors.red)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          _showAddMotoDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddMotoDialog() {
    // Implémentation du dialogue d'ajout
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text('Ajouter une moto', style: TextStyle(color: Colors.white)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Marque',
                  labelStyle: TextStyle(color: Colors.grey),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Modèle',
                  labelStyle: TextStyle(color: Colors.grey),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Année',
                  labelStyle: TextStyle(color: Colors.grey),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Annuler', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () {
              // Logique d'ajout de moto ici
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Moto ajoutée avec succès'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: Text('Ajouter'),
          ),
        ],
      ),
    );
  }

  void _showEditMotoDialog(int index) {
    // Implémentation du dialogue de modification
    final moto = _motos[index];
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text('Modifier la moto', style: TextStyle(color: Colors.white)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Marque',
                  labelStyle: TextStyle(color: Colors.grey),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
                style: TextStyle(color: Colors.white),
                controller: TextEditingController(text: moto['marque']),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Modèle',
                  labelStyle: TextStyle(color: Colors.grey),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
                style: TextStyle(color: Colors.white),
                controller: TextEditingController(text: moto['modele']),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Année',
                  labelStyle: TextStyle(color: Colors.grey),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.number,
                controller: TextEditingController(text: moto['annee']),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Annuler', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () {
              // Logique de mise à jour
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Moto mise à jour avec succès'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: Text('Mettre à jour'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(int index) {
    final moto = _motos[index];
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text('Supprimer la moto', style: TextStyle(color: Colors.white)),
        content: Text(
          'Êtes-vous sûr de vouloir supprimer la moto ${moto['marque']} ${moto['modele']} ?',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Annuler', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () {
              // Logique de suppression
              setState(() {
                _motos.removeAt(index);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Moto supprimée avec succès'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: Text('Supprimer'),
          ),
        ],
      ),
    );
  }

  void _navigateToParts(int index) {
    // Implémentation de la navigation vers les pièces compatibles
    final moto = _motos[index];
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Affichage des pièces compatibles pour ${moto['marque']} ${moto['modele']}'),
      ),
    );
  }
}