class AutomationUpdateModel {
  final String name;
  final String namePL;
  final List<String> triggerDays;
  final String triggerTime;
  final bool isOn;

  AutomationUpdateModel({
    required this.name,
    required this.namePL,
    required this.triggerDays,
    required this.triggerTime,
    required this.isOn,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'namePL': namePL,
      'triggerDays': triggerDays,
      'triggerTime': triggerTime,
      'isOn': isOn,
    };
  }
}
