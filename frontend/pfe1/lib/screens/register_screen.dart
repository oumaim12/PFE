import 'package:flutter/material.dart';
import 'home_page.dart';
import '../services/api_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _register() async {
    setState(() {
      _errorMessage = null;
      _isLoading = true;
    });

    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();
    String phone = phoneController.text.trim();
    String address = addressController.text.trim();

    // Validation des champs côté client
    if (name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      setState(() {
        _errorMessage = "Veuillez remplir tous les champs obligatoires";
        _isLoading = false;
      });
      return;
    }

    if (password != confirmPassword) {
      setState(() {
        _errorMessage = "Les mots de passe ne correspondent pas";
        _isLoading = false;
      });
      return;
    }

    // Validation basique de l'email
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      setState(() {
        _errorMessage = "Format d'email invalide";
        _isLoading = false;
      });
      return;
    }

    try {
      // Appeler l'API pour l'inscription
      final result = await ApiService.register(
        name,
        email,
        password,
        phone: phone.isNotEmpty ? phone : null,
        address: address.isNotEmpty ? address : null,
      );

      // Résultat de l'API
      if (result['success'] == true) {
        // Inscription réussie
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Inscription réussie"),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
        // Rediriger vers la page d'accueil
        // ignore: use_build_context_synchronously
        await Future.delayed(const Duration(seconds: 2));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        // Afficher le message d'erreur renvoyé par le serveur
        setState(() {
          _errorMessage = result['message'] ?? "Une erreur est survenue";
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = "Erreur de connexion: $e";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: const Text(
          "Créer un compte",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.red),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            
            // Affichage du message d'erreur
            if (_errorMessage != null)
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.red.shade900.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red.shade800),
                ),
                child: Text(
                  _errorMessage!,
                  style: TextStyle(color: Colors.red.shade200),
                ),
              ),
            
            // Champ de nom
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Nom complet *",
                labelStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade800),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade800),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                prefixIcon: Icon(Icons.person, color: Colors.red),
                filled: true,
                fillColor: Colors.grey[850],
              ),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 15),
            
            // Champ de téléphone
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                labelText: "Téléphone",
                labelStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade800),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade800),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                prefixIcon: Icon(Icons.phone, color: Colors.red),
                filled: true,
                fillColor: Colors.grey[850],
              ),
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 15),
            
            // Champ d'adresse
            TextField(
              controller: addressController,
              decoration: InputDecoration(
                labelText: "Adresse",
                labelStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade800),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade800),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                prefixIcon: Icon(Icons.location_on, color: Colors.red),
                filled: true,
                fillColor: Colors.grey[850],
              ),
              keyboardType: TextInputType.streetAddress,
              textInputAction: TextInputAction.next,
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 15),
            
            // Champ d'email
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Email *",
                labelStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade800),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade800),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                prefixIcon: Icon(Icons.email, color: Colors.red),
                filled: true,
                fillColor: Colors.grey[850],
              ),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 15),
            
            // Champ de mot de passe
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: "Mot de passe *",
                labelStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade800),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade800),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                prefixIcon: Icon(Icons.lock, color: Colors.red),
                filled: true,
                fillColor: Colors.grey[850],
              ),
              obscureText: true,
              textInputAction: TextInputAction.next,
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 15),
            
            // Champ de confirmation du mot de passe
            TextField(
              controller: confirmPasswordController,
              decoration: InputDecoration(
                labelText: "Confirmer le mot de passe *",
                labelStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade800),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade800),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                prefixIcon: Icon(Icons.lock_outline, color: Colors.red),
                filled: true,
                fillColor: Colors.grey[850],
              ),
              obscureText: true,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _register(),
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 25),
            
            // Bouton d'inscription
            SizedBox(
              height: 50,
              child: _isLoading
                  ? Center(child: CircularProgressIndicator(color: Colors.red))
                  : ElevatedButton(
                      onPressed: _register,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "S'inscrire",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}