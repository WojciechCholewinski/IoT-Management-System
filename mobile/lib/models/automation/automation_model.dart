import 'dart:typed_data';
import 'dart:convert';
import 'package:mobile/models/device/device_name_model.dart';

class Automation {
  final int id;
  final String name;
  final String namePL;
  final Uint8List image;
  final List<String> triggerDays;
  final String triggerTime;
  final bool isOn;
  final String createdByEmail;
  late final DateTime parsedTriggerTime;
  List<String> temporarySelectedDays;
  List<DeviceName> devicesToTurnOn;
  List<DeviceName> devicesToTurnOff;

  Automation({
    required this.id,
    required this.name,
    required this.namePL,
    required this.image,
    required this.triggerDays,
    required this.triggerTime,
    required this.isOn,
    required this.createdByEmail,
    required this.devicesToTurnOn,
    required this.devicesToTurnOff,
  }) : temporarySelectedDays = List.from(triggerDays) {
    parsedTriggerTime = _parseTime(triggerTime);
  }

  DateTime _parseTime(String time) {
    final timeParts = time.split(':');
    final hour = int.parse(timeParts[0]);
    final minute = int.parse(timeParts[1]);
    final second = int.parse(timeParts[2]);

    return DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      hour,
      minute,
      second,
    );
  }

  factory Automation.fromJson(Map<String, dynamic> json) {
    return Automation(
      id: json['id'],
      name: json['name'],
      namePL: json['namePL'],
      image: base64Decode(json['image']),
      triggerDays: List<String>.from(json['triggerDays']),
      triggerTime: json['triggerTime'],
      isOn: json['isOn'],
      createdByEmail: json['createdByEmail'],
      devicesToTurnOn: (json['devicesToTurnOn'] as List)
          .map((deviceJson) => DeviceName.fromJson(deviceJson))
          .toList(),
      devicesToTurnOff: (json['devicesToTurnOff'] as List)
          .map((deviceJson2) => DeviceName.fromJson(deviceJson2))
          .toList(),
    );
  }

  Automation copyWith({
    String? name,
    String? namePL,
    Uint8List? image,
    List<String>? triggerDays,
    String? triggerTime,
    bool? isOn,
    String? createdByEmail,
    List<DeviceName>? devicesToTurnOn,
    List<DeviceName>? devicesToTurnOff,
  }) {
    return Automation(
      id: this.id,
      name: name ?? this.name,
      namePL: namePL ?? this.namePL,
      image: image ?? this.image,
      triggerDays: triggerDays ?? this.triggerDays,
      triggerTime: triggerTime ?? this.triggerTime,
      isOn: isOn ?? this.isOn,
      createdByEmail: createdByEmail ?? this.createdByEmail,
      devicesToTurnOn: devicesToTurnOn ?? this.devicesToTurnOn,
      devicesToTurnOff: devicesToTurnOff ?? this.devicesToTurnOff,
    );
  }
}
