import 'dart:convert';
import '/app_ui/util.dart';
import 'register_page_widget.dart' show RegisterPageWidget;
import 'package:flutter/material.dart';
import '/models/auth_service.dart';

class RegisterPageModel extends IotModel<RegisterPageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  // State field(s) for EmailAddressField widget.
  FocusNode? emailAddressFieldFocusNode;
  TextEditingController? emailAddressFieldTextController;
  String? Function(BuildContext, String?)?
      emailAddressFieldTextControllerValidator;
  String? _emailAddressFieldTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return ShteyLocalizations.of(context).getText(
        'fs4z6stm' /* Email is required. */,
      );
    }

    if (!RegExp(kTextValidatorEmailRegex).hasMatch(val)) {
      return ShteyLocalizations.of(context).getText(
        'h9wfxp6z' /* Has to be a valid email address.  */,
      );
    }
    return null;
  }

  // State field(s) for PasswordField widget.
  FocusNode? passwordFieldFocusNode;
  TextEditingController? passwordFieldTextController;
  late bool passwordFieldVisibility;
  String? Function(BuildContext, String?)? passwordFieldTextControllerValidator;
  String? _passwordFieldTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return ShteyLocalizations.of(context).getText(
        'fmero5q1' /* Password is required. */,
      );
    }
    if (val.length < 4) {
      return ShteyLocalizations.of(context).getText(
        '9b35mbe0' /* Password must be at least 4 characters long. */,
      );
    }

    return null;
  }

  // State field(s) for ConfirmPasswordField widget.
  FocusNode? confirmPasswordFieldFocusNode;
  TextEditingController? confirmPasswordFieldTextController;
  late bool confirmPasswordFieldVisibility;
  String? Function(BuildContext, String?)?
      confirmPasswordFieldTextControllerValidator;
  String? _confirmPasswordFieldTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return ShteyLocalizations.of(context).getText(
        'fmero5q1' /* Password is required. */,
      );
    }
    if (val != passwordFieldTextController?.text) {
      return ShteyLocalizations.of(context).getText(
        'fdbdicqi' /* Passwords do not match. */,
      );
    }
    return null;
  }

  void handleErrors(Map<String, dynamic> errors) {
    errors.forEach((field, messages) {
      if (field == 'Email') {
        emailAddressFieldTextControllerValidator = (context, value) {
          return ShteyLocalizations.of(context).getText(
            '5xfzcoqm' /* Email is already taken. */,
          );
        };
      } else if (field == 'Password') {
        passwordFieldTextControllerValidator = (context, value) {
          return messages.join(', ');
        };
      } else if (field == 'ConfirmPassword') {
        confirmPasswordFieldTextControllerValidator = (context, value) {
          return messages.join(', ');
        };
      }
    });
    formKey.currentState?.validate();
  }

  final AuthService _authService = AuthService();

  Future<bool> register(BuildContext context) async {
    if (formKey.currentState?.validate() ?? false) {
      final email = emailAddressFieldTextController?.text;
      final password = passwordFieldTextController?.text;
      final confirmPassword = confirmPasswordFieldTextController?.text;

      final response =
          await _authService.register(email!, password!, confirmPassword!);

      if (response.statusCode == 200) {
        context.goNamed('LoginPage');
        return true;
      } else {
        final errors =
            json.decode(response.body)['errors'] as Map<String, dynamic>;

        handleErrors(errors);
        (context as Element).markNeedsBuild();
        return false;
      }
    }
    return false;
  }

  @override
  void initState(BuildContext context) {
    emailAddressFieldTextControllerValidator =
        _emailAddressFieldTextControllerValidator;
    passwordFieldVisibility = false;
    passwordFieldTextControllerValidator =
        _passwordFieldTextControllerValidator;
    confirmPasswordFieldVisibility = false;
    confirmPasswordFieldTextControllerValidator =
        _confirmPasswordFieldTextControllerValidator;
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    emailAddressFieldFocusNode?.dispose();
    emailAddressFieldTextController?.dispose();

    passwordFieldFocusNode?.dispose();
    passwordFieldTextController?.dispose();

    confirmPasswordFieldFocusNode?.dispose();
    confirmPasswordFieldTextController?.dispose();
  }
}
