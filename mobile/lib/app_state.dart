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

  List<DeviceName> _devicesToTurnOnToAdd = [];
  List<DeviceName> _devicesToTurnOffToAdd = [];
  List<DeviceName> _devicesToTurnOnToRemove = [];
  List<DeviceName> _devicesToTurnOffToRemove = [];

  // TODO: Known issue - read git commit message

  // Dodanie urządzenia do listy `DevicesToTurnOn` (i usunięcie z `DevicesToTurnOff`)
  void addDeviceToTurnOnList(DeviceName device) {
    _devicesToTurnOnToAdd.add(device);
    _devicesToTurnOffToRemove.add(device);
    notifyListeners();
  }

  // Dodanie urządzenia do listy `DevicesToTurnOff` (i usunięcie z `DevicesToTurnOn`)
  void addDeviceToTurnOffList(DeviceName device) {
    _devicesToTurnOffToAdd.add(device);
    _devicesToTurnOnToRemove.add(device);
    notifyListeners();
  }

  // Usunięcie urządzenia z listy `DevicesToTurnOn`
  void removeDeviceFromTurnOnList(DeviceName device) {
    print('Removing device from turn on list: ${device.id}');
    _devicesToTurnOnToRemove.add(device);
    _devicesToTurnOnToAdd.removeWhere((d) => d.id == device.id);
    notifyListeners();
  }

  // Usunięcie urządzenia z listy `DevicesToTurnOff`
  void removeDeviceFromTurnOffList(DeviceName device) {
    print('Removing device from turn off list: ${device.id}');
    _devicesToTurnOffToRemove.add(device);
    _devicesToTurnOffToAdd.removeWhere((d) => d.id == device.id);
    notifyListeners();
  }

  // Metoda, która zwraca listę urządzeń dostępnych do dodania (nie dodanych do żadnej z list)
  List<DeviceName> getAvailableDevices(Automation automation) {
    return _devicesNames.where((device) {
      // Sprawdź, czy urządzenie jest już na którejś z list
      return !automation.devicesToTurnOn.any((d) => d.id == device.id) &&
          !automation.devicesToTurnOff.any((d) => d.id == device.id) &&
          !_devicesToTurnOnToAdd.any((d) => d.id == device.id) &&
          !_devicesToTurnOffToAdd.any((d) => d.id == device.id);
    }).toList();
  }

// Wyczyść tymczasowe listy po zapisaniu
  void clearTemporaryLists() {
    _devicesToTurnOnToAdd.clear();
    _devicesToTurnOffToAdd.clear();
    _devicesToTurnOnToRemove.clear();
    _devicesToTurnOffToRemove.clear();
    notifyListeners();
  }

  // Dodaj urządzenia do automatyzacji (turnOn lub turnOff)
  Future<void> addDevicesToAutomation(int automationId,
      List<int> devicesToTurnOnIds, List<int> devicesToTurnOffIds) async {
    try {
      AutomationAddDevicesModel addDevicesModel = AutomationAddDevicesModel(
        deviceToTurnOnIds: devicesToTurnOnIds,
        deviceToTurnOffIds: devicesToTurnOffIds,
      );

      await _automationService.addDevicesToAutomation(
        automationId,
        addDevicesModel,
      );
      notifyListeners();
    } catch (e) {
      print('Error adding devices: $e');
    }
  }

  // Usuń urządzenia z automatyzacji (turnOn lub turnOff)
  Future<void> removeDevicesFromAutomation(int automationId,
      List<int> devicesToTurnOnIds, List<int> devicesToTurnOffIds) async {
    try {
      AutomationRemoveDevicesModel removeDevicesModel =
          AutomationRemoveDevicesModel(
        deviceToTurnOnIds: devicesToTurnOnIds,
        deviceToTurnOffIds: devicesToTurnOffIds,
      );
      // Wywołujemy serwis odpowiedzialny za usunięcie
      await _automationService.removeDevicesFromAutomation(
        automationId,
        removeDevicesModel,
      );
      notifyListeners();
    } catch (e) {
      print('Error removing devices: $e');
    }
  }

  // Zapisz zmiany urządzeń
  Future<void> saveDeviceChanges(int automationId) async {
    // Tworzenie list do dodania
    final devicesToTurnOnIdsToAdd =
        _devicesToTurnOnToAdd.map((d) => d.id).toList();
    final devicesToTurnOffIdsToAdd =
        _devicesToTurnOffToAdd.map((d) => d.id).toList();

    // Sprawdzenie, czy są jakieś urządzenia do dodania
    if (devicesToTurnOnIdsToAdd.isNotEmpty ||
        devicesToTurnOffIdsToAdd.isNotEmpty) {
      print(
          'Adding devices: turn on: $devicesToTurnOnIdsToAdd, turn off: $devicesToTurnOffIdsToAdd');

      // Wywołanie serwisu w celu dodania urządzeń
      await addDevicesToAutomation(
          automationId, devicesToTurnOnIdsToAdd, devicesToTurnOffIdsToAdd);
    }

    // Tworzenie list do usunięcia
    final devicesToTurnOnIdsToRemove =
        _devicesToTurnOnToRemove.map((d) => d.id).toList();
    final devicesToTurnOffIdsToRemove =
        _devicesToTurnOffToRemove.map((d) => d.id).toList();

    // Sprawdzenie czy jest cokolwiek do usunięcia
    if (devicesToTurnOnIdsToRemove.isNotEmpty ||
        devicesToTurnOffIdsToRemove.isNotEmpty) {
      print(
          'Removing devices: turn on: $devicesToTurnOnIdsToRemove, turn off: $devicesToTurnOffIdsToRemove');

      // Wywołanie serwisu w celu usunięcia urządzeń
      await removeDevicesFromAutomation(automationId,
          devicesToTurnOnIdsToRemove, devicesToTurnOffIdsToRemove);
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
