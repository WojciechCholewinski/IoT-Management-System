import 'package:flutter/material.dart';

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

  bool _DeskLighting = false;
  bool get DeskLighting => _DeskLighting;
  set DeskLighting(bool value) {
    _DeskLighting = value;
  }

  bool _HallwayLighting = false;
  bool get HallwayLighting => _HallwayLighting;
  set HallwayLighting(bool value) {
    _HallwayLighting = value;
  }

  bool _UnderLighting = false;
  bool get UnderLighting => _UnderLighting;
  set UnderLighting(bool value) {
    _UnderLighting = value;
  }

  bool _KitchenLighting = false;
  bool get KitchenLighting => _KitchenLighting;
  set KitchenLighting(bool value) {
    _KitchenLighting = value;
  }

  bool _DrawerLock = false;
  bool get DrawerLock => _DrawerLock;
  set DrawerLock(bool value) {
    _DrawerLock = value;
  }

  bool _RollerBlindsW = false;
  bool get RollerBlindsW => _RollerBlindsW;
  set RollerBlindsW(bool value) {
    _RollerBlindsW = value;
  }

  bool _RollerBlindsM = false;
  bool get RollerBlindsM => _RollerBlindsM;
  set RollerBlindsM(bool value) {
    _RollerBlindsM = value;
  }

  bool _RollerBlindsD = false;
  bool get RollerBlindsD => _RollerBlindsD;
  set RollerBlindsD(bool value) {
    _RollerBlindsD = value;
  }

  bool _AirConditioner = false;
  bool get AirConditioner => _AirConditioner;
  set AirConditioner(bool value) {
    _AirConditioner = value;
  }

  bool _AirPurifier = false;
  bool get AirPurifier => _AirPurifier;
  set AirPurifier(bool value) {
    _AirPurifier = value;
  }

  bool _SoilMoisture = false;
  bool get SoilMoisture => _SoilMoisture;
  set SoilMoisture(bool value) {
    _SoilMoisture = value;
  }

  bool _Temperature = false;
  bool get Temperature => _Temperature;
  set Temperature(bool value) {
    _Temperature = value;
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
