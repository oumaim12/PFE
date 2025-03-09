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
      appBar: AppBar(
        title: const Text("Créer un compte"),
        centerTitle: true,
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
                  color: Colors.red.shade100,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red.shade300),
                ),
                child: Text(
                  _errorMessage!,
                  style: TextStyle(color: Colors.red.shade800),
                ),
              ),
            
            // Champ de nom
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Nom complet *",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 15),
            
            // Champ de téléphone
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: "Téléphone",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone),
              ),
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 15),
            
            // Champ d'adresse
            TextField(
              controller: addressController,
              decoration: const InputDecoration(
                labelText: "Adresse",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.location_on),
              ),
              keyboardType: TextInputType.streetAddress,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 15),
            
            // Champ d'email
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 15),
            
            // Champ de mot de passe
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: "Mot de passe",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 15),
            
            // Champ de confirmation du mot de passe
            TextField(
              controller: confirmPasswordController,
              decoration: const InputDecoration(
                labelText: "Confirmer le mot de passe",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock_outline),
              ),
              obscureText: true,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _register(),
            ),
            const SizedBox(height: 25),
            
            // Bouton d'inscription
            SizedBox(
              height: 50,
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: _register,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text(
                        "S'inscrire",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}