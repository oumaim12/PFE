import 'package:flutter/material.dart';

class MesMotosScreen extends StatefulWidget {
  @override
  _MesMotosScreenState createState() => _MesMotosScreenState();
}

class _MesMotosScreenState extends State<MesMotosScreen> {
  // Ajouter cette variable pour stocker le contexte global
  late BuildContext _scaffoldContext;
  
  // Liste fictive de motos reste inchangée
  final List<Map<String, dynamic>> _motos = [
    {
      'marque': 'Kawasaki',
      'modele': 'Ninja ZX-10R',
      'annee': '2022',
      'image': 'assets/images/Moto.jpg',
      'pieces_compatibles': 15,
    },
    {
      'marque': 'Honda',
      'modele': 'CBR1000RR',
      'annee': '2021',
      'image': 'assets/images/Moto.jpg',
      'pieces_compatibles': 23,
    },
    {
      'marque': 'Yamaha',
      'modele': 'MT-09',
      'annee': '2023',
      'image': 'assets/images/Moto.jpg',
      'pieces_compatibles': 18,
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
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
            if (_motos.isEmpty)
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
                itemCount: _motos.length + 1, // +1 for the add card
                itemBuilder: (context, index) {
                  if (index == _motos.length) {
                    // Card for adding a new motorcycle
                    return Card(
                      color: Colors.grey[900],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color: Colors.red.withOpacity(0.5),
                          width: 1,
                        ),
                      ),
                      margin: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.01,
                        horizontal: screenWidth * 0.02,
                      ),
                      child: InkWell(
                        onTap: () {
                          _showAddMotoDialog();
                        },
                        child: Padding(
                          padding: EdgeInsets.all(screenWidth * 0.04),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_circle,
                                size: screenWidth * 0.13,
                                color: Colors.red,
                              ),
                              SizedBox(height: screenHeight * 0.01),
                              Text(
                                'Ajouter une moto',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenWidth * 0.04,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }

                  // Card for each motorcycle
                  final moto = _motos[index];
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
                            child: Image.asset(
                              moto['image'],
                              width: screenWidth * 0.25,
                              height: screenWidth * 0.25,
                              fit: BoxFit.cover,
                            ),
                                  
                          ),
                          SizedBox(width: screenWidth * 0.04),
                          // Wrap the text in a Flexible widget so it doesn't force overflow
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${moto['marque']} ${moto['modele']}',
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
                                  'Année: ${moto['annee']}',
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.04,
                                    color: Colors.grey[400],
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: screenHeight * 0.01),
                                Text(
                                  '${moto['pieces_compatibles']} pièces compatibles',
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.04,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
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
                                  child: Text(
                                    'Voir les pièces compatibles',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                PopupMenuItem(
                                  value: 'edit',
                                  child: Text(
                                    'Modifier',
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
    // Implementation for adding a motorcycle
    showDialog(
      context: _scaffoldContext,
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
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(context);
              // Utiliser _scaffoldContext pour accéder au ScaffoldMessenger
              ScaffoldMessenger.of(_scaffoldContext).showSnackBar(
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
    final moto = _motos[index];
    showDialog(
      context: _scaffoldContext,
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
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(context);
              // Utiliser _scaffoldContext pour accéder au ScaffoldMessenger
              ScaffoldMessenger.of(_scaffoldContext).showSnackBar(
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
      context: _scaffoldContext,
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
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              setState(() {
                _motos.removeAt(index);
              });
              Navigator.pop(context);
              // Utiliser _scaffoldContext pour accéder au ScaffoldMessenger
              ScaffoldMessenger.of(_scaffoldContext).showSnackBar(
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
    final moto = _motos[index];
    // Utiliser _scaffoldContext pour accéder au ScaffoldMessenger
    ScaffoldMessenger.of(_scaffoldContext).showSnackBar(
      SnackBar(
        content: Text(
          'Affichage des pièces compatibles pour ${moto['marque']} ${moto['modele']}',
        ),
      ),
    );
  }
}