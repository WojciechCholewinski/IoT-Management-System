import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/config.dart';
import 'package:mobile/models/device/device_name_model.dart';
import 'device/device_model.dart';

class DeviceService {
  final String baseUrl = '${Config.backendUrl}/device';
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

  Future<List<Device>> fetchDevices() async {
    final headers = await _buildHeaders();
    final response = await http.get(Uri.parse(baseUrl), headers: headers);

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => Device.fromJson(item)).toList();
    } else {
      throw Exception(
          'Failed to load devices. StatusCode: ${response.statusCode}');
    }
  }

  Future<List<DeviceName>> fetchDevicesNames() async {
    final headers = await _buildHeaders();
    final response =
        await http.get(Uri.parse('$baseUrl/name'), headers: headers);

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => DeviceName.fromJson(item)).toList();
    } else {
      throw Exception(
          'Failed to load devices Names. StatusCode: ${response.statusCode}');
    }
  }

  Future<void> updateDeviceIsOn(int id, bool isOn) async {
    final url = Uri.parse('$baseUrl/$id/ison');
    final token = await getToken();
    if (token == null) {
      throw Exception('Brak tokenu JWT. Zaloguj się ponownie.');
    }

    final response = await http.patch(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
      body: json.encode(isOn),
    ); // TODO: zmienić na backendzie content z bool na json by było to spójne z resztą i wtedy ujednolićić metodę updateDeviceIsOn z resztą powyższych

    if (response.statusCode == 200 || response.statusCode == 204) {
    } else if (response.statusCode == 404) {
      throw Exception('Device not found. StatusCode: ${response.statusCode}');
    } else if (response.statusCode == 409) {
      throw Exception(
          'Device is already in the requested state. StatusCode: ${response.statusCode}');
    } else {
      throw Exception(
          'Failed to update device. StatusCode: ${response.statusCode}');
    }
  }
}
