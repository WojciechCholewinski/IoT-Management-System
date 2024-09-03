import '/app_ui/button_tabbar.dart';
import '/app_ui/icon_button.dart';
import '/app_ui/theme.dart';
import '/app_ui/toggle_icon.dart';
import '/app_ui/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dashboard_model.dart';
export 'dashboard_model.dart';

class DashboardWidget extends StatefulWidget {
  const DashboardWidget({super.key});

  @override
  State<DashboardWidget> createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget>
    with TickerProviderStateMixin {
  late DashboardModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DashboardModel());

    final appState = Provider.of<ShteyAppState>(context, listen: false);
    appState.fetchDevices();
    appState.fetchAutomations();
    _model.tabBarController = TabController(
      vsync: this,
      length: 3,
      initialIndex: 0,
    )..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<ShteyAppState>();

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: IoT_Theme.of(context).secondaryBackground,
        floatingActionButton: Align(
          alignment: const AlignmentDirectional(1.0, 1.0),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 10.0),
            child: FloatingActionButton(
              onPressed: () {
                print('FloatingActionButton pressed ...');
              },
              backgroundColor: IoT_Theme.of(context).primary,
              elevation: 8.0,
              child: Align(
                alignment: const AlignmentDirectional(0.0, 0.0),
                child: Icon(
                  Icons.add,
                  color: IoT_Theme.of(context).info,
                  size: 34.0,
                ),
              ),
            ),
          ),
        ),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70.0),
          child: AppBar(
            backgroundColor: IoT_Theme.of(context).secondaryBackground,
            automaticallyImplyLeading: false,
            title: Text(
              ShteyLocalizations.of(context).getText(
                'knrdk3vc' /* Dashboard */,
              ),
              style: IoT_Theme.of(context).titleLarge.override(
                    fontFamily: 'Inter',
                    letterSpacing: 0.0,
                  ),
            ),
            actions: const [],
            centerTitle: false,
            elevation: 0.0,
          ),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Column(
                children: [
                  Align(
                    alignment: const Alignment(-1.0, 0),
                    child: IoT_ButtonTabBar(
                      useToggleButtonStyle: false,
                      isScrollable: true,
                      labelStyle: IoT_Theme.of(context).titleMedium.override(
                            fontFamily: 'Inter',
                            letterSpacing: 0.0,
                          ),
                      unselectedLabelStyle: const TextStyle(),
                      labelColor: IoT_Theme.of(context).primary,
                      unselectedLabelColor: IoT_Theme.of(context).secondaryText,
                      backgroundColor: IoT_Theme.of(context).accent1,
                      borderColor: IoT_Theme.of(context).primary,
                      borderWidth: 2.0,
                      borderRadius: 12.0,
                      elevation: 0.0,
                      labelPadding: const EdgeInsetsDirectional.fromSTEB(
                          16.0, 0.0, 16.0, 0.0),
                      buttonMargin: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 12.0, 16.0, 0.0),
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          16.0, 0.0, 16.0, 0.0),
                      tabs: [
                        Tab(
                          text: ShteyLocalizations.of(context).getText(
                            'bu43kf6r' /* Devices */,
                          ),
                        ),
                        Tab(
                          text: ShteyLocalizations.of(context).getText(
                            'jt4uj0mr' /* Automations */,
                          ),
                        ),
                        Tab(
                          text: ShteyLocalizations.of(context).getText(
                            'erg0mogz' /* Scenes */,
                          ),
                        ),
                      ],
                      controller: _model.tabBarController,
                      onTap: (i) async {
                        [() async {}, () async {}, () async {}][i]();
                      },
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _model.tabBarController,
                      children: [
                        Consumer<ShteyAppState>(
                          builder: (context, appState, child) {
                            if (appState.devices.isEmpty) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }

                            return ListView.builder(
                              padding: const EdgeInsets.only(bottom: 50.0),
                              itemCount: appState.devices.length,
                              itemBuilder: (context, index) {
                                final device = appState.devices[index];
                                return Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      16, 8, 16, 0),
                                  child: Container(
                                    key: ValueKey(device.id),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: IoT_Theme.of(context)
                                          .primaryBackground,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? Colors.grey.withOpacity(0.7)
                                              : Colors.black.withOpacity(0.5),
                                          blurRadius: 5, // Rozmycie cienia
                                          offset: const Offset(2,
                                              2), // Przesunięcie cienia (poziomo, pionowo)
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Flexible(
                                          child: Align(
                                            alignment:
                                                AlignmentDirectional(0, 0),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(8, 8, 22, 8),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    child: Image.memory(
                                                      Theme.of(context)
                                                                  .brightness ==
                                                              Brightness.dark
                                                          ? device
                                                              .darkThemeImage
                                                          : device
                                                              .lightThemeImage,
                                                      width: 70,
                                                      height: 70,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(
                                                            16, 0, 0, 0),
                                                    child: Text(
                                                      ShteyLocalizations.of(
                                                                      context)
                                                                  .languageCode ==
                                                              "en"
                                                          ? device.name
                                                          : device.namePL,
                                                      style: IoT_Theme.of(
                                                              context)
                                                          .bodyLarge
                                                          .override(
                                                            fontFamily: 'Inter',
                                                            letterSpacing: 0,
                                                          ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0, 0),
                                                    child: IotIconButton(
                                                      borderRadius: 50,
                                                      borderWidth: 0,
                                                      buttonSize: 40,
                                                      icon: Icon(
                                                        Icons.info_outline,
                                                        color: IoT_Theme.of(
                                                                context)
                                                            .primaryText,
                                                        size: 22,
                                                      ),
                                                      onPressed: () {
                                                        print(
                                                            'IconButton pressed ...');
                                                      },
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Align(
                                                      alignment:
                                                          AlignmentDirectional
                                                              .centerEnd,
                                                      child: Container(
                                                        height:
                                                            70, // Tyle samo, co wysokość obrazka, po to by wyrównać przestrzeń
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: ToggleIcon(
                                                          onPressed: () async {
                                                            appState
                                                                .toggleDeviceState(
                                                                    device);
                                                          },
                                                          value: device.isOn,
                                                          onIcon: Icon(
                                                            Icons
                                                                .toggle_on_outlined,
                                                            color: IoT_Theme.of(
                                                                    context)
                                                                .primary,
                                                          ),
                                                          offIcon: Icon(
                                                            Icons
                                                                .toggle_off_outlined,
                                                            color: IoT_Theme.of(
                                                                    context)
                                                                .secondaryText,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        Consumer<ShteyAppState>(
                          builder: (context, appState, child) {
                            if (appState.automations.isEmpty) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }

                            return ListView.builder(
                              padding: const EdgeInsets.only(bottom: 50.0),
                              itemCount: appState.automations.length,
                              itemBuilder: (context, index) {
                                final automation = appState.automations[index];
                                return Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      16, 8, 16, 0),
                                  child: Container(
                                    key: ValueKey(automation.id),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: IoT_Theme.of(context)
                                          .primaryBackground,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? Colors.grey.withOpacity(0.7)
                                              : Colors.black.withOpacity(0.5),
                                          blurRadius: 5, // Rozmycie cienia
                                          offset: const Offset(2,
                                              2), // Przesunięcie cienia (poziomo, pionowo)
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Flexible(
                                          child: Align(
                                            alignment:
                                                AlignmentDirectional(0, 0),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(8, 8, 22, 8),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    child: Image.memory(
                                                      automation.image,
                                                      width: 70,
                                                      height: 70,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(
                                                            16, 0, 0, 0),
                                                    child: Text(
                                                      ShteyLocalizations.of(
                                                                      context)
                                                                  .languageCode ==
                                                              "en"
                                                          ? automation.name
                                                          : automation.namePL,
                                                      style: IoT_Theme.of(
                                                              context)
                                                          .bodyLarge
                                                          .override(
                                                            fontFamily: 'Inter',
                                                            letterSpacing: 0,
                                                          ),
                                                    ),
                                                  ),
                                                  // Expanded(
                                                  //   child: Align(
                                                  //     alignment:
                                                  //         AlignmentDirectional(
                                                  //             1, 0),
                                                  //     child: IotIconButton(
                                                  //       borderRadius: 50,
                                                  //       borderWidth: 0,
                                                  //       buttonSize: 40,
                                                  //       icon: Icon(
                                                  //         Icons.info_outline,
                                                  //         color: IoT_Theme.of(
                                                  //                 context)
                                                  //             .primaryText,
                                                  //         size: 22,
                                                  //       ),
                                                  //       onPressed: () {
                                                  //         print(
                                                  //             'IconButton pressed ...');
                                                  //       },
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                  Expanded(
                                                    child: Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              1, 0),
                                                      child: IotIconButton(
                                                        borderColor:
                                                            IoT_Theme.of(
                                                                    context)
                                                                .alternate,
                                                        borderRadius: 40,
                                                        borderWidth: 1,
                                                        buttonSize: 50,
                                                        fillColor: IoT_Theme.of(
                                                                context)
                                                            .alternate,
                                                        icon: Icon(
                                                          Icons
                                                              .settings_outlined,
                                                          color: IoT_Theme.of(
                                                                  context)
                                                              .primaryText,
                                                          size: 30,
                                                        ),
                                                        onPressed: () async {
                                                          context.pushNamed(
                                                              'AutomationDetails');
                                                        },
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
                                );
                              },
                            );
                          },
                        ),
                        SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16.0, 16.0, 0.0, 0.0),
                                child: Text(
                                  ShteyLocalizations.of(context).getText(
                                    'i6bei8ge' /* Categories */,
                                  ),
                                  style: IoT_Theme.of(context)
                                      .headlineSmall
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16.0, 12.0, 16.0, 0.0),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color:
                                        IoT_Theme.of(context).primaryBackground,
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            8.0, 8.0, 12.0, 8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.asset(
                                            'assets/images/Movie.png',
                                            width: 70.0,
                                            height: 70.0,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(16.0, 0.0, 0.0, 0.0),
                                          child: Text(
                                            ShteyLocalizations.of(context)
                                                .getText(
                                              'migymr3q' /* Movie */,
                                            ),
                                            style: IoT_Theme.of(context)
                                                .bodyLarge
                                                .override(
                                                  fontFamily: 'Inter',
                                                  letterSpacing: 0.0,
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
                                    16.0, 8.0, 16.0, 0.0),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color:
                                        IoT_Theme.of(context).primaryBackground,
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            8.0, 8.0, 12.0, 8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.asset(
                                            'assets/images/Study_Mode.png',
                                            width: 70.0,
                                            height: 70.0,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(16.0, 0.0, 0.0, 0.0),
                                          child: Text(
                                            ShteyLocalizations.of(context)
                                                .getText(
                                              '4gx722hc' /* Study Mode */,
                                            ),
                                            style: IoT_Theme.of(context)
                                                .bodyLarge
                                                .override(
                                                  fontFamily: 'Inter',
                                                  letterSpacing: 0.0,
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
                                    16.0, 8.0, 16.0, 44.0),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color:
                                        IoT_Theme.of(context).primaryBackground,
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            8.0, 8.0, 12.0, 8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.asset(
                                            'assets/images/All_Blinds.jpg',
                                            width: 70.0,
                                            height: 70.0,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(16.0, 0.0, 0.0, 0.0),
                                          child: Text(
                                            ShteyLocalizations.of(context)
                                                .getText(
                                              'ullzwey1' /* All Blinds */,
                                            ),
                                            style: IoT_Theme.of(context)
                                                .bodyLarge
                                                .override(
                                                  fontFamily: 'Inter',
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
