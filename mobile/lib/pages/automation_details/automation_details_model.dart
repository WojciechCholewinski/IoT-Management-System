import '/app_ui/util.dart';
import 'automation_details_widget.dart' show AutomationDetailsWidget;
import 'package:flutter/material.dart';

class AutomationDetailsModel extends IotModel<AutomationDetailsWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for Switch widget.
  bool? switchValue;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
