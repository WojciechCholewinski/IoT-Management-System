import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile/config.dart';
import 'user/user_model.dart';

class UserService {
  final String baseUrl = '${Config.backendUrl}/account';
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  static const String contentType = 'application/json; charset=UTF-8';

  Future<String?> getToken() async {
    return await _secureStorage.read(key: 'jwt_token');
  }

  Future<Map<String, String>> _buildHeaders() async {
    final token = await getToken();
    if (token == null) {
      throw Exception('Brak tokenu JWT. Zaloguj się ponownie.');
    }
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': contentType,
    };
  }

  Future<UserProfile> fetchUserProfile() async {
    final headers = await _buildHeaders();
    final response = await http.get(Uri.parse('$baseUrl/me'), headers: headers);

    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);

      if (body['email'] == null || body['firstName'] == null) {
        throw Exception('Niekompletne dane użytkownika: brak wymaganych pól');
      }

      return UserProfile.fromJson(body);
    } else {
      throw Exception(
          'Failed to load user profile. StatusCode: ${response.statusCode}');
    }
  }

  Future<void> updateUserProfile(Map<String, dynamic> profile) async {
    final headers = await _buildHeaders();
    final response = await http.patch(
      Uri.parse('$baseUrl/name'),
      headers: headers,
      body: json.encode(profile),
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception(
          'Failed to update user profile. StatusCode: ${response.statusCode}');
    }
  }

  Future<void> changePassword(Map<String, dynamic> passwordData) async {
    final headers = await _buildHeaders();
    final response = await http.patch(
      Uri.parse('$baseUrl/password'),
      headers: headers,
      body: json.encode(passwordData),
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception(
          'Failed to update password. StatusCode: ${response.statusCode}');
    }
  }

  Future<void> updateProfilePhoto(String base64Photo) async {
    final headers = await _buildHeaders();
    final body = json.encode({
      'photo': base64Photo,
    });

    final response = await http.patch(
      Uri.parse('$baseUrl/photo'),
      headers: headers,
      body: body,
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception(
          'Failed to update profile photo. StatusCode: ${response.statusCode}');
    }
  }
}
