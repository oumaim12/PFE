import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_item.dart';
import '../providers/cart_provider.dart';
import '../services/api_service.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String _promoCode = '';
  double _discount = 0.0;
  bool _isLoadingLocal = false; // Pour le suivi local de l'état de chargement
  String? _localError; // Pour le suivi local des erreurs
  
  // Define the dark theme colors
  final Color _primaryColor = Colors.red;
  final Color _backgroundColor = Colors.grey[900]!;
  final Color _cardColor = Colors.grey[850]!;
  final Color _textColor = Colors.white;
  final Color _dividerColor = Colors.red.withOpacity(0.5);

  @override
  void initState() {
    super.initState();
    print("CartPage - initState called");
    _fetchCartItems();
  }

  Future<void> _fetchCartItems() async {
    print("CartPage - _fetchCartItems called");
    setState(() {
      _isLoadingLocal = true;
      _localError = null;
    });

    try {
      print("CartPage - About to load cart from provider");
      await Provider.of<CartProvider>(context, listen: false).loadCart();
      print("CartPage - Cart loaded successfully");
    } catch (e) {
      print("CartPage - Error loading cart: $e");
      setState(() {
        _localError = "Erreur lors du chargement du panier: $e";
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Erreur lors du chargement du panier: $e"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingLocal = false;
        });
      }
    }
  }

  double get _subtotal {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    print("CartPage - Calculating subtotal: ${cartProvider.totalAmount}");
    return cartProvider.totalAmount;
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
    
    print("CartPage - Updating quantity for item $itemId to $newQuantity");
    setState(() {
      _isLoadingLocal = true;
    });
    
    try {
      await Provider.of<CartProvider>(context, listen: false).updateQuantity(itemId, newQuantity);
      print("CartPage - Quantity updated successfully");
    } catch (e) {
      print("CartPage - Error updating quantity: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Erreur lors de la mise à jour: $e"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingLocal = false;
        });
      }
    }
  }

  Future<void> _removeItem(int itemId) async {
    print("CartPage - Removing item $itemId");
    setState(() {
      _isLoadingLocal = true;
    });
    
    try {
      await Provider.of<CartProvider>(context, listen: false).removeItem(itemId);
      print("CartPage - Item removed successfully");
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Article retiré du panier"),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      print("CartPage - Error removing item: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Erreur lors de la suppression: $e"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingLocal = false;
        });
      }
    }
  }

  Future<void> _applyPromoCode() async {
    if (_promoCode.isEmpty) return;
    
    print("CartPage - Applying promo code: $_promoCode");
    setState(() {
      _isLoadingLocal = true;
    });
    
    try {
      // TODO: Implement promo code API
      // For demo purposes, we'll simulate a success response
      await Future.delayed(const Duration(milliseconds: 500));
      final sampleDiscount = _subtotal * 0.1; // 10% discount
      
      setState(() {
        _discount = sampleDiscount;
      });
      
      print("CartPage - Promo code applied successfully");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Code promo appliqué avec succès"),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      print("CartPage - Error applying promo code: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Code promo invalide: $e"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingLocal = false;
        });
      }
    }
  }

  Future<void> _checkout() async {
  print("CartPage - Checkout process started");
  setState(() {
    _isLoadingLocal = true;
  });
  
  try {
    // Implement checkout functionality
    print("CartPage - Creating order from cart");
    final result = await ApiService.createCommandeFromCart();
    
    if (result['success']) {
      print("CartPage - Order created successfully");
      await Provider.of<CartProvider>(context, listen: false).clearCart();
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Commande passée avec succès"),
            backgroundColor: Colors.green,
          ),
        );
      }
      
      // Navigate to order confirmation screen
      // Navigator.pushReplacementNamed(context, '/order-confirmation');
    } else {
      print("CartPage - Error creating order: ${result['message']}");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Erreur: ${result['message']}"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  } catch (e) {
    print("CartPage - Exception during checkout: $e");
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Erreur lors de la commande: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  } finally {
    if (mounted) {
      setState(() {
        _isLoadingLocal = false;
      });
    }
  }
}

  @override
  Widget build(BuildContext context) {
    print("CartPage - build method called");
    
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
        body: _isLoadingLocal
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: _primaryColor),
                    SizedBox(height: 16),
                    Text(
                      "Chargement du panier...",
                      style: TextStyle(color: _textColor),
                    ),
                  ],
                ),
              )
            : _localError != null
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline, color: Colors.red, size: 48),
                        SizedBox(height: 16),
                        Text(
                          'Erreur locale: $_localError',
                          style: TextStyle(color: _textColor),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: _primaryColor),
                          onPressed: _fetchCartItems,
                          child: Text('Réessayer'),
                        ),
                      ],
                    ),
                  )
                : Consumer<CartProvider>(
                    builder: (context, cartProvider, child) {
                      print("CartPage - Consumer rebuilding with isLoading=${cartProvider.isLoading}, error=${cartProvider.error}, items=${cartProvider.items.length}");
                      
                      if (cartProvider.isLoading) {
                        return Center(
                          child: CircularProgressIndicator(color: _primaryColor),
                        );
                      }

                      if (cartProvider.error != null) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.error_outline, color: Colors.red, size: 48),
                              SizedBox(height: 16),
                              Text(
                                'Erreur: ${cartProvider.error}',
                                style: TextStyle(color: _textColor),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 16),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(backgroundColor: _primaryColor),
                                onPressed: _fetchCartItems,
                                child: Text('Réessayer'),
                              ),
                            ],
                          ),
                        );
                      }

                      if (cartProvider.items.isEmpty) {
                        return _buildEmptyCart();
                      }

                      return _buildCartContent(cartProvider.items);
                    },
                  ),
        bottomNavigationBar: Consumer<CartProvider>(
          builder: (context, cartProvider, child) {
            return cartProvider.items.isEmpty 
                ? Container(height: 0) // Widget vide transparent 
                : _buildCheckoutBar();
          },
        ),
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
              Navigator.pop(context);
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

  Widget _buildCartContent(List<CartItem> cartItems) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Articles (${cartItems.length})",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: _primaryColor,
            ),
          ),
          const SizedBox(height: 16),
          ...cartItems.map((item) => _buildCartItem(item)),
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
            // Product image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: item.imageUrl.isNotEmpty
                  ? Image.network(
                      item.imageUrl,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 80,
                          height: 80,
                          color: Colors.grey[700],
                          child: Icon(
                            Icons.image_not_supported,
                            size: 40,
                            color: Colors.grey[500],
                          ),
                        );
                      },
                    )
                  : Container(
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
                  child: const Text("Appliquer", style: TextStyle(color: Colors.white)),
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
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(width: 8),
              Text(
                "${_total.toStringAsFixed(2)} €",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}