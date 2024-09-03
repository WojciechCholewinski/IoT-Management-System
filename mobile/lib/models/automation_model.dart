import 'dart:typed_data';
import 'dart:convert';

class Automation {
  final int id;
  final String name;
  final String namePL;
  final Uint8List image;
  // final List<String> triggerDays;
  // final String triggerTime;
  // final bool isOn;
  // final String createdByEmail;

  Automation({
    required this.id,
    required this.name,
    required this.namePL,
    required this.image,
    // required this.triggerDays,
    // required this.triggerTime,
    // required this.isOn,
    // required this.createdByEmail,
  });

  factory Automation.fromJson(Map<String, dynamic> json) {
    return Automation(
      id: json['id'],
      name: json['name'],
      namePL: json['namePL'],
      image: base64Decode(json['image']),

      // triggerDays: List<String>.from(json['triggerDays']),
      // triggerTime: json['triggerTime'],
      // isOn: json['isOn'],
      // createdByEmail: json['createdByEmail'],
    );
  }
}
