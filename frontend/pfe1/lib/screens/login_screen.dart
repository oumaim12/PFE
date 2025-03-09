import 'package:flutter/material.dart';
import 'package:pfe1/screens/home_page.dart';
import 'package:pfe1/screens/register_screen.dart';
import 'package:pfe1/services/api_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  // Fonction pour traiter la connexion
  void _login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    // Validation des champs
    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = "Veuillez remplir tous les champs";
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Appel à l'API pour la connexion
      final result = await ApiService.login(email, password);

      if (result['success'] == true) {
        // Connexion réussie
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Connexion réussie"),
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
        title: const Text("Connexion"),
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
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _login(),
            ),
            const SizedBox(height: 25),

            // Bouton de connexion
            SizedBox(
              height: 50,
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text(
                        "Se connecter",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
            ),
            const SizedBox(height: 15),

            // Bouton pour s'inscrire
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterScreen()),
                );
              },
              child: const Text(
                "Pas de compte ? S'inscrire",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}