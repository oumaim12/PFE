import 'dart:convert';
import 'package:http/http.dart' as http;
<<<<<<< HEAD
=======


>>>>>>> 481dd02d7d022e5330a0e2a32354ff0cbe1de8ce

class ApiService {
  // Replace with your PC's IP
  static const String baseUrl = "http://10.0.2.2:8000/api";

  static Map<String, dynamic>? currentUser;
  static String? accessToken;

<<<<<<< HEAD
=======
  //     // Capture all useful information for debugging
  //     return {
  //       "statusCode": response.statusCode,
  //       "headers": response.headers,
  //       "body": response.body,
  //     };
  //   } catch (e) {
  //     return {"error": e.toString()};
  //   }
  // }


//   static Future<void> saveUserId(int userId) async {
//   final prefs = await SharedPreferences.getInstance();
//   await prefs.setInt('userId', userId);
// }
// static Future<int?> getUserId() async {
//   final prefs = await SharedPreferences.getInstance();
//   return prefs.getInt('userId');
// }
>>>>>>> 481dd02d7d022e5330a0e2a32354ff0cbe1de8ce
  // Improved login function that returns a result object
  static Future<Map<String, dynamic>> login(
    // ignore: non_constant_identifier_names
    String Cin,
    String password,
  ) async {
    try {
<<<<<<< HEAD
      // Assurez-vous que currentUser est nul avant la connexion
      // Cette ligne est importante pour effacer les données d'un utilisateur précédent
      currentUser = null;
      accessToken = null;
=======
      // print("Attempting login with: $Cin / $password");
>>>>>>> 481dd02d7d022e5330a0e2a32354ff0cbe1de8ce

      final response = await http.post(
        Uri.parse("$baseUrl/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"cin": Cin, "password": password}),
      );

<<<<<<< HEAD
=======
      // print("API Response - StatusCode: ${response.statusCode}");
      // print("API Response - Body: ${response.body}");

>>>>>>> 481dd02d7d022e5330a0e2a32354ff0cbe1de8ce
      if (response.statusCode == 200) {
        // Parse the JSON response
        Map<String, dynamic> data = jsonDecode(response.body);

<<<<<<< HEAD
        if (data['success'] == true) {
          currentUser = data['user'];
          accessToken = data['access_token'];
          
          return {
            "success": true,
            "message": data['message'],
            "user": data['user'],
            "token": data['access_token'],
          };
        } else {
          return {
            "success": false,
            "message": data['message'] ?? "Login failed",
          };
        }
      } else {
        String message = "Login error: ${response.statusCode}";
        try {
          Map<String, dynamic> errorData = jsonDecode(response.body);
          message = errorData['message'] ?? message;
        } catch (e) {
          // If the body is not valid JSON, use the default message
        }
        return {"success": false, "message": message};
      }
=======
  if (data['success'] == true) {
    // if (data['user'] != null && data['user']['id'] != null) {
    //       await saveUserId(data['user']['id']);
    //     }
    return {
      "success": true,
      "message": data['message'],
      "user": data['user'],
      "token": data['token'],
    };
  } else {
    return {
      "success": false,
      "message": data['message'] ?? "Login failed",
    };
  }
} else {
  String message = "Login error: ${response.statusCode}";
  try {
    Map<String, dynamic> errorData = jsonDecode(response.body);
    message = errorData['message'] ?? message;
  } catch (e) {
    // If the body is not valid JSON, use the default message
  }
  return {"success": false, "message": message};
}
>>>>>>> 481dd02d7d022e5330a0e2a32354ff0cbe1de8ce
    } catch (e) {
      return {"success": false, "message": "Connection error: $e"};
    }
  }

  static Map<String, dynamic>? getCurrentUser() {
    return currentUser;
  }

  // Méthode pour vérifier si un utilisateur est connecté
  static bool isLoggedIn() {
    return currentUser != null && accessToken != null;
  }

  static Future<void> logout() async {
    // Appel à l'API pour déconnecter l'utilisateur côté serveur (si nécessaire)
    if (accessToken != null) {
      try {
        await http.post(
          Uri.parse("$baseUrl/logout"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $accessToken"
          },
        );
      } catch (e) {
        // Gérer les erreurs silencieusement, l'important est de supprimer les données locales
        print("Error during logout API call: $e");
      }
    }
    
    // Réinitialiser les données de l'utilisateur actuel
    currentUser = null;
    accessToken = null;
  }

  // Autres méthodes existantes...

