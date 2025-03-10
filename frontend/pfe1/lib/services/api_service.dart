import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Remplace par l'IP de ton PC
  static const String baseUrl = "http://192.168.80.83/mon_api";

  // Fonction pour tester la connexion avec affichage détaillé
  static Future<Map<String, dynamic>> testConnexion() async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/login.php"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": "johndoe@example.com", "password": "11111"}),
      );

      // Capturer toutes les informations utiles pour le débogage
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
  static Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
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
        return {"success": true, "data": data};
      } else {
        String message = "Erreur de connexion: ${response.statusCode}";
        try {
          Map<String, dynamic> errorData = jsonDecode(response.body);
          message = errorData['message'] ?? message;
        } catch (e) {
          // Si le corps n'est pas du JSON valide, on utilise le message par défaut
        }
        return {"success": false, "message": message};
      }
    } catch (e) {
      return {"success": false, "message": "Erreur de connexion: $e"};
    }
  }

  // Méthode d'inscription modifiée pour inclure phone et address
  static Future<Map<String, dynamic>> register(
    String name,
    String email,
    String password, {
    String? phone,
    String? address,
  }) async {
    try {
      // Afficher les informations de débogage
      print("Tentative d'inscription avec: $name / $email");

      // Créer la requête HTTP
      final response = await http.post(
        Uri.parse("$baseUrl/register.php"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({
          "name": name,
          "email": email,
          "password": password,
          "phone": phone,
          "address": address,
        }),
      );

      // Afficher les informations de la réponse pour le débogage
      print("Réponse API - StatusCode: ${response.statusCode}");
      print("Réponse API - Headers: ${response.headers}");
      print("Réponse API - Body: '${response.body}'");

      // Vérifier si la réponse est vide
      if (response.body.isEmpty) {
        return {
          "success": false,
          "message": "Réponse vide du serveur (code: ${response.statusCode})",
        };
      }

      // Vérifier si la réponse est au format JSON
      try {
        final Map<String, dynamic> data = jsonDecode(response.body);

        // Renvoyer les données structurées
        return {
          "success": data['success'] ?? false,
          "message": data['message'] ?? "Réponse du serveur sans message",
          "data": data,
        };
      } catch (e) {
        // Erreur de parsing JSON
        return {
          "success": false,
          "message":
              "Erreur de format de réponse: ${e.toString()}. Contenu: ${response.body.substring(0, min(100, response.body.length))}...",
        };
      }
    } catch (e) {
      // Erreur de connexion ou autre erreur
      print("Erreur complète: $e");
      return {
        "success": false,
        "message": "Erreur de connexion: ${e.toString()}",
      };
    }
  }

  // Fonction utilitaire pour limiter la longueur d'une chaîne
  static int min(int a, int b) {
    return (a < b) ? a : b;
  }

  static Future<Map<String, dynamic>> changePassword(
    int userId,
    String currentPassword,
    String newPassword,
  ) async {
    try {
      final response = await http.put(
        Uri.parse("$baseUrl/change_password.php"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "userId": userId,
          "currentPassword": currentPassword,
          "newPassword": newPassword,
        }),
      );

      print("Réponse API - StatusCode: ${response.statusCode}");
      print("Réponse API - Body: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return {
          "success": data['success'] ?? false,
          "message": data['message'] ?? "Password changed successfully",
        };
      } else {
        return {
          "success": false,
          "message": "Failed to change password: ${response.statusCode}",
        };
      }
    } catch (e) {
      return {"success": false, "message": "Error changing password: $e"};
    }
  }

  static Future<Map<String, dynamic>> updateProfile(
    int userId,
    String name,
    String email, {
    String? phone,
    String? address,
  }) async {
    try {
      final response = await http.put(
        Uri.parse("$baseUrl/update_profile.php"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "userId": userId,
          "name": name,
          "email": email,
          "phone": phone,
          "address": address,
        }),
      );

      print("Réponse API - StatusCode: ${response.statusCode}");
      print("Réponse API - Body: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return {
          "success": data['success'] ?? false,
          "message": data['message'] ?? "Profile updated successfully",
        };
      } else {
        return {
          "success": false,
          "message": "Failed to update profile: ${response.statusCode}",
        };
      }
    } catch (e) {
      return {"success": false, "message": "Error updating profile: $e"};
    }
  }

  static Future<Map<String, dynamic>> deleteAccount(int userId) async {
    try {
      final response = await http.delete(
        Uri.parse("$baseUrl/delete_account.php"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"userId": userId}),
      );

      print("Réponse API - StatusCode: ${response.statusCode}");
      print("Réponse API - Body: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return {
          "success": data['success'] ?? false,
          "message": data['message'] ?? "Account deleted successfully",
        };
      } else {
        return {
          "success": false,
          "message": "Failed to delete account: ${response.statusCode}",
        };
      }
    } catch (e) {
      return {"success": false, "message": "Error deleting account: $e"};
    }
  }
}
