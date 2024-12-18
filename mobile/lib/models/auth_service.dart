import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile/config.dart';

class AuthService {
  final String baseUrl = '${Config.backendUrl}/account';

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<String?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // final data = jsonDecode(response.body);
      // final token = data['token']; Zakładamy, że odpowiedź jest jsonem
      final token = response.body; // Zakładamy, że odpowiedź jest tekstowa

      // Zapisz token w secureStorage
      await _secureStorage.write(key: 'jwt_token', value: token);
      return token;
    } else {
      try {
        final errorResponse = jsonDecode(response.body);
        final errorMessage = errorResponse['message'];
        throw Exception(errorMessage);
      } catch (e) {
        throw Exception('Failed to login: ${response.body}');
      }
    }
  }

  Future<void> logout() async {
    await _secureStorage.delete(key: 'jwt_token');
  }

  Future<String?> getToken() async {
    return await _secureStorage.read(key: 'jwt_token');
  }

////////////////////////////////////////////////////////////////////////////////

  Future<http.Response> register(
    String email,
    // String firstName,
    String password,
    String confirmPassword,
    // int roleId
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'email': email,
        // 'firstName': firstName,
        'password': password,
        'confirmPassword': confirmPassword,
        // 'roleId': roleId,
      }),
    );

    return response;
  }
}
