import '../../app_ui/theme.dart';
import '../../app_ui/util.dart';
import '../../app_ui/widgets.dart';
import 'package:flutter/material.dart';
import 'login_page_model.dart';
export 'login_page_model.dart';

class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({super.key});

  @override
  State<LoginPageWidget> createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget> {
  late LoginPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoginPageModel());

    _model.emailAddressFieldTextController ??= TextEditingController();
    _model.emailAddressFieldFocusNode ??= FocusNode();

    _model.passwordFieldTextController ??= TextEditingController();
    _model.passwordFieldFocusNode ??= FocusNode();
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
        backgroundColor: IoT_Theme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: IoT_Theme.of(context).primaryBackground,
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 0.0, 0.0, 24.0),
                      child: Material(
                        color: Colors.transparent,
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Container(
                          width: 48.0,
                          height: 48.0,
                          decoration: BoxDecoration(
                            color: IoT_Theme.of(context).secondaryBackground,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: Image.asset(
                                'assets/images/1.png',
                              ).image,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 8.0,
                                color: Color(0x1917171C),
                                offset: Offset(
                                  0.0,
                                  4.0,
                                ),
                                spreadRadius: 0.0,
                              )
                            ],
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                      ),
                    ),
                    SelectionArea(
                        child: Text(
                      ShteyLocalizations.of(context).getText(
                        '47qkwvd2' /* WoIT */,
                      ),
                      style: IoT_Theme.of(context).headlineSmall.override(
                            fontFamily: 'Readex Pro',
                            fontSize: 30.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            lineHeight: 1.2,
                          ),
                    )),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 12.0, 0.0, 0.0),
                      child: SelectionArea(
                          child: Text(
                        ShteyLocalizations.of(context).getText(
                          '54zbvivd' /* Byte into Comfort! */,
                        ),
                        style: IoT_Theme.of(context).bodySmall.override(
                              fontFamily: 'Inter',
                              letterSpacing: 0.0,
                              lineHeight: 1.5,
                            ),
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 32.0, 0.0, 0.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: IoT_Theme.of(context).primaryBackground,
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 8.0,
                              color: Color(0x1917171C),
                              offset: Offset(
                                0.0,
                                4.0,
                              ),
                              spreadRadius: 0.0,
                            )
                          ],
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Form(
                                key: _model.formKey,
                                autovalidateMode: AutovalidateMode.disabled,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            SelectionArea(
                                                child: Text(
                                              ShteyLocalizations.of(context)
                                                  .getText(
                                                'dmahbs2t' /* Email */,
                                              ),
                                              style: IoT_Theme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Inter',
                                                    color: IoT_Theme.of(context)
                                                        .primaryText,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            )),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0.0, 6.0, 0.0, 0.0),
                                          child: TextFormField(
                                            controller: _model
                                                .emailAddressFieldTextController,
                                            focusNode: _model
                                                .emailAddressFieldFocusNode,
                                            autofocus: false,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelStyle: IoT_Theme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Inter',
                                                    color: IoT_Theme.of(context)
                                                        .primaryText,
                                                    fontSize: 16.0,
                                                    letterSpacing: 0.0,
                                                    lineHeight: 1.5,
                                                  ),
                                              hintText:
                                                  ShteyLocalizations.of(context)
                                                      .getText(
                                                'fdv4wylj' /* Adres e-mail */,
                                              ),
                                              hintStyle: IoT_Theme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Inter',
                                                    color: IoT_Theme.of(context)
                                                        .secondaryText,
                                                    fontSize: 16.0,
                                                    letterSpacing: 0.0,
                                                    lineHeight: 1.5,
                                                  ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Color(0xFFD0D5DD),
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Color(0xFFFDA29B),
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Color(0xFFFDA29B),
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              contentPadding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      14.0, 10.0, 14.0, 10.0),
                                            ),
                                            style: IoT_Theme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Inter',
                                                  color: IoT_Theme.of(context)
                                                      .primaryText,
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
                                                  lineHeight: 1.5,
                                                ),
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            validator: _model
                                                .emailAddressFieldTextControllerValidator
                                                .asValidator(context),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0.0, 20.0, 0.0, 0.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              SelectionArea(
                                                  child: Text(
                                                ShteyLocalizations.of(context)
                                                    .getText(
                                                  'lnaj13zk' /* Password */,
                                                ),
                                                style: IoT_Theme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Inter',
                                                      color:
                                                          IoT_Theme.of(context)
                                                              .primaryText,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                              )),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0.0, 6.0, 0.0, 0.0),
                                            child: TextFormField(
                                              controller: _model
                                                  .passwordFieldTextController,
                                              focusNode:
                                                  _model.passwordFieldFocusNode,
                                              autofocus: false,
                                              obscureText: !_model
                                                  .passwordFieldVisibility,
                                              decoration: InputDecoration(
                                                labelStyle: IoT_Theme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Inter',
                                                      color:
                                                          IoT_Theme.of(context)
                                                              .primaryText,
                                                      fontSize: 16.0,
                                                      letterSpacing: 0.0,
                                                      lineHeight: 1.5,
                                                    ),
                                                hintText: ShteyLocalizations.of(
                                                        context)
                                                    .getText(
                                                  '42qk7ncf' /* •••••••• */,
                                                ),
                                                hintStyle: IoT_Theme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Inter',
                                                      color:
                                                          IoT_Theme.of(context)
                                                              .secondaryText,
                                                      fontSize: 16.0,
                                                      letterSpacing: 0.0,
                                                      lineHeight: 1.5,
                                                    ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Color(0xFFD0D5DD),
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Color(0x00000000),
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Color(0xFFFDA29B),
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Color(0xFFFDA29B),
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                contentPadding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        14.0, 10.0, 14.0, 10.0),
                                                suffixIcon: InkWell(
                                                  onTap: () => setState(
                                                    () => _model
                                                            .passwordFieldVisibility =
                                                        !_model
                                                            .passwordFieldVisibility,
                                                  ),
                                                  focusNode: FocusNode(
                                                      skipTraversal: true),
                                                  child: Icon(
                                                    _model.passwordFieldVisibility
                                                        ? Icons
                                                            .visibility_outlined
                                                        : Icons
                                                            .visibility_off_outlined,
                                                    color: IoT_Theme.of(context)
                                                        .secondaryText,
                                                    size: 16.0,
                                                  ),
                                                ),
                                              ),
                                              style: IoT_Theme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Inter',
                                                    color: IoT_Theme.of(context)
                                                        .primaryText,
                                                    fontSize: 16.0,
                                                    letterSpacing: 0.0,
                                                    lineHeight: 1.5,
                                                  ),
                                              validator: _model
                                                  .passwordFieldTextControllerValidator
                                                  .asValidator(context),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 16.0, 0.0, 0.0),
                                child: SelectionArea(
                                    child: Text(
                                  ShteyLocalizations.of(context).getText(
                                    'ivvfx7ad' /* Nie pamiętasz hasła? */,
                                  ),
                                  style: IoT_Theme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Inter',
                                        color: IoT_Theme.of(context).primary,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                )),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 16.0, 0.0, 0.0),
                                child: ShteyButtonWidget(
                                  onPressed: () async {
                                    context.pushNamed('Dashboard');
                                  },
                                  text: ShteyLocalizations.of(context).getText(
                                    '9hrm2ep9' /* Zaloguj się */,
                                  ),
                                  options: ShteyButtonOptions(
                                    width: double.infinity,
                                    height: 44.0,
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 0.0),
                                    iconPadding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 0.0),
                                    color: IoT_Theme.of(context).primary,
                                    textStyle: IoT_Theme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'Inter',
                                          color: Colors.white,
                                          letterSpacing: 0.0,
                                        ),
                                    elevation: 2.0,
                                    borderSide: const BorderSide(
                                      color: Colors.transparent,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 16.0, 0.0, 0.0),
                                child: Material(
                                  color: Colors.transparent,
                                  elevation: 0.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      border: Border.all(
                                        color: const Color(0xFFD0D5DD),
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Align(
                                      alignment:
                                          const AlignmentDirectional(0.0, 0.0),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0.0, 10.0, 0.0, 10.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.network(
                                              'https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/1200px-Google_%22G%22_Logo.svg.png',
                                              width: 24.0,
                                              height: 24.0,
                                              fit: BoxFit.cover,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      12.0, 0.0, 0.0, 0.0),
                                              child: SelectionArea(
                                                  child: Text(
                                                ShteyLocalizations.of(context)
                                                    .getText(
                                                  'xzl4oow9' /* Sign in with Google */,
                                                ),
                                                style: IoT_Theme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Inter',
                                                      fontSize: 16.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                              )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 24.0, 0.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SelectionArea(
                              child: Text(
                            ShteyLocalizations.of(context).getText(
                              'rzhq191w' /* Nie masz konta?  */,
                            ),
                            style: IoT_Theme.of(context).bodyMedium.override(
                                  fontFamily: 'Inter',
                                  color: IoT_Theme.of(context).secondaryText,
                                  letterSpacing: 0.0,
                                ),
                          )),
                          ShteyButtonWidget(
                            onPressed: () async {
                              context.pushNamed('RegisterPage');
                            },
                            text: ShteyLocalizations.of(context).getText(
                              'vkwuasvj' /* Zarejestruj się */,
                            ),
                            options: ShteyButtonOptions(
                              height: 40.0,
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: IoT_Theme.of(context).primaryBackground,
                              textStyle:
                                  IoT_Theme.of(context).titleSmall.override(
                                        fontFamily: 'Inter',
                                        color: IoT_Theme.of(context).primary,
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                      ),
                              elevation: 0.0,
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
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
    );
  }
}
