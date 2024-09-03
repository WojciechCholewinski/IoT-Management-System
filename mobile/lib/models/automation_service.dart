import 'dart:convert';
import 'package:http/http.dart' as http;
import 'automation_model.dart';

class AutomationService {
  Future<List<Automation>> fetchAutomations() async {
    final response =
        await http.get(Uri.parse('https://localhost:5000/api/automation'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);

      return body.map((dynamic item) => Automation.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load automations');
    }
  }

//   Future<void> updateAutomationIsOn(int id, bool isOn) async {
//     final url = Uri.parse('https://localhost:5000/api/automation/$id/ison');

//     final response = await http.patch(
//       url,
//       headers: {'Content-Type': 'application/json'},
//       body: json.encode(isOn),
//     );

//     if (response.statusCode == 200 || response.statusCode == 204) {
//     } else if (response.statusCode == 404) {
//       throw Exception('Automation not found');
//     } else if (response.statusCode == 409) {
//       throw Exception('Automation is already in the requested state');
//     } else {
//       throw Exception('Failed to update automation');
//     }
//   }
}
