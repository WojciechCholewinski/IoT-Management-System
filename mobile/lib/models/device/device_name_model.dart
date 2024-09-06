class DeviceName {
  final int id;
  final String name;
  final String namePL;

  DeviceName({
    required this.id,
    required this.name,
    required this.namePL,
  });

  factory DeviceName.fromJson(Map<String, dynamic> json) {
    return DeviceName(
      id: json['id'],
      name: json['name'],
      namePL: json['namePL'],
    );
  }

  Map<String, dynamic> toJson() {
   return {
      'id': id,
      'name': name,
      'namePL': namePL,
   };
}
}
