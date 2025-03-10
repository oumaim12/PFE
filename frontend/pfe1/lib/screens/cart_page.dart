import 'package:flutter/material.dart';

class CartItem {
  final int id;
  final String name;
  final double price;
  final String imageUrl;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    this.quantity = 1,
  });
}

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Sample cart items - replace with your actual data fetching logic
  List<CartItem> _cartItems = [];
  bool _isLoading = true;
  String _promoCode = '';
  double _discount = 0.0;
  
  // Define the dark theme colors
  final Color _primaryColor = Colors.red;
  final Color _backgroundColor = Colors.grey[900]!;
  final Color _cardColor = Colors.grey[850]!;
  final Color _textColor = Colors.white;
  final Color _dividerColor = Colors.red.withOpacity(0.5);

  @override
  void initState() {
    super.initState();
    _fetchCartItems();
  }

  Future<void> _fetchCartItems() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Replace with your actual API call
      // final response = await ApiService.getCartItems(userId: 1);
      
      // For demo purposes, we'll use sample data
      await Future.delayed(const Duration(seconds: 1));
      final sampleItems = [
        CartItem(
          id: 1,
          name: "Product 0",
          price: 59.99,
          imageUrl: "assets/images/product0.jpg",
          quantity: 1,
        ),
        CartItem(
          id: 2,
          name: "Product 1",
          price: 79.99,
          imageUrl: "assets/images/product1.jpg",
          quantity: 2,
        ),
        CartItem(
          id: 3,
          name: "Product 2",
          price: 149.99,
          imageUrl: "assets/images/product2.jpg",
          quantity: 1,
        ),
      ];

      setState(() {
        _cartItems = sampleItems;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Erreur lors du chargement du panier: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  double get _subtotal {
    return _cartItems.fold(
      0,
      (total, item) => total + (item.price * item.quantity),
    );
  }

  double get _shipping {
    // Sample shipping calculation logic
    return _subtotal > 100 ? 0 : 7.99;
  }

  double get _tax {
    // Sample tax calculation (20% VAT)
    return _subtotal * 0.2;
  }

  double get _total {
    return _subtotal + _shipping + _tax - _discount;
  }

  Future<void> _updateQuantity(int itemId, int newQuantity) async {
    if (newQuantity < 1) return;

    try {
      // Replace with your actual API call
      // await ApiService.updateCartItemQuantity(itemId, newQuantity);
      
      setState(() {
        final index = _cartItems.indexWhere((item) => item.id == itemId);
        if (index != -1) {
          _cartItems[index].quantity = newQuantity;
        }
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Erreur lors de la mise à jour: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _removeItem(int itemId) async {
    try {
      // Replace with your actual API call
      // await ApiService.removeCartItem(itemId);
      
      setState(() {
        _cartItems.removeWhere((item) => item.id == itemId);
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Article retiré du panier"),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Erreur lors de la suppression: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _applyPromoCode() async {
    if (_promoCode.isEmpty) return;

    try {
      // Replace with your actual API call
      // final result = await ApiService.applyPromoCode(_promoCode);
      
      // For demo purposes, we'll simulate a success response
      await Future.delayed(const Duration(milliseconds: 500));
      final sampleDiscount = _subtotal * 0.1; // 10% discount

      setState(() {
        _discount = sampleDiscount;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Code promo appliqué avec succès"),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Code promo invalide: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _checkout() async {
    try {
      // Replace with your actual API call
      // await ApiService.createOrder(userId: 1, items: _cartItems);
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Commande passée avec succès"),
          backgroundColor: Colors.green,
        ),
      );
      
      // Navigate to order confirmation screen
      // Navigator.pushReplacementNamed(context, '/order-confirmation');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Erreur lors de la commande: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark().copyWith(
        primaryColor: _primaryColor,
        colorScheme: ColorScheme.dark(
          primary: _primaryColor,
          secondary: _primaryColor,
          surface: _cardColor,
          background: _backgroundColor,
        ),
        scaffoldBackgroundColor: _backgroundColor,
        dividerColor: _dividerColor,
        appBarTheme: AppBarTheme(
          backgroundColor: _backgroundColor,
          foregroundColor: _textColor,
          elevation: 0,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: _primaryColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: _primaryColor, width: 2),
          ),
          labelStyle: TextStyle(color: Colors.grey[400]),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Panier"),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: _fetchCartItems,
            ),
          ],
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(color: _primaryColor),
              )
            : _cartItems.isEmpty
                ? _buildEmptyCart()
                : _buildCartContent(),
        bottomNavigationBar: _cartItems.isEmpty
            ? null
            : _buildCheckoutBar(),
      ),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 80,
            color: Colors.grey[600],
          ),
          const SizedBox(height: 16),
          Text(
            "Votre panier est vide",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Ajoutez des articles pour commencer vos achats",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: _primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              // Navigate to products screen
              // Navigator.pushReplacementNamed(context, '/products');
            },
            child: const Text(
              "Explorer les produits",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Articles (${_cartItems.length})",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: _primaryColor,
            ),
          ),
          const SizedBox(height: 16),
          ..._cartItems.map((item) => _buildCartItem(item)),
          const SizedBox(height: 24),
          _buildPromoCodeSection(),
          const SizedBox(height: 24),
          _buildOrderSummary(),
        ],
      ),
    );
  }

  Widget _buildCartItem(CartItem item) {
    return Card(
      color: _cardColor,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[800]!),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image (placeholder)
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey[700],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Icon(
                  Icons.image,
                  size: 40,
                  color: Colors.grey[500],
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Product details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${item.price.toStringAsFixed(2)} €",
                    style: TextStyle(
                      fontSize: 16,
                      color: _primaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      // Quantity selector
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () => _updateQuantity(item.id, item.quantity - 1),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.grey[800],
                          padding: const EdgeInsets.all(4),
                          minimumSize: const Size(32, 32),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          "${item.quantity}",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () => _updateQuantity(item.id, item.quantity + 1),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.grey[800],
                          padding: const EdgeInsets.all(4),
                          minimumSize: const Size(32, 32),
                        ),
                      ),
                      const Spacer(),
                      // Remove button
                      IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () => _removeItem(item.id),
                        color: Colors.red[300],
                        tooltip: "Supprimer",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPromoCodeSection() {
    return Card(
      color: _cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[800]!),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Code Promo",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) => _promoCode = value,
                    decoration: const InputDecoration(
                      hintText: "Entrez votre code",
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: _applyPromoCode,
                  child: const Text("Appliquer"),
                ),
              ],
            ),
            if (_discount > 0) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.green),
                  const SizedBox(width: 8),
                  Text(
                    "Réduction appliquée: -${_discount.toStringAsFixed(2)} €",
                    style: const TextStyle(color: Colors.green),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Card(
      color: _cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[800]!),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Résumé de la commande",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildSummaryRow("Sous-total", "${_subtotal.toStringAsFixed(2)} €"),
            const SizedBox(height: 8),
            _buildSummaryRow("Frais de livraison", "${_shipping.toStringAsFixed(2)} €"),
            const SizedBox(height: 8),
            _buildSummaryRow("TVA (20%)", "${_tax.toStringAsFixed(2)} €"),
            if (_discount > 0) ...[
              const SizedBox(height: 8),
              _buildSummaryRow(
                "Réduction",
                "-${_discount.toStringAsFixed(2)} €",
                valueColor: Colors.green,
              ),
            ],
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Divider(),
            ),
            _buildSummaryRow(
              "Total",
              "${_total.toStringAsFixed(2)} €",
              isBold: true,
              valueColor: _primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    String value, {
    bool isBold = false,
    Color? valueColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontSize: isBold ? 16 : 14,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontSize: isBold ? 16 : 14,
            color: valueColor,
          ),
        ),
      ],
    );
  }

  Widget _buildCheckoutBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cardColor,
        border: Border(
          top: BorderSide(color: Colors.grey[800]!),
        ),
      ),
      child: SafeArea(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: _primaryColor,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: _checkout,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Passer commande",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 8),
              Text(
                "${_total.toStringAsFixed(2)} €",
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}