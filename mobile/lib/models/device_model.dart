import 'dart:typed_data';
import 'dart:convert';

class Device {
  final int id;
  final String name;
  final Uint8List lightThemeImage;
  final Uint8List darkThemeImage;
  bool isOn;

  Device(
      {required this.id,
      required this.name,
      required this.isOn,
      required this.lightThemeImage,
      required this.darkThemeImage});

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      id: json['id'],
      name: json['name'],
      lightThemeImage: base64Decode(json['lightThemeImage']),
      darkThemeImage: base64Decode(json['darkThemeImage']),
      isOn: json['isOn'],
    );
  }
}
