import '../../app_ui/util.dart';
import 'scenesand_automations_widget.dart' show ScenesandAutomationsWidget;
import 'package:flutter/material.dart';

class ScenesandAutomationsModel extends IotModel<ScenesandAutomationsWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
