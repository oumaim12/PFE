import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Remplace par l'IP de ton PC
  static const String baseUrl = "http://192.168.100.71/mon_api";
  
  // Fonction pour tester la connexion avec affichage détaillé
  static Future<Map<String, dynamic>> testConnexion() async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/login.php"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": "johndoe@example.com", "password": "11111"}),
      );
      
      // Capturer toutes les informations utiles pour le débo gage
      return {
        "statusCode": response.statusCode,
        "headers": response.headers,
        "body": response.body,
      };
    } catch (e) {
      return {"error": e.toString()};
    }
  }

  // Fonction de login améliorée qui retourne un objet résultat
  static Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      print("Tentative de connexion avec: $email / $password");
      
      final response = await http.post(
        Uri.parse("$baseUrl/login.php"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );
      
      print("Réponse API - StatusCode: ${response.statusCode}");
      print("Réponse API - Body: ${response.body}");
      
      if (response.statusCode == 200) {
        // Parser la réponse JSON
        Map<String, dynamic> data = jsonDecode(response.body);
        return {
          "success": true,
          "data": data,
        };
      } else {
        String message = "Erreur de connexion: ${response.statusCode}";
        try {
          Map<String, dynamic> errorData = jsonDecode(response.body);
          message = errorData['message'] ?? message;
        } catch (e) {
          // Si le corps n'est pas du JSON valide, on utilise le message par défaut
        }
        return {
          "success": false,
          "message": message,
        };
      }
    } catch (e) {
      return {
        "success": false,
        "message": "Erreur de connexion: $e",
      };
    }
  }
}