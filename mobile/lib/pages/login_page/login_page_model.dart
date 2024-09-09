import '/app_ui/util.dart';
import 'login_page_widget.dart' show LoginPageWidget;
import 'package:flutter/material.dart';
import '/models/auth_service.dart';

class LoginPageModel extends IotModel<LoginPageWidget> {
  ///  State fields for stateful widgets in this page.
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  @override
  void initState(BuildContext context) {
    emailAddressFieldTextControllerValidator =
        _emailAddressFieldTextControllerValidator;
    passwordFieldVisibility = false;
    passwordFieldTextControllerValidator =
        _passwordFieldTextControllerValidator;
  }

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
        'e2ncoote' /* Email is required. */,
      );
    }

    if (!RegExp(kTextValidatorEmailRegex).hasMatch(val)) {
      return ShteyLocalizations.of(context).getText(
        'z5newg0r' /* Has to be a valid email address. */,
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
        '70kzte5o' /* Password is required. */,
      );
    }
    if (val.length < 4) {
      return ShteyLocalizations.of(context).getText(
        '9b35mbe0' /* Password must be at least 4 characters long. */,
      );
    }

    return null;
  }

  final AuthService _authService = AuthService();

  Future<void> login(BuildContext context) async {
    if (formKey.currentState?.validate() ?? false) {
      final email = emailAddressFieldTextController?.text;
      final password = passwordFieldTextController?.text;

      try {
        final token = await _authService.login(email!, password!);
        if (token != null) {
          context.goNamed('Logo_page');
        } else {
          _errorMessage = ShteyLocalizations.of(context)
              .getText('z1igambh' /* Invalid username or password. */);
          // onUpdate(); // Wywołuje aktualizację strony
          (context as Element).markNeedsBuild();
        }
      } catch (e) {
        if (e.toString().contains('')) {
          _errorMessage = ShteyLocalizations.of(context)
              .getText('z1igambh' /* Invalid username or password. */);
        } else {
          _errorMessage = ShteyLocalizations.of(context).getText(
              '9f20knwx' /* An error occurred while logging in. Please try again later. */);
        }
        // onUpdate(); // Wywołuje aktualizację strony
        (context as Element).markNeedsBuild();
      }
    }
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    emailAddressFieldFocusNode?.dispose();
    emailAddressFieldTextController?.dispose();

    passwordFieldFocusNode?.dispose();
    passwordFieldTextController?.dispose();
  }
}
