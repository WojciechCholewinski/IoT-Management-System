class Device {
  final int id;
  final String name;
  bool isOn;

  Device({required this.id, required this.name, required this.isOn});

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      id: json['id'],
      name: json['name'],
      isOn: json['isOn'],
    );
  }
}
