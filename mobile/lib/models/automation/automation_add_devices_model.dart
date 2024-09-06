class AutomationAddDevicesModel {
  final List<int> deviceIds;

  AutomationAddDevicesModel({
    required this.deviceIds,
  });

  Map<String, dynamic> toJson() {
    return {
      'deviceIds': deviceIds,
    };
  }
}
