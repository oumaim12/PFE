import 'package:flutter/material.dart';
import 'search_page.dart';
import 'profile_screen.dart';
import 'mes_motos_screen.dart';
import 'mes_commandes_screen.dart';
import 'cart_page.dart';
import 'login_screen.dart';
import '../widgets/product_card.dart';

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

  final List<Widget> _pages = [
    HomeContent(),       // Page d'accueil
    MesMotosScreen(),    // Page Mes Motos
    ProfileScreen(),     // Page du profile 
    MesCommandesScreen() // Page Mes Commandes
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      
      // Si la barre de recherche est ouverte, la fermer lors d'un changement d'onglet
      if (_showSearchBar) {
        _toggleSearch();
      }
    });

    if (index == 4) {
      _logout();
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

  void _navigateToSearch() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SearchPage()),
    );
  }

  void _navigateToCart() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CartPage()),
    );
  }

  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: _showSearchBar
            ? AnimatedContainer(
                duration: Duration(milliseconds: 300),
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 5,
                      offset: Offset(0, 2),)
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Rechercher des pièces...',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search, color: Colors.red),
                    suffixIcon: _isSearching
                        ? IconButton(
                            icon: Icon(Icons.close, color: Colors.red),
                            onPressed: _toggleSearch,
                          )
                        : null,
                  ),
                  style: TextStyle(color: Colors.white),
                  autofocus: true,
                  onChanged: (value) {
                    // Ajoutez ici la logique de recherche
                  },
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      _navigateToSearch();
                    }
                  },
                ),
              )
            : Text('Moto Parts Shopping', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.red),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.red),
            onPressed: _showSearchBar ? null : _toggleSearch,
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart, color: Colors.red),
                onPressed: _navigateToCart,
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '3',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[900],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
          BottomNavigationBarItem(icon: Icon(Icons.motorcycle), label: 'Mes Motos'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'Mes Commandes'),
          BottomNavigationBarItem(icon: Icon(Icons.logout), label: 'Déconnexion'),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  colors: [Colors.red.shade900, Colors.red.shade700],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                image: DecorationImage(
                  image: NetworkImage('https://via.placeholder.com/600x150'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.red.withOpacity(0.3),
                    BlendMode.overlay,
                  ),
                ),
              ),
              child: Center(
                child: Text(
                  'Promo Spéciale -30% sur les freins !',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(1, 1),
                        blurRadius: 3,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Suggestions pour vous',
              style: TextStyle(
                fontSize: 20, 
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
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
              itemCount: 4,
              itemBuilder: (context, index) {
                return ProductCard(
                  product: {
                    'name': 'Produit $index',
                    'price': '\$${(index + 1) * 50}',
                    'image': 'https://via.placeholder.com/150',
                  },
                );
              },
            ),
            SizedBox(height: 20),
            Text(
              'Catégories populaires',
              style: TextStyle(
                fontSize: 20, 
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildCategoryCard('Freins', Icons.disc_full),
                  _buildCategoryCard('Moteurs', Icons.settings),
                  _buildCategoryCard('Pneus', Icons.tire_repair),
                  _buildCategoryCard('Lumières', Icons.lightbulb),
                  _buildCategoryCard('Carburant', Icons.local_gas_station),
                  _buildCategoryCard('Filtres', Icons.filter_alt),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Meilleures ventes',
              style: TextStyle(
                fontSize: 20, 
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
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
              itemCount: 4,
              itemBuilder: (context, index) {
                final products = [
                  {
                    'name': 'Plaquettes de frein',
                    'price': '\$120',
                    'image': 'https://via.placeholder.com/150',
                  },
                  {
                    'name': 'Huile moteur premium',
                    'price': '\$85',
                    'image': 'https://via.placeholder.com/150',
                  },
                  {
                    'name': 'Filtre à air performance',
                    'price': '\$65',
                    'image': 'https://via.placeholder.com/150',
                  },
                  {
                    'name': 'Batterie longue durée',
                    'price': '\$150',
                    'image': 'https://via.placeholder.com/150',
                  },
                ];
                return ProductCard(product: products[index]);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(String title, IconData icon) {
    return Container(
      width: 100,
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 40,
            color: Colors.red,
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}