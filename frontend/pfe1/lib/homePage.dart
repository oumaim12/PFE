import 'package:flutter/material.dart';
import 'package:pfe1/main.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moto Parts Shopping',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  bool _showSearchBar = false;
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  // Données fictives pour les suggestions de produits
  // final List<Map<String, String>> suggestedProducts = [
  //   {'name': 'Piston', 'price': '\$50', 'image': 'https://via.placeholder.com/150'},
  //   {'name': 'Frein avant', 'price': '\$120', 'image': 'https://via.placeholder.com/150'},
  //   {'name': 'Phare avant', 'price': '\$80', 'image': 'https://via.placeholder.com/150'},
  //   {'name': 'Chaîne', 'price': '\$60', 'image': 'https://via.placeholder.com/150'},
  // ];

  // Liste des pages correspondant aux éléments de la BottomNavigationBar
  final List<Widget> _pages = [
    HomeContent(), // Page d'accueil
    SearchPage(),  // Page de recherche
    SettingsScreen(), // Page des paramètres
    CartPage(),    // Page du panier
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Gérer la barre de recherche
    if (index == 1) {
      _toggleSearch();
    } else if (index == 4) {
      _logout(); // Déconnexion
    }
  }

  void _toggleSearch() {
    setState(() {
      _showSearchBar = !_showSearchBar;
      _isSearching = !_isSearching;
      if (!_showSearchBar) {
        _searchController.clear();
      }
    });
  }
void _logout() {
 
  // Naviguer vers la page de connexion
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => LoginScreen()),
  );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _showSearchBar && _selectedIndex == 1
            ? AnimatedContainer(
                duration: Duration(milliseconds: 300),
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Rechercher des pièces...',
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search, color: Colors.orange),
                    suffixIcon: _isSearching
                        ? IconButton(
                            icon: Icon(Icons.close, color: Colors.orange),
                            onPressed: _toggleSearch,
                          )
                        : null,
                  ),
                  style: TextStyle(color: Colors.black),
                  autofocus: true,
                  onChanged: (value) {
                    // Ajoutez ici la logique de recherche
                  },
                ),
              )
            : Text('Moto Parts Shopping'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              setState(() {
                _selectedIndex = 1; // Naviguer vers la page de recherche
                _toggleSearch();
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              setState(() {
                _selectedIndex = 3; // Naviguer vers la page du panier
              });
            },
          ),
        ],
      ),
      body: _pages[_selectedIndex], // Afficher la page correspondante
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Recherche'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Paramètres'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Panier'),
          BottomNavigationBarItem(icon: Icon(Icons.logout), label: 'Déconnexion'),
        ],
      ),
    );
  }
}

