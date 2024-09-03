import 'package:flutter/material.dart';
import 'models/device_model.dart';
import 'models/device_service.dart';
import 'models/automation_model.dart';
import 'models/automation_service.dart';

class ShteyAppState extends ChangeNotifier {
  static ShteyAppState _instance = ShteyAppState._internal();

  factory ShteyAppState() {
    return _instance;
  }

  ShteyAppState._internal();

  static void reset() {
    _instance = ShteyAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  List<Device> _devices = [];

  List<Device> get devices => _devices;

  final DeviceService _deviceService = DeviceService();

  Future<void> fetchDevices() async {
    _devices = await _deviceService.fetchDevices();
    notifyListeners();
  }

  void toggleDeviceState(Device device) async {
    final newState = !device.isOn;
    try {
      await _deviceService.updateDeviceIsOn(device.id, newState);
      device.isOn = newState;
      notifyListeners();
    } catch (e) {
      print('Error updating device: $e');
    }
  }

  List<Automation> _automations = [];
  List<Automation> get automations => _automations;

  final AutomationService _automationService = AutomationService();

  Future<void> fetchAutomations() async {
    try {
      _automations = await _automationService.fetchAutomations();

      notifyListeners();
    } catch (e) {
      print('Error fetching automations: $e');
    }
  }

////////////////////////////////////////////////////////////////

  // Metoda do resetowania wyboru dni
  void resetDaysSelection() {
    _Monday = false;
    _Tuesday = false;
    _Wednesday = false;
    _Thursday = false;
    _Friday = false;
    _Saturday = false;
    _Sunday = false;
    notifyListeners();
  }

  bool _Monday = false;
  bool get Monday => _Monday;
  set Monday(bool value) {
    _Monday = value;
    notifyListeners();
  }

  bool _Tuesday = false;
  bool get Tuesday => _Tuesday;
  set Tuesday(bool value) {
    _Tuesday = value;
    notifyListeners();
  }

  bool _Wednesday = false;
  bool get Wednesday => _Wednesday;
  set Wednesday(bool value) {
    _Wednesday = value;
    notifyListeners();
  }

  bool _Thursday = false;
  bool get Thursday => _Thursday;
  set Thursday(bool value) {
    _Thursday = value;
    notifyListeners();
  }

  bool _Friday = false;
  bool get Friday => _Friday;
  set Friday(bool value) {
    _Friday = value;
    notifyListeners();
  }

  bool _Saturday = false;
  bool get Saturday => _Saturday;
  set Saturday(bool value) {
    _Saturday = value;
    notifyListeners();
  }

  bool _Sunday = false;
  bool get Sunday => _Sunday;
  set Sunday(bool value) {
    _Sunday = value;
    notifyListeners();
  }
}
