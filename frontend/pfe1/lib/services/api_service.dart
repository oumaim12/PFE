import 'dart:convert';
import 'package:http/http.dart' as http;



class ApiService {
  // Replace with your PC's IP
static const String baseUrl = "http://10.0.2.2:8000/api";

  // Function to test connection with detailed output
  // static Future<Map<String, dynamic>> testConnexion() async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse("$baseUrl/login"),
  //       headers: {"Content-Type": "application/json"},
  //       body: jsonEncode({"email": "johndoe@example.com", "password": "11111"}),
  //     );

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
  // Improved login function that returns a result object
  static Future<Map<String, dynamic>> login(
    // ignore: non_constant_identifier_names
    String Cin,
    String password,
  ) async {
    try {
      // print("Attempting login with: $Cin / $password");

      final response = await http.post(
        Uri.parse("$baseUrl/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"cin": Cin, "password": password}),
      );

      // print("API Response - StatusCode: ${response.statusCode}");
      // print("API Response - Body: ${response.body}");

      if (response.statusCode == 200) {
  // Parse the JSON response
  Map<String, dynamic> data = jsonDecode(response.body);

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
    } catch (e) {
      return {"success": false, "message": "Connection error: $e"};
    }
  }
// static Future<String?> getToken() async {
//   final prefs = await SharedPreferences.getInstance();
//   return prefs.getString('auth_token');
// }


// static Future<void> _saveToken(String token) async {
//   final prefs = await SharedPreferences.getInstance();
//   await prefs.setString('auth_token', token);
// }








  // Updated registration method to include first name, last name, CIN, phone, and address
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

  // Change password function
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
    }
  }

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