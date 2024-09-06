import 'package:flutter/material.dart';
import 'package:mobile/models/device/device_name_model.dart';
import 'models/automation/automation_add_devices_model.dart';
import 'models/automation/automation_remove_devices_model.dart';
import 'models/automation/automation_update_model.dart';
import 'models/device/device_model.dart';
import 'models/device_service.dart';
import 'models/automation/automation_model.dart';
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

  List<DeviceName> _devicesNames = [];

  List<DeviceName> get devicesNames => _devicesNames;

  Future<void> fetchDevicesNames() async {
    _devicesNames = await _deviceService.fetchDevicesNames();
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

////////////////////////////////////////////////////////////////

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

  Future<void> updateAutomation(
      Automation automation, AutomationUpdateModel updateModel) async {
    try {
      await _automationService.updateAutomation(automation.id, updateModel);
      // Aktualizacja lokalnego stanu po pomyślnej aktualizacji na serwerze
      final index = _automations.indexWhere((a) => a.id == automation.id);
      if (index != -1) {
        _automations[index] = automation.copyWith(
          name: updateModel.name,
          namePL: updateModel.namePL,
          triggerDays: updateModel.triggerDays,
          triggerTime: updateModel.triggerTime,
          isOn: updateModel.isOn,
        );
        notifyListeners();
      }
    } catch (e) {
      print('Error updating automation: $e');
    }
  }

  List<DeviceName> _devicesToAdd = [];
  List<DeviceName> _devicesToRemove = [];

  Future<void> addDevicesToAutomation(
      int automationId, List<DeviceName> devices) async {
    try {
      await _automationService.addDevicesToAutomation(
        automationId,
        AutomationAddDevicesModel(deviceIds: devices.map((d) => d.id).toList()),
      );
      notifyListeners();
    } catch (e) {
      print('Error adding devices: $e');
    }
  }

  Future<void> removeDevicesFromAutomation(
      int automationId, List<DeviceName> devices) async {
    try {
      await _automationService.removeDevicesFromAutomation(
        automationId,
        AutomationRemoveDevicesModel(
            deviceIds: devices.map((d) => d.id).toList()),
      );
      notifyListeners();
    } catch (e) {
      print('Error removing devices: $e');
    }
  }

  void addDeviceToTemporaryList(DeviceName device) {
    _devicesToAdd.add(device);
    _devicesToRemove.removeWhere((d) => d.id == device.id);
    notifyListeners();
  }

  void removeDeviceFromTemporaryList(DeviceName device) {
    _devicesToRemove.add(device);
    _devicesToAdd.removeWhere((d) => d.id == device.id);
    notifyListeners();
  }

  void clearTemporaryLists() {
    _devicesToAdd.clear();
    _devicesToRemove.clear();
    notifyListeners();
  }

  Future<void> saveDeviceChanges(int automationId) async {
    if (_devicesToAdd.isNotEmpty) {
      await addDevicesToAutomation(automationId, _devicesToAdd);
    }
    if (_devicesToRemove.isNotEmpty) {
      await removeDevicesFromAutomation(automationId, _devicesToRemove);
    }
    clearTemporaryLists();
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
