import 'package:flutter/material.dart';

class MesCommandesScreen extends StatefulWidget {
  @override
  _MesCommandesScreenState createState() => _MesCommandesScreenState();
}

class _MesCommandesScreenState extends State<MesCommandesScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  // Liste fictive de commandes
  final List<Map<String, dynamic>> _commandes = [
    {
      'id': 'CMD-2025-001',
      'date': '05/03/2025',
      'montant': 359.99,
      'status': 'En livraison',
      'items': [
        {'nom': 'Kit chaîne', 'quantite': 1, 'prix': 159.99},
        {'nom': 'Plaquettes de frein avant', 'quantite': 2, 'prix': 100.00},
      ],
      'tracking': 'LT78945612',
      'estimatedDelivery': '12/03/2025',
    },
    {
      'id': 'CMD-2025-002',
      'date': '20/02/2025',
      'montant': 199.50,
      'status': 'Livré',
      'items': [
        {'nom': 'Huile moteur', 'quantite': 3, 'prix': 89.50},
        {'nom': 'Filtre à huile', 'quantite': 1, 'prix': 20.00},
        {'nom': 'Filtre à air', 'quantite': 1, 'prix': 90.00},
      ],
      'tracking': 'LT78945123',
      'deliveryDate': '28/02/2025',
    },
    {
      'id': 'CMD-2025-003',
      'date': '10/02/2025',
      'montant': 599.99,
      'status': 'Annulé',
      'items': [
        {'nom': 'Échappement', 'quantite': 1, 'prix': 599.99},
      ],
      'cancellationReason': 'Produit non compatible',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // En-tête avec onglets
          Container(
            color: Colors.grey[900],
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Mes Commandes',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                TabBar(
                  controller: _tabController,
                  indicatorColor: Colors.red,
                  labelColor: Colors.red,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(text: 'Toutes'),
                    Tab(text: 'En cours'),
                    Tab(text: 'Livrées'),
                  ],
                ),
              ],
            ),
          ),
          
          // Contenu des onglets
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildOrdersList(_commandes),
                _buildOrdersList(_commandes.where((cmd) => cmd['status'] == 'En livraison' || cmd['status'] == 'En préparation').toList()),
                _buildOrdersList(_commandes.where((cmd) => cmd['status'] == 'Livré').toList()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersList(List<Map<String, dynamic>> commandes) {
    if (commandes.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.receipt_long, size: 80, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Aucune commande dans cette catégorie',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: commandes.length,
      itemBuilder: (context, index) {
        final commande = commandes[index];
        return Card(
          color: Colors.grey[900],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.only(bottom: 16),
          child: ExpansionTile(
            tilePadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            title: Text(
              'Commande #${commande['id']}',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 4),
                Text(
                  'Date: ${commande['date']}',
                  style: TextStyle(color: Colors.grey[400]),
                ),
                SizedBox(height: 4),
                Text(
                  'Montant: ${commande['montant'].toStringAsFixed(2)} €',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 4),
                _buildStatusChip(commande['status']),
              ],
            ),
            iconColor: Colors.red,
            collapsedIconColor: Colors.red,
            children: [
              Divider(color: Colors.grey[800]),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Détails de la commande',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    ...commande['items'].map<Widget>((item) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                '${item['nom']} x${item['quantite']}',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Text(
                              '${item['prix'].toStringAsFixed(2)} €',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    Divider(color: Colors.grey[800]),
                    SizedBox(height: 8),
                    _buildTrackingInfo(commande),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (commande['status'] != 'Annulé')
                          ElevatedButton.icon(
                            icon: Icon(Icons.receipt),
                            label: Text('Facture'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[800],
                            ),
                            onPressed: () {
                              // Action pour afficher la facture
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Facture en téléchargement')),
                              );
                            },
                          ),
                        SizedBox(width: 8),
                        if (commande['status'] == 'En livraison')
                          ElevatedButton.icon(
                            icon: Icon(Icons.location_on),
                            label: Text('Suivre'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            onPressed: () {
                              // Action pour suivre la livraison
                              _showTrackingDialog(commande);
                            },
                          ),
                        if (commande['status'] == 'En préparation')
                          ElevatedButton.icon(
                            icon: Icon(Icons.cancel),
                            label: Text('Annuler'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            onPressed: () {
                              // Action pour annuler la commande
                              _showCancelDialog(commande);
                            },
                          ),
                        if (commande['status'] == 'Livré')
                          ElevatedButton.icon(
                            icon: Icon(Icons.star),
                            label: Text('Évaluer'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber,
                            ),
                            onPressed: () {
                              // Action pour évaluer les produits
                              _showRateProductsDialog(commande);
                            },
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatusChip(String status) {
    Color bgColor;
    IconData icon;

    switch (status) {
      case 'En préparation':
        bgColor = Colors.blue;
        icon = Icons.pending;
        break;
      case 'En livraison':
        bgColor = Colors.orange;
        icon = Icons.local_shipping;
        break;
      case 'Livré':
        bgColor = Colors.green;
        icon = Icons.check_circle;
        break;
      case 'Annulé':
        bgColor = Colors.red;
        icon = Icons.cancel;
        break;
      default:
        bgColor = Colors.purple;
        icon = Icons.help;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: bgColor, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: bgColor),
          SizedBox(width: 4),
          Text(
            status,
            style: TextStyle(color: bgColor, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildTrackingInfo(Map<String, dynamic> commande) {
    switch (commande['status']) {
      case 'En livraison':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Informations de livraison',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.local_shipping, color: Colors.orange, size: 18),
                SizedBox(width: 8),
                Text(
                  'Numéro de suivi : ${commande['tracking']}',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.date_range, color: Colors.orange, size: 18),
                SizedBox(width: 8),
                Text(
                  'Livraison estimée : ${commande['estimatedDelivery']}',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ],
        );
      case 'Livré':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Informations de livraison',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 18),
                SizedBox(width: 8),
                Text(
                  'Livré le : ${commande['deliveryDate']}',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ],
        );
      case 'Annulé':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Raison d\'annulation',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.cancel, color: Colors.red, size: 18),
                SizedBox(width: 8),
                Text(
                  commande['cancellationReason'],
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ],
        );
      default:
        return SizedBox.shrink();
    }
  }

  void _showTrackingDialog(Map<String, dynamic> commande) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text('Suivi de commande', style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Commande #${commande['id']}',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            _buildTrackingTimeline(),
            SizedBox(height: 16),
            Text(
              'Numéro de suivi: ${commande['tracking']}',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text('Fermer', style: TextStyle(color: Colors.red)),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: Text('Voir chez le transporteur'),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Redirection vers le site du transporteur...')),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTrackingTimeline() {
    return Column(
      children: [
        _timelineItem('Commande confirmée', '05/03/2025', true),
        _timelineDivider(true),
        _timelineItem('Préparation en cours', '06/03/2025', true),
        _timelineDivider(true),
        _timelineItem('Expédiée', '07/03/2025', true),
        _timelineDivider(false),
        _timelineItem('En cours de livraison', 'Aujourd\'hui', false),
        _timelineDivider(false),
        _timelineItem('Livrée', 'Prévu le 12/03/2025', false),
      ],
    );
  }

  Widget _timelineItem(String title, String date, bool completed) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: completed ? Colors.green : Colors.grey,
          ),
          child: completed
              ? Icon(Icons.check, size: 12, color: Colors.white)
              : null,
        ),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: completed ? Colors.white : Colors.grey,
                  fontWeight: completed ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              Text(
                date,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _timelineDivider(bool completed) {
    return Container(
      margin: EdgeInsets.only(left: 9),
      width: 2,
      height: 30,
      color: completed ? Colors.green : Colors.grey,
    );
  }

  void _showCancelDialog(Map<String, dynamic> commande) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text('Annuler la commande', style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Êtes-vous sûr de vouloir annuler la commande #${commande['id']} ?',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 16),
            Text(
              'Veuillez sélectionner une raison :',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 8),
            DropdownButtonFormField<String>(
              dropdownColor: Colors.grey[800],
              items: [
                'Je n\'en ai plus besoin',
                'Délai de livraison trop long',
                'J\'ai trouvé moins cher ailleurs',
                'Erreur de commande',
                'Autre raison'
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: TextStyle(color: Colors.white)),
                );
              }).toList(),
              onChanged: (newValue) {},
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text('Retour', style: TextStyle(color: Colors.grey)),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: Text('Confirmer l\'annulation'),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Votre demande d\'annulation a été envoyée'),
                  backgroundColor: Colors.green,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showRateProductsDialog(Map<String, dynamic> commande) {
    double _rating = 3.0;
    
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            backgroundColor: Colors.grey[900],
            title: Text('Évaluer vos produits', style: TextStyle(color: Colors.white)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Comment évaluez-vous les produits de votre commande #${commande['id']} ?',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return IconButton(
                      icon: Icon(
                        index < _rating ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                        size: 30,
                      ),
                      onPressed: () {
                        setState(() {
                          _rating = index + 1.0;
                        });
                      },
                    );
                  }),
                ),
                SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Partagez votre expérience (optionnel)',
                    hintStyle: TextStyle(color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                  maxLines: 3,
                ),
              ],
            ),
            actions: [
              TextButton(
                child: Text('Annuler', style: TextStyle(color: Colors.grey)),
                onPressed: () => Navigator.pop(context),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                ),
                child: Text('Envoyer'),
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Merci pour votre évaluation !'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}