// Contenu de la page d'accueil
class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bannière promotionnelle
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage('https://via.placeholder.com/600x150'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Text(
                  'Promo Spéciale -30% sur les freins !',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Section des suggestions
            Text(
              'Suggestions pour vous',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.8,
              ),
              itemCount: 4, // Nombre de produits fictifs
              itemBuilder: (context, index) {
                return ProductCard(
                  product: {
                    'name': 'Produit $index',
                    'price': '\$${index * 50}',
                    'image': 'https://via.placeholder.com/150',
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Page de recherche
class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Page de recherche'),
    );
  }
}








// Page des paramètres


class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  String _selectedLanguage = 'Français';
  String _selectedRegion = 'France';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section : Gestion du Compte
            _buildSectionTitle("Compte"),
            _buildSettingItem(
              icon: Icons.person,
              title: "Modifier le profil",
              onTap: () {
                // Naviguer vers l'écran de modification du profil
              },
            ),
            _buildSettingItem(
              icon: Icons.lock,
              title: "Changer le mot de passe",
              onTap: () {
                // Naviguer vers l'écran de changement de mot de passe
              },
            ),
            _buildSettingItem(
              icon: Icons.delete,
              title: "Supprimer le compte",
              onTap: () {
                // Confirmer la suppression du compte
                _showDeleteAccountDialog();
              },
            ),
            const Divider(),

            // Section : Commandes et Paiements
            _buildSectionTitle("Commandes et Paiements"),
            _buildSettingItem(
              icon: Icons.shopping_cart,
              title: "Historique des commandes",
              onTap: () {
                // Naviguer vers l'historique des commandes
              },
            ),
            _buildSettingItem(
              icon: Icons.credit_card,
              title: "Méthodes de paiement",
              onTap: () {
                // Naviguer vers la gestion des méthodes de paiement
              },
            ),
            _buildSettingItem(
              icon: Icons.receipt,
              title: "Informations de facturation",
              onTap: () {
                // Naviguer vers la gestion des informations de facturation
              },
            ),
            _buildSettingItem(
              icon: Icons.track_changes,
              title: "Suivi des commandes",
              onTap: () {
                // Naviguer vers le suivi des commandes
              },
            ),
            const Divider(),

            // Section : Langue et Région
            _buildSectionTitle("Langue et Région"),
            _buildSettingItem(
              icon: Icons.language,
              title: "Langue",
              trailing: DropdownButton<String>(
                value: _selectedLanguage,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedLanguage = newValue!;
                  });
                },
                items: <String>['Français', 'English', 'Español']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            _buildSettingItem(
              icon: Icons.location_on,
              title: "Région",
              trailing: DropdownButton<String>(
                value: _selectedRegion,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedRegion = newValue!;
                  });
                },
                items: <String>['France', 'Belgique', 'Suisse']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            const Divider(),

            // Section : Notifications
            _buildSectionTitle("Notifications"),
            SwitchListTile(
              title: const Text("Activer les notifications"),
              value: _notificationsEnabled,
              onChanged: (bool value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
              secondary: const Icon(Icons.notifications),
            ),
            const Divider(),

            // Section : Sécurité et Confidentialité
            _buildSectionTitle("Sécurité et Confidentialité"),
            _buildSettingItem(
              icon: Icons.security,
              title: "Authentification à deux facteurs",
              trailing: Switch(
                value: true,
                onChanged: (bool value) {
                  // Activer/désactiver la 2FA
                },
              ),
            ),
            _buildSettingItem(
              icon: Icons.privacy_tip,
              title: "Politique de confidentialité",
              onTap: () {
                // Ouvrir la politique de confidentialité
              },
            ),
            const Divider(),

            // Section : Assistance et Support
            _buildSectionTitle("Assistance et Support"),
            _buildSettingItem(
              icon: Icons.help,
              title: "Centre d'aide",
              onTap: () {
                // Naviguer vers le centre d'aide
              },
            ),
            _buildSettingItem(
              icon: Icons.support,
              title: "Contacter le support",
              onTap: () {
                // Ouvrir le formulaire de contact
              },
            ),
            _buildSettingItem(
              icon: Icons.bug_report,
              title: "Signaler un problème",
              onTap: () {
                // Ouvrir le formulaire de signalement
              },
            ),
            const Divider(),

            // Section : À propos
            _buildSectionTitle("À propos"),
            _buildSettingItem(
              icon: Icons.info,
              title: "Version de l'application",
              trailing: const Text("1.0.0"),
            ),
            _buildSettingItem(
              icon: Icons.description,
              title: "Conditions d'utilisation",
              onTap: () {
                // Ouvrir les conditions d'utilisation
              },
            ),
          ],
        ),
      ),
    );
  }

  // Méthode pour construire un titre de section
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Méthode pour construire un élément de paramètre
  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: trailing,
      onTap: onTap,
    );
  }

  // Méthode pour afficher une boîte de dialogue de suppression de compte
  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Supprimer le compte"),
          content: const Text("Êtes-vous sûr de vouloir supprimer votre compte ? Cette action est irréversible."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Annuler"),
            ),
            TextButton(
              onPressed: () {
                // Supprimer le compte
                Navigator.of(context).pop();
              },
              child: const Text("Supprimer", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}










// Page du panier
class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Page du panier'),
    );
  }
}

// Widget pour afficher un produit
class ProductCard extends StatelessWidget {
  final Map<String, String> product;

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.network(
                product['image']!,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product['name']!,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  product['price']!,
                  style: TextStyle(fontSize: 14, color: Colors.orange),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}