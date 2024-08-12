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

  bool _yesorno = false;
  bool get yesorno => _yesorno;
  set yesorno(bool value) {
    _yesorno = value;
  }
}
