import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import '../../app_ui/change_password_popup.dart';
import '/app_ui/change_name_popup.dart';
import '/app_ui/hero_dialog_route.dart';
import 'package:mobile/models/user/user_model.dart';
import 'package:mobile/models/user_service.dart';
import '/app_ui/animations.dart';
import '/app_ui/icon_button.dart';
import '/app_ui/language_selector.dart';
import '/app_ui/theme.dart';
import '/app_ui/util.dart';
import '/app_ui/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'settings_model.dart';
export 'settings_model.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({super.key});

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget>
    with TickerProviderStateMixin {
  late SettingsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  UserProfile? _userProfile;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SettingsModel());

    _fetchUserProfile();

    animationsMap.addAll({
      'cardOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 1.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: const Offset(0.6, 0.6),
            end: const Offset(1.0, 1.0),
          ),
        ],
      ),
      'textOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 1.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: const Offset(0.0, 20.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
      'textOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 1.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: const Offset(0.0, 20.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
      'dividerOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 1.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: const Offset(0.0, 20.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
      'containerOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 200.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 200.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 200.0.ms,
            duration: 600.0.ms,
            begin: const Offset(0.0, 60.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
      'containerOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 200.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 200.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 200.0.ms,
            duration: 600.0.ms,
            begin: const Offset(0.0, 60.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
      'containerOnPageLoadAnimation3': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 300.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 300.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 300.0.ms,
            duration: 600.0.ms,
            begin: const Offset(0.0, 60.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
      'containerOnPageLoadAnimation4': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 300.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 300.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 300.0.ms,
            duration: 600.0.ms,
            begin: const Offset(0.0, 60.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
      'containerOnPageLoadAnimation5': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 300.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 300.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 300.0.ms,
            duration: 600.0.ms,
            begin: const Offset(0.0, 60.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
      'textOnPageLoadAnimation3': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 300.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 300.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 300.0.ms,
            duration: 600.0.ms,
            begin: const Offset(0.0, 60.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
      'rowOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 300.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 300.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 300.0.ms,
            duration: 600.0.ms,
            begin: const Offset(0.0, 60.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
      'textOnPageLoadAnimation4': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 300.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 300.0.ms,
            duration: 600.0.ms,
            begin: const Offset(0.0, 60.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
      'textOnPageLoadAnimation5': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 300.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 300.0.ms,
            duration: 600.0.ms,
            begin: const Offset(0.0, 60.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
      'buttonOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 400.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 400.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 400.0.ms,
            duration: 600.0.ms,
            begin: const Offset(0.0, 60.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
    });
  }

  Future<void> _fetchUserProfile() async {
    try {
      final profileService = UserService();
      final token = await profileService.getToken();

      if (token == null) {
        throw Exception('Token JWT nie został znaleziony. Sprawdź logowanie.');
      }

      final profile = await profileService.fetchUserProfile();
      setState(() {
        _userProfile = profile;
      });
    } catch (e) {
      print('Error fetching user profile: $e');
    }
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: IoT_Theme.of(context).secondaryBackground,
        appBar: AppBar(
          backgroundColor: IoT_Theme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding:
                  const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 12.0, 0.0),
              child: IotIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30.0,
                borderWidth: 1.0,
                buttonSize: 60.0,
                icon: Icon(
                  Icons.close_rounded,
                  color: IoT_Theme.of(context).secondaryText,
                  size: 30.0,
                ),
                onPressed: () async {
                  context.pushNamed('Dashboard');
                },
              ),
            ),
          ],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: IoT_Theme.of(context).primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: GestureDetector(
                    onLongPress: () async {
                      final ImagePicker picker = ImagePicker();
                      final pickedFile = await picker.pickImage(
                        source: ImageSource.gallery,
                        maxWidth: 1024,
                        maxHeight: 1024,
                      );

                      if (pickedFile != null) {
                        String? fileExtension;

                        if (kIsWeb) {
                          // Na web, path to `blob`, więc sprawdzenie rozszerzenia nie zadziała
                          fileExtension =
                              pickedFile.name.split('.').last.toLowerCase();
                        } else {
                          // Na urządzeniach mobilnych możemy sprawdzić rozszerzenie z path
                          fileExtension =
                              pickedFile.path.split('.').last.toLowerCase();
                        }

                        if (!['png', 'jpg', 'jpeg'].contains(fileExtension)) {
                          // TODO: dodać wyskakujące okienko błędu
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    'Invalid file type. Please select a photo.')),
                          );
                          return;
                        }
                        final bytes = await pickedFile.readAsBytes();
                        final base64Photo = base64Encode(bytes);

                        try {
                          final userService = UserService();
                          await userService.updateProfilePhoto(base64Photo);
                          await _fetchUserProfile(); // Odśwież dane użytkownika po zmianie zdjęcia
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    'Profile photo updated successfully.')),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
                                    Text('Failed to update profile photo.')),
                          );
                        }
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(60.0),
                        child:
                            _userProfile != null && _userProfile!.photo != null
                                ? Image.memory(
                                    base64Decode(_userProfile!.photo!),
                                    width: 100.0,
                                    height: 100.0,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    'assets/images/ProfilePhoto.png',
                                    width: 100.0,
                                    height: 100.0,
                                    fit: BoxFit.cover,
                                  ),
                      ),
                    ),
                  ),
                ).animateOnPageLoad(animationsMap['cardOnPageLoadAnimation']!),
                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                  child: Text(
                    _userProfile != null
                        ? '${_userProfile!.firstName} ${_userProfile!.lastName ?? ''}'
                        : 'Loading...',
                    style: IoT_Theme.of(context).headlineSmall.override(
                          fontFamily: 'Readex Pro',
                          letterSpacing: 0.0,
                        ),
                  ).animateOnPageLoad(
                      animationsMap['textOnPageLoadAnimation1']!),
                ),
                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                  child: Text(
                    _userProfile != null ? _userProfile!.email : 'Loading...',
                    style: IoT_Theme.of(context).titleSmall.override(
                          fontFamily: 'Inter',
                          color: IoT_Theme.of(context).secondary,
                          letterSpacing: 0.0,
                        ),
                  ).animateOnPageLoad(
                      animationsMap['textOnPageLoadAnimation2']!),
                ),
                Divider(
                  height: 44.0,
                  thickness: 1.0,
                  indent: 24.0,
                  endIndent: 24.0,
                  color: IoT_Theme.of(context).alternate,
                ).animateOnPageLoad(
                    animationsMap['dividerOnPageLoadAnimation']!),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      16.0, 12.0, 16.0, 0.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(HeroDialogRoute(
                          builder: (context) {
                            return ChangeNamePopup(
                              firstName: _userProfile?.firstName,
                              lastName: _userProfile?.lastName,
                              onSave: _fetchUserProfile,
                            );
                          },
                          settings: null));
                    },
                    child: Hero(
                      tag: 'change-name-popup',
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: IoT_Theme.of(context).secondaryBackground,
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(
                            color: IoT_Theme.of(context).alternate,
                            width: 2.0,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              8.0, 12.0, 8.0, 12.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    8.0, 0.0, 0.0, 0.0),
                                child: Icon(
                                  Icons.account_circle_outlined,
                                  color: IoT_Theme.of(context).primaryText,
                                  size: 24.0,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    12.0, 0.0, 0.0, 0.0),
                                child: Text(
                                  ShteyLocalizations.of(context).getText(
                                    'c0nxkpd6' /* Change Name */,
                                  ),
                                  style:
                                      IoT_Theme.of(context).bodyMedium.override(
                                            fontFamily: 'Inter',
                                            letterSpacing: 0.0,
                                          ),
                                ),
                              ),
                              Expanded(
                                child: Align(
                                  alignment:
                                      const AlignmentDirectional(1.0, 0.0),
                                  child: Icon(
                                    Icons.chevron_right_rounded,
                                    color: IoT_Theme.of(context).primary,
                                    size: 24.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ).animateOnPageLoad(
                      animationsMap['containerOnPageLoadAnimation1']!),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      16.0, 12.0, 16.0, 0.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(HeroDialogRoute(
                          builder: (context) {
                            return const ChangePasswordPopup();
                          },
                          settings: null));
                    },
                    child: Hero(
                      tag: 'change-password-popup',
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: IoT_Theme.of(context).secondaryBackground,
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(
                            color: IoT_Theme.of(context).alternate,
                            width: 2.0,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              8.0, 12.0, 8.0, 12.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    8.0, 0.0, 0.0, 0.0),
                                child: Icon(
                                  Icons.password,
                                  color: IoT_Theme.of(context).primaryText,
                                  size: 24.0,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    12.0, 0.0, 0.0, 0.0),
                                child: Text(
                                  ShteyLocalizations.of(context).getText(
                                    '302zxkxl' /* Change Password */,
                                  ),
                                  style:
                                      IoT_Theme.of(context).bodyMedium.override(
                                            fontFamily: 'Inter',
                                            letterSpacing: 0.0,
                                          ),
                                ),
                              ),
                              Expanded(
                                child: Align(
                                  alignment:
                                      const AlignmentDirectional(1.0, 0.0),
                                  child: Icon(
                                    Icons.chevron_right_rounded,
                                    color: IoT_Theme.of(context).primary,
                                    size: 24.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ).animateOnPageLoad(
                      animationsMap['containerOnPageLoadAnimation2']!),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      16.0, 12.0, 16.0, 0.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: IoT_Theme.of(context).secondaryBackground,
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(
                        color: IoT_Theme.of(context).alternate,
                        width: 2.0,
                      ),
                    ),
                    child: Align(
                      alignment: const AlignmentDirectional(1.0, 0.0),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            8.0, 12.0, 8.0, 12.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  8.0, 0.0, 0.0, 0.0),
                              child: Icon(
                                Icons.settings_outlined,
                                color: IoT_Theme.of(context).primaryText,
                                size: 24.0,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  12.0, 0.0, 0.0, 0.0),
                              child: Text(
                                ShteyLocalizations.of(context).getText(
                                  'kgk1oke7' /* Account Settings */,
                                ),
                                style:
                                    IoT_Theme.of(context).bodyMedium.override(
                                          fontFamily: 'Inter',
                                          letterSpacing: 0.0,
                                        ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: const AlignmentDirectional(1.0, 0.0),
                                child: Icon(
                                  Icons.chevron_right_rounded,
                                  color: IoT_Theme.of(context).primary,
                                  size: 24.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ).animateOnPageLoad(
                      animationsMap['containerOnPageLoadAnimation3']!),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      16.0, 12.0, 16.0, 0.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: IoT_Theme.of(context).secondaryBackground,
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(
                        color: IoT_Theme.of(context).alternate,
                        width: 2.0,
                      ),
                    ),
                    child: Align(
                      alignment: const AlignmentDirectional(
                          1.0, 0.0), // Ustawienie wyrównania do prawej strony
                      child: Container(
                        width: double
                            .infinity, // Ustawienie szerokości na pełną szerokość kontenera
                        child: IotLanguageSelector(
                          width: 360.0,
                          backgroundColor:
                              IoT_Theme.of(context).secondaryBackground,
                          borderColor: Colors.transparent,
                          dropdownColor:
                              IoT_Theme.of(context).secondaryBackground,
                          dropdownIconColor: IoT_Theme.of(context).primary,
                          borderRadius: 8.0,
                          textStyle: TextStyle(
                            color: IoT_Theme.of(context).primaryText,
                            fontWeight: FontWeight.normal,
                            fontSize: 14.0,
                          ),
                          hideFlags: false,
                          flagSize: 28.0,
                          flagTextGap: 15.0,
                          currentLanguage:
                              ShteyLocalizations.of(context).languageCode,
                          languages: ShteyLocalizations.languages(),
                          onChanged: (lang) => setAppLanguage(context, lang),
                        ),
                      ),
                    ),
                  ).animateOnPageLoad(
                      animationsMap['containerOnPageLoadAnimation4']!),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    width: double.infinity,
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: IoT_Theme.of(context).primaryBackground,
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(
                        color: IoT_Theme.of(context).lineColor,
                        width: 1.0,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                setDarkModeSetting(context, ThemeMode.light);
                              },
                              child: Container(
                                width: 115.0,
                                height: 100.0,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? IoT_Theme.of(context)
                                          .secondaryBackground
                                      : IoT_Theme.of(context).primaryBackground,
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? IoT_Theme.of(context).lineColor
                                        : IoT_Theme.of(context)
                                            .primaryBackground,
                                    width: 1.0,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.wb_sunny_rounded,
                                      color: Theme.of(context).brightness ==
                                              Brightness.light
                                          ? IoT_Theme.of(context).primaryText
                                          : IoT_Theme.of(context).secondaryText,
                                      size: 16.0,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              4.0, 0.0, 0.0, 0.0),
                                      child: Text(
                                        ShteyLocalizations.of(context).getText(
                                          'mptimmco' /* Light  */,
                                        ),
                                        style: IoT_Theme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Inter',
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? IoT_Theme.of(context)
                                                      .primaryText
                                                  : IoT_Theme.of(context)
                                                      .secondaryText,
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                setDarkModeSetting(context, ThemeMode.dark);
                              },
                              child: Container(
                                width: 115.0,
                                height: 100.0,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? IoT_Theme.of(context)
                                          .secondaryBackground
                                      : IoT_Theme.of(context).primaryBackground,
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? IoT_Theme.of(context).lineColor
                                        : IoT_Theme.of(context)
                                            .primaryBackground,
                                    width: 1.0,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.nightlight_round,
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? IoT_Theme.of(context).primaryText
                                          : IoT_Theme.of(context).secondaryText,
                                      size: 16.0,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              4.0, 0.0, 0.0, 0.0),
                                      child: Text(
                                        ShteyLocalizations.of(context).getText(
                                          'rv4mlumu' /* Dark */,
                                        ),
                                        style: IoT_Theme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Inter',
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.dark
                                                  ? IoT_Theme.of(context)
                                                      .primaryText
                                                  : IoT_Theme.of(context)
                                                      .secondaryText,
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ).animateOnPageLoad(
                      animationsMap['containerOnPageLoadAnimation5']!),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      16.0, 14.0, 0.0, 8.0),
                  child: Text(
                    ShteyLocalizations.of(context).getText(
                      'syhnp2eh' /* Follow us on */,
                    ),
                    style: IoT_Theme.of(context).labelMedium.override(
                          fontFamily: 'Inter',
                          letterSpacing: 0.0,
                        ),
                  ).animateOnPageLoad(
                      animationsMap['textOnPageLoadAnimation3']!),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      16.0, 0.0, 16.0, 14.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IotIconButton(
                        borderColor: IoT_Theme.of(context).alternate,
                        borderRadius: 12.0,
                        borderWidth: 1.0,
                        buttonSize: 48.0,
                        fillColor: IoT_Theme.of(context).secondaryBackground,
                        icon: FaIcon(
                          FontAwesomeIcons.youtube,
                          color: IoT_Theme.of(context).secondaryText,
                          size: 24.0,
                        ),
                        onPressed: () {
                          print('IconButton pressed ...');
                        },
                      ),
                      IotIconButton(
                        borderColor: IoT_Theme.of(context).alternate,
                        borderRadius: 12.0,
                        borderWidth: 1.0,
                        buttonSize: 48.0,
                        fillColor: IoT_Theme.of(context).secondaryBackground,
                        icon: FaIcon(
                          FontAwesomeIcons.instagram,
                          color: IoT_Theme.of(context).secondaryText,
                          size: 24.0,
                        ),
                        onPressed: () {
                          print('IconButton pressed ...');
                        },
                      ),
                      IotIconButton(
                        borderColor: IoT_Theme.of(context).alternate,
                        borderRadius: 12.0,
                        borderWidth: 1.0,
                        buttonSize: 48.0,
                        fillColor: IoT_Theme.of(context).secondaryBackground,
                        icon: FaIcon(
                          FontAwesomeIcons.facebookF,
                          color: IoT_Theme.of(context).secondaryText,
                          size: 24.0,
                        ),
                        onPressed: () {
                          print('IconButton pressed ...');
                        },
                      ),
                      IotIconButton(
                        borderColor: IoT_Theme.of(context).alternate,
                        borderRadius: 12.0,
                        borderWidth: 1.0,
                        buttonSize: 48.0,
                        fillColor: IoT_Theme.of(context).secondaryBackground,
                        icon: FaIcon(
                          FontAwesomeIcons.linkedinIn,
                          color: IoT_Theme.of(context).secondaryText,
                          size: 24.0,
                        ),
                        onPressed: () {
                          print('IconButton pressed ...');
                        },
                      ),
                    ].divide(const SizedBox(width: 8.0)),
                  ).animateOnPageLoad(animationsMap['rowOnPageLoadAnimation']!),
                ),
                Align(
                  alignment: const AlignmentDirectional(0.0, 1.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: const AlignmentDirectional(0.0, 1.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              alignment: const AlignmentDirectional(0.0, 0.0),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 1.0, 0.0, 0.0),
                                child: Text(
                                  ShteyLocalizations.of(context).getText(
                                    's7fufo0f' /* App Version */,
                                  ),
                                  style:
                                      IoT_Theme.of(context).titleLarge.override(
                                            fontFamily: 'Inter',
                                            fontSize: 20.0,
                                            letterSpacing: 0.0,
                                          ),
                                ).animateOnPageLoad(
                                    animationsMap['textOnPageLoadAnimation4']!),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(0.0, 1.0),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 1.0, 0.0, 10.0),
                                child: Text(
                                  ShteyLocalizations.of(context).getText(
                                    '83pndnwh' /* v0.0.1 */,
                                  ),
                                  style: IoT_Theme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Inter',
                                        letterSpacing: 0.0,
                                      ),
                                ).animateOnPageLoad(
                                    animationsMap['textOnPageLoadAnimation5']!),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(0.0, 1.0),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 1.0, 0.0, 10.0),
                                child: ShteyButtonWidget(
                                  onPressed: () async {
                                    context.pushNamed('LoginPage');
                                  },
                                  text: ShteyLocalizations.of(context).getText(
                                    'gr0jjko0' /* Log Out */,
                                  ),
                                  options: ShteyButtonOptions(
                                    width: 150.0,
                                    height: 44.0,
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 0.0),
                                    iconPadding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 0.0),
                                    color:
                                        IoT_Theme.of(context).primaryBackground,
                                    textStyle: IoT_Theme.of(context)
                                        .bodyLarge
                                        .override(
                                          fontFamily: 'Inter',
                                          letterSpacing: 0.0,
                                        ),
                                    elevation: 0.0,
                                    borderSide: BorderSide(
                                      color: IoT_Theme.of(context).alternate,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(38.0),
                                  ),
                                ).animateOnPageLoad(animationsMap[
                                    'buttonOnPageLoadAnimation']!),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
