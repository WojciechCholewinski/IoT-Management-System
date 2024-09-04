import 'dart:typed_data';
import 'dart:convert';

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

  Automation({
    required this.id,
    required this.name,
    required this.namePL,
    required this.image,
    required this.triggerDays,
    required this.triggerTime,
    required this.isOn,
    required this.createdByEmail,
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
    );
  }
}
