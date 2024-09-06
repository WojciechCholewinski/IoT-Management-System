import 'dart:convert';
import 'package:http/http.dart' as http;
import 'automation/automation_model.dart';
import 'automation/automation_update_model.dart';
import 'automation/automation_add_devices_model.dart';
import 'automation/automation_remove_devices_model.dart';

class AutomationService {
  final String baseUrl = 'https://localhost:5000/api/automation';

  Future<List<Automation>> fetchAutomations() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);

      return body.map((dynamic item) => Automation.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load automations');
    }
  }

  Future<void> updateAutomation(
      int id, AutomationUpdateModel updateModel) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(updateModel.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update automation');
    }
  }

  Future<void> addDevicesToAutomation(
      int automationId, AutomationAddDevicesModel addDevicesModel) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$automationId/devices'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(addDevicesModel.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add devices to automation');
    }
  }

  Future<void> removeDevicesFromAutomation(
      int automationId, AutomationRemoveDevicesModel removeDevicesModel) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/$automationId/devices'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(removeDevicesModel.toJson()),
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to remove devices from automation');
    }
  }
}
