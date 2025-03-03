import 'package:flutter/material.dart';
import 'package:pfe1/api_service.dart';
import 'package:pfe1/registerscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;
  String _debugInfo = "";

  // Fonction pour tester la connexion à l'API
  // void _testConnexion() async {
  //   setState(() {
  //     _isLoading = true;
  //     _debugInfo = "Test de connexion en cours...";
  //   });

  //   try {
  //     final result = await ApiService.testConnexion();
  //     setState(() {
  //       _debugInfo = "Résultat du test:\n${result.toString()}";
  //     });
  //   } catch (e) {
  //     setState(() {
  //       _debugInfo = "Erreur lors du test: $e";
  //     });
  //   } finally {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   }
  // }

  // Fonction pour traiter la connexion
  void _login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Veuillez remplir tous les champs")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _debugInfo = "Tentative de connexion...";
    });

    // Appel à la fonction de connexion et affichage du résultat
    final result = await ApiService.login(email, password);
    
    setState(() {
      _isLoading = false;
      _debugInfo = "Résultat: $result";
    });

    if (result['success']) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Connexion réussie!")),
 
      );
      // Navigation vers l'écran suivant ici si la connexion est réussie
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message'])),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Skbt Motorcycle ")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Champ de texte pour l'email
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 10),
              // Champ de texte pour le mot de passe
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: "Mot de passe",
                  border: OutlineInputBorder(),
                ),
                obscureText: true, // Masquer le mot de passe
              ),
              SizedBox(height: 20),
              // Bouton pour soumettre le formulaire
              ElevatedButton(
                onPressed: _isLoading ? null : _login,
                child: _isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text("Se connecter"),
              ),
              SizedBox(height: 10),


              //s'inscrire 
             ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterScreen()),
    );
  },
  child: Text("S'inscrire"),
),
              // Bouton pour tester la connexion
              // ElevatedButton(
              //   onPressed: _isLoading ? null : _testConnexion,
              //   child: Text("Tester la connexion à l'API"),
              // ),
              SizedBox(height: 20),
              // Affichage des informations de débogage
              if (_debugInfo.isNotEmpty)
                Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.grey[200],
                  width: double.infinity,
                  child: Text(
                    _debugInfo,
                    style: TextStyle(fontFamily: 'monospace'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}