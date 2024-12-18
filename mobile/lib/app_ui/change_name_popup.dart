import 'package:flutter/material.dart';
import '../models/user_service.dart';
import 'custom_rect_tween.dart';
import 'internationalization.dart';
import 'theme.dart';

class ChangeNamePopup extends StatefulWidget {
  final String? firstName;
  final String? lastName;
  final VoidCallback onSave;
  const ChangeNamePopup(
      {Key? key, this.firstName, this.lastName, required this.onSave})
      : super(key: key);
  @override
  _ChangeNamePopupState createState() => _ChangeNamePopupState();
}

class _ChangeNamePopupState extends State<ChangeNamePopup> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  final UserService _userService = UserService();

  @override
  void initState() {
    super.initState();

    _firstNameController = TextEditingController(text: widget.firstName ?? '');
    _lastNameController = TextEditingController(text: widget.lastName ?? '');
  }

  void _saveChanges() async {
    final updatedProfile = {
      'firstName': _firstNameController.text,
      'lastName': _lastNameController.text,
    };
    try {
      await _userService.updateUserProfile(updatedProfile);
      widget.onSave();
      Navigator.of(context).pop();
    } catch (e) {
      print("Error updating profile: $e");
      // Logika do obsługi błędów
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = IoT_Theme.of(context);

    return Center(
      child: Hero(
        tag: 'change-name-popup',
        createRectTween: (Rect? begin, Rect? end) =>
            CustomRectTween(begin: begin ?? Rect.zero, end: end ?? Rect.zero),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Material(
            color: theme.secondaryBackground,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _firstNameController,
                      decoration: InputDecoration(
                        labelText: ShteyLocalizations.of(context).getText(
                          'icx3ccl9' /* First name */,
                        ),
                        labelStyle: TextStyle(
                          color: theme.primaryText,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: theme.primary),
                        ),
                      ),
                    ),
                    TextField(
                      controller: _lastNameController,
                      decoration: InputDecoration(
                        labelText: ShteyLocalizations.of(context).getText(
                          'n2bhlw7s' /* Last name */,
                        ),
                        labelStyle: TextStyle(
                          color: theme.primaryText,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: theme.primary),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(
                            ShteyLocalizations.of(context).getText(
                              'xyay4gib' /* Cancel  */,
                            ),
                            style: theme.bodyMedium.override(
                              fontFamily: 'Inter',
                              color: theme.primaryText,
                              letterSpacing: 0.0,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: _saveChanges,
                          child: Text(
                            ShteyLocalizations.of(context).getText(
                              'rq1mzqny' /* Save  */,
                            ),
                            style: theme.bodyMedium.override(
                              fontFamily: 'Inter',
                              color: theme.primaryText,
                              letterSpacing: 0.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
