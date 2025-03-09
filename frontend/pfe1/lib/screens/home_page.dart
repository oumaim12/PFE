import 'package:flutter/material.dart';
import 'search_page.dart';
import 'settings_screen.dart';
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
    HomeContent(), // Page d'accueil
    SearchPage(),  // Page de recherche
    SettingsScreen(), // Page des paramètres
    CartPage(),    // Page du panier
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      _toggleSearch();
    } else if (index == 4) {
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

  void _logout() {
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
                      offset: Offset(0, 2),)
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
                _selectedIndex = 1;
                _toggleSearch();
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              setState(() {
                _selectedIndex = 3;
              });
            },
          ),
        ],
      ),
      body: _pages[_selectedIndex],
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
              itemCount: 4,
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