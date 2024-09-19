class AutomationAddDevicesModel {
  final List<int> deviceToTurnOnIds;
  final List<int> deviceToTurnOffIds;

  AutomationAddDevicesModel({
    required this.deviceToTurnOnIds,
    required this.deviceToTurnOffIds,
  });

  Map<String, dynamic> toJson() {
    return {
      'deviceToTurnOnIds': deviceToTurnOnIds,
      'deviceToTurnOffIds': deviceToTurnOffIds,
    };
  }
}
