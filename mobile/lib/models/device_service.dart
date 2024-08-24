import 'dart:convert';
import 'package:http/http.dart' as http;
import 'device_model.dart';

class DeviceService {
  Future<List<Device>> fetchDevices() async {
    final response =
        // await http.get(Uri.parse('http://10.0.2.2:5158/api/device'));
        // await http.get(Uri.parse(
        //     'http://10.0.2.2:5000/api/device')); // środowisko: emulator, .net: http, prod,
        await http.get(Uri.parse('https://localhost:5000/api/device'));
    // await http.get(Uri.parse('http://localhost:7051/api/device'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => Device.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load devices');
    }
  }

  Future<void> updateDeviceIsOn(int id, bool isOn) async {
    final url = Uri.parse('https://localhost:5000/api/device/$id/ison');

    final response = await http.patch(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(isOn),
    );

    if (response.statusCode == 200 || response.statusCode == 204) {
    } else if (response.statusCode == 404) {
      throw Exception('Device not found');
    } else if (response.statusCode == 409) {
      throw Exception('Device is already in the requested state');
    } else {
      throw Exception('Failed to update device');
    }
  }
}
