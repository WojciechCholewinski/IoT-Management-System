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

  // Future<void> updateDevice(int id, bool isOn) async {

  //   final response = await http.put(
  //     Uri.parse('https://example.com/api/devices/$id'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(<String, bool>{'isOn': isOn}),
  //   );

  //   if (response.statusCode != 200) {
  //     throw Exception('Failed to update device');
  //   }
  // }
}
