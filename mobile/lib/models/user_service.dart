import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'user/user_model.dart';

class UserService {
  final String baseUrl =
      'https://iot-api-app-efeyd8czcufwcgc9.polandcentral-01.azurewebsites.net/api/account';
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<String?> getToken() async {
    return await _secureStorage.read(key: 'jwt_token');
  }

  Future<UserProfile> fetchUserProfile() async {
    final token = await getToken();

    if (token == null) {
      throw Exception('Brak tokenu JWT. Zaloguj się ponownie.');
    }
    final response = await http.get(
      Uri.parse('$baseUrl/me'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);

      if (body['email'] == null || body['firstName'] == null) {
        throw Exception('Niekompletne dane użytkownika: brak wymaganych pól');
      }

      return UserProfile.fromJson(body);
    } else {
      throw Exception('Failed to load user profile');
    }
  }

  // Future<void> updateUserProfile(UserProfile profile) async {
  //   final url = Uri.parse(baseUrl);

  //   final response = await http.patch(
  //     url,
  //     headers: {'Content-Type': 'application/json'},
  //     body: json.encode(profile.toJson()),
  //   );

  //   if (response.statusCode != 200 && response.statusCode != 204) {
  //     throw Exception('Failed to update user profile');
  //   }
  // }
}
