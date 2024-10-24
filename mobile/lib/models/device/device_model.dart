import 'dart:typed_data';
import 'dart:convert';

class Device {
  final int id;
  final String name;
  final String namePL;
  final Duration runTime;
  final Uint8List lightThemeImage;
  final Uint8List darkThemeImage;
  bool isOn;

  Device({
    required this.id,
    required this.name,
    required this.namePL,
    required this.isOn,
    required this.runTime,
    required this.lightThemeImage,
    required this.darkThemeImage,
  });

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      id: json['id'],
      name: json['name'],
      namePL: json['namePL'],
      runTime: _parseDuration(json['runTime']),
      lightThemeImage: base64Decode(json['lightThemeImage']),
      darkThemeImage: base64Decode(json['darkThemeImage']),
      isOn: json['isOn'],
    );
  }

  // Funkcja do parsowania ciągu znaków TimeSpan na obiekt Duration
  static Duration _parseDuration(String timeSpan) {
    final parts = timeSpan.split('.');
    String timePart = parts[0];
    int milliseconds = 0;

    // Jeśli są milisekundy, parsujemy je
    if (parts.length == 2) {
      milliseconds = int.parse(parts[1].padRight(3, '0').substring(0, 3));
      // padRight dodaje brakujące zera w przypadku gdy są mniej niż 3 cyfry milisekund
    }

    final timeParts = timePart.split(':');
    final hours = int.parse(timeParts[0]);
    final minutes = int.parse(timeParts[1]);
    final seconds = int.parse(timeParts[2]);

    return Duration(
      hours: hours,
      minutes: minutes,
      seconds: seconds,
      milliseconds: milliseconds,
    );
  }

  // Funkcja pomocnicza do formatowania czasu jako godziny, minuty i sekundy
  String get formattedRunTime {
    final hours = runTime.inHours.remainder(24);
    final minutes = runTime.inMinutes.remainder(60);
    final seconds = runTime.inSeconds.remainder(60);

    return '$hours h, $minutes min, $seconds s';
  }
}
