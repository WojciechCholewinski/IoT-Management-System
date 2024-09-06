class AutomationRemoveDevicesModel {
  final List<int> deviceIds;

  AutomationRemoveDevicesModel({
    required this.deviceIds,
  });

  Map<String, dynamic> toJson() {
    return {
      'deviceIds': deviceIds,
    };
  }
}
