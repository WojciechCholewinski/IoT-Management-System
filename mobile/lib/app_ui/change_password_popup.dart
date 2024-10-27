import 'package:flutter/material.dart';
import 'custom_rect_tween.dart';
import 'internationalization.dart';
import 'theme.dart';

class ChangePasswordPopup extends StatefulWidget {
  final String? firstName;
  final String? lastName;
  const ChangePasswordPopup({Key? key, this.firstName, this.lastName})
      : super(key: key);
  @override
  _ChangePasswordPopupState createState() => _ChangePasswordPopupState();
}

class _ChangePasswordPopupState extends State<ChangePasswordPopup> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = IoT_Theme.of(context);

    return Center(
      child: Hero(
        tag: 'change-password-popup',
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
                      // controller: _firstNameController,
                      decoration: InputDecoration(
                        labelText: ShteyLocalizations.of(context).getText(
                          'iul8e0wu' /* Old password */,
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
                      // controller: _lastNameController,
                      decoration: InputDecoration(
                        labelText: ShteyLocalizations.of(context).getText(
                          '2j3udxa0' /* New password */,
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
                      // controller: _lastNameController,
                      decoration: InputDecoration(
                        labelText: ShteyLocalizations.of(context).getText(
                          'pm08xcwv' /* Confirm password */,
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
                          onPressed: () {
                            // TODO:  logika do zapisania imienia i nazwiska
                            Navigator.of(context).pop();
                          },
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
