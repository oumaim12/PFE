// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// class AuthService {
//   // Create a secure storage instance
//   static const _storage = FlutterSecureStorage();
//   static const _tokenKey = 'auth_token';

//   // Save token
//   static Future<void> saveToken(String token) async {
//     await _storage.write(key: _tokenKey, value: token);
//   }

//   // Retrieve token
//   static Future<String?> getToken() async {
//     return await _storage.read(key: _tokenKey);
//   }

//   // Remove token
//   static Future<void> removeToken() async {
//     await _storage.delete(key: _tokenKey);
//   }

//   // Check if logged in
//   static Future<bool> isLoggedIn() async {
//     final token = await getToken();
//     return token != null && token.isNotEmpty;
//   }
// }
