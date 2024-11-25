import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/config.dart';
import 'automation/automation_model.dart';
import 'automation/automation_update_model.dart';
import 'automation/automation_add_devices_model.dart';
import 'automation/automation_remove_devices_model.dart';

class AutomationService {
  final String baseUrl = '${Config.backendUrl}/automation';
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

  Future<List<Automation>> fetchAutomations() async {
    final headers = await _buildHeaders();
    final response = await http.get(Uri.parse(baseUrl), headers: headers);

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);

      return body.map((dynamic item) => Automation.fromJson(item)).toList();
    } else {
      throw Exception(
          'Failed to load automations. StatusCode: ${response.statusCode}');
    }
  }

  Future<void> updateAutomation(
      int id, AutomationUpdateModel updateModel) async {
    final headers = await _buildHeaders();
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: headers,
      body: jsonEncode(updateModel.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception(
          'Failed to update automation. StatusCode: ${response.statusCode}');
    }
  }

  Future<void> addDevicesToAutomation(
      int automationId, AutomationAddDevicesModel addDevicesModel) async {
    final headers = await _buildHeaders();
    final jsonBody = jsonEncode(addDevicesModel.toJson());
    print("Sending POST request with body: $jsonBody");

    final response = await http.post(
      Uri.parse('$baseUrl/$automationId/devices'),
      headers: headers,
      body: jsonEncode(addDevicesModel.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception(
          'Failed to add devices to automation. StatusCode: ${response.statusCode}');
    }
  }

  Future<void> removeDevicesFromAutomation(
      int automationId, AutomationRemoveDevicesModel removeDevicesModel) async {
    final headers = await _buildHeaders();
    try {
      final jsonBody = jsonEncode(removeDevicesModel.toJson());
      print("Sending DELETE request with body: $jsonBody");

      final response = await http.delete(
        Uri.parse('$baseUrl/$automationId/devices'),
        headers: headers,
        body: jsonEncode(removeDevicesModel.toJson()),
      );

      if (response.statusCode != 204) {
        throw Exception(
            'Failed to remove devices from automation. StatusCode: ${response.statusCode}');
      }
    } catch (e) {
      print('HTTP DELETE error: $e');
    }
  }
}