  // Update profile function
  static Future<Map<String, dynamic>> updateProfile(
    int userId,
    String firstName,
    String lastName,
    String email, {
    String? phone,
    String? address,
    String? cin,
  }) async {
    try {
      final Map<String, dynamic> requestBody = {
        "userId": userId,
        "firstname": firstName,
        "lastname": lastName,
        "email": email,
        "phone": phone,
        "address": address,
      };
      
      // Ajoutez le CNI seulement s'il est fourni
      if (cin != null) {
        requestBody["cin"] = cin;
      }

      final response = await http.put(
        Uri.parse("$baseUrl/updateProfile"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken"
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        
        // Mettre à jour les données de l'utilisateur en cache
        if (data['success'] == true && data['user'] != null) {
          currentUser = data['user'];
        }
        
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
  
  static Future<Map<String, dynamic>> getUserProfile(int userId) async {
    try {
      // Toujours faire une requête API fraîche pour obtenir les dernières données
      final response = await http.get(
        Uri.parse("$baseUrl/profile?userId=$userId"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken"
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data['success'] == true && data['user'] != null) {
          // Mettre à jour les informations en cache
          currentUser = data['user'];
          return data['user'];
        } else {
          return {
            "error": data['message'] ?? "Échec de récupération du profil"
          };
        }
      } else {
        return {
          "error": "Échec de récupération: ${response.statusCode}"
        };
      }
    } catch (e) {
      return {"error": "Erreur lors de la récupération du profil: $e"};
    }
  }

<<<<<<< HEAD
// Updated registration method to include first name, last name, CNI, phone, and address
=======

  // Updated registration method to include first name, last name, CIN, phone, and address
>>>>>>> 481dd02d7d022e5330a0e2a32354ff0cbe1de8ce
  static Future<Map<String, dynamic>> register(
    String firstName,
    String lastName,
    String cin,
    String email,
    String password,
    {
    String? phone,
    String? address,
  }) async {
    try {
      // Debug information
      // print("Attempting registration with: $firstName $lastName / $email");

      // Create the HTTP request
      final response = await http.post(
        Uri.parse("$baseUrl/register"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({
          "firstname": firstName,
          "lastname": lastName,
          "cin": cin,
          "email": email,
          "password": password,
          "phone": phone,
          "address": address,
        }),
      );

      // Debug response information
      // print("API Response - StatusCode: ${response.statusCode}");
      // print("API Response - Headers: ${response.headers}");
      // print("API Response - Body: '${response.body}'");

      // Check if the response is empty
      if (response.body.isEmpty) {
        return {
          "success": false,
          "message": "Empty response from server (code: ${response.statusCode})",
        };
      }

      // Check if the response is valid JSON
      try {
        final Map<String, dynamic> data = jsonDecode(response.body);

        // Return structured data
        return {
          "success": data['success'] ?? false,
          "message": data['message'] ?? "Server response without message",
          "data": data,
        };
      } catch (e) {
        // JSON parsing error
        return {
          "success": false,
          "message":
              "Response format error: ${e.toString()}. Content: ${response.body.substring(0, min(100, response.body.length))}...",
        };
      }
    } catch (e) {
      // Connection or other error
      print("Full error: $e");
      return {
        "success": false,
        "message": "Connection error: ${e.toString()}",
      };
    }
  }

  // Utility function to limit string length
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
        Uri.parse("$baseUrl/change-password"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "userId": userId,
          "currentPassword": currentPassword,
          "newPassword": newPassword,
        }),
      );

      // print("API Response - StatusCode: ${response.statusCode}");
      // print("API Response - Body: ${response.body}");

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

<<<<<<< HEAD
    }}}
=======
  // Update profile function
  static Future<Map<String, dynamic>> updateProfile(
    int userId,
    String firstName,
    String lastName,
    String email, {
    String? phone,
    String? address,
  }) async {
    try {
      final response = await http.put(
        Uri.parse("$baseUrl/updateProfile"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "userId": userId,
          "firstname": firstName,
          "lastname": lastName,
          "email": email,
          "phone": phone,
          "address": address,
        }),
      );

      // print("API Response - StatusCode: ${response.statusCode}");
      // print("API Response - Body: ${response.body}");

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

  //supprimer le compte 
  static Future<Map<String, dynamic>> deleteAccount(int userId) async {
    try {
      final response = await http.delete(
        Uri.parse("$baseUrl/delete_account.php"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"userId": userId}),
      );

      // print("API Response - StatusCode: ${response.statusCode}");
      // print("API Response - Body: ${response.body}");

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

  //recuperer les information
 static Future<Map<String, dynamic>> getUserProfile(int userId) async {

  // Exemple : Appeler une API, interroger une base de données, etc.

  // Retourner un objet Map avec des valeurs par défaut ou vides
  return {
    "firstname": "",
    "lastname": "",
    "cin": "",
    "email": "",
    "phone": "",
    "address": "",
  };
}}
>>>>>>> 481dd02d7d022e5330a0e2a32354ff0cbe1de8ce
