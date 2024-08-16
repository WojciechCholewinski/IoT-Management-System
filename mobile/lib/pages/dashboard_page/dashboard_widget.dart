import '/app_ui/button_tabbar.dart';
import '/app_ui/icon_button.dart';
import '/app_ui/theme.dart';
import '/app_ui/toggle_icon.dart';
import '/app_ui/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/models/device_model.dart';
import '/models/device_service.dart';
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
                'min55hm8' /* Devices */,
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
                        FutureBuilder<List<Device>>(
                          future: DeviceService().fetchDevices(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return const Center(
                                  child: Text('No devices found'));
                            } else {
                              return ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  final device = snapshot.data![index];
                                  return Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            16, 8, 16, 0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: IoT_Theme.of(context)
                                            .primaryBackground,
                                        borderRadius: BorderRadius.circular(12),
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
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      child: Image.asset(
                                                        Theme.of(context)
                                                                    .brightness ==
                                                                Brightness.dark
                                                            ? 'assets/images/${device.name.replaceAll(" ", "_")}_-_Dark_mode.png'
                                                            : 'assets/images/${device.name.replaceAll(" ", "_")}_-_Light_mode.png',
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
                                                        device.name,
                                                        style: IoT_Theme.of(
                                                                context)
                                                            .bodyLarge
                                                            .override(
                                                              fontFamily:
                                                                  'Inter',
                                                              letterSpacing: 0,
                                                            ),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0, 0),
                                                      child: IotIconButton(
                                                        borderRadius: 0,
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
                                                            AlignmentDirectional(
                                                                1, 0),
                                                        child: ToggleIcon(
                                                          onPressed: () async {
                                                            setState(() =>
                                                                device.isOn =
                                                                    !device
                                                                        .isOn);
                                                          },
                                                          value: device.isOn,
                                                          onIcon: Icon(
                                                            Icons
                                                                .toggle_on_outlined,
                                                            color: IoT_Theme.of(
                                                                    context)
                                                                .primary,
                                                            size: 55,
                                                          ),
                                                          offIcon: Icon(
                                                            Icons
                                                                .toggle_off_outlined,
                                                            color: IoT_Theme.of(
                                                                    context)
                                                                .secondaryText,
                                                            size: 55,
                                                          ),
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
                            }
                          },
                        ),
                        // Generated code for this Column Widget...
                        SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 16, 0, 0),
                                child: Text(
                                  ShteyLocalizations.of(context).getText(
                                    '549pvf1t' /* Categories */,
                                  ),
                                  style: IoT_Theme.of(context)
                                      .headlineSmall
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        letterSpacing: 0,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 12, 16, 0),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color:
                                        IoT_Theme.of(context).primaryBackground,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        8, 8, 12, 8),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.asset(
                                            'assets/images/Morning.png',
                                            width: 70,
                                            height: 70,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16, 0, 0, 0),
                                          child: Text(
                                            ShteyLocalizations.of(context)
                                                .getText(
                                              'wuotgig8' /* Morning */,
                                            ),
                                            style: IoT_Theme.of(context)
                                                .bodyLarge
                                                .override(
                                                  fontFamily: 'Inter',
                                                  letterSpacing: 0,
                                                ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment:
                                                AlignmentDirectional(1, 0),
                                            child: IotIconButton(
                                              borderColor: IoT_Theme.of(context)
                                                  .alternate,
                                              borderRadius: 40,
                                              borderWidth: 1,
                                              buttonSize: 50,
                                              fillColor: IoT_Theme.of(context)
                                                  .alternate,
                                              icon: Icon(
                                                Icons.settings_outlined,
                                                color: IoT_Theme.of(context)
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
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 12, 16, 0),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color:
                                        IoT_Theme.of(context).primaryBackground,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        8, 8, 12, 8),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.asset(
                                            'assets/images/Night.png',
                                            width: 70,
                                            height: 70,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16, 0, 0, 0),
                                          child: Text(
                                            ShteyLocalizations.of(context)
                                                .getText(
                                              '4wlnwox5' /* Night */,
                                            ),
                                            style: IoT_Theme.of(context)
                                                .bodyLarge
                                                .override(
                                                  fontFamily: 'Inter',
                                                  letterSpacing: 0,
                                                ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment:
                                                AlignmentDirectional(1, 0),
                                            child: IotIconButton(
                                              borderColor: IoT_Theme.of(context)
                                                  .alternate,
                                              borderRadius: 40,
                                              borderWidth: 1,
                                              buttonSize: 50,
                                              fillColor: IoT_Theme.of(context)
                                                  .alternate,
                                              icon: Icon(
                                                Icons.settings_outlined,
                                                color: IoT_Theme.of(context)
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
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 8, 16, 0),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color:
                                        IoT_Theme.of(context).primaryBackground,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        8, 8, 12, 8),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.asset(
                                            'assets/images/Plants.png',
                                            width: 70,
                                            height: 70,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16, 0, 0, 0),
                                          child: Text(
                                            ShteyLocalizations.of(context)
                                                .getText(
                                              'maf2os6u' /* Plants */,
                                            ),
                                            style: IoT_Theme.of(context)
                                                .bodyLarge
                                                .override(
                                                  fontFamily: 'Inter',
                                                  letterSpacing: 0,
                                                ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment:
                                                AlignmentDirectional(1, 0),
                                            child: IotIconButton(
                                              borderColor: IoT_Theme.of(context)
                                                  .alternate,
                                              borderRadius: 40,
                                              borderWidth: 1,
                                              buttonSize: 50,
                                              fillColor: IoT_Theme.of(context)
                                                  .alternate,
                                              icon: Icon(
                                                Icons.settings_outlined,
                                                color: IoT_Theme.of(context)
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
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 8, 16, 0),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color:
                                        IoT_Theme.of(context).primaryBackground,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        8, 8, 12, 8),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.asset(
                                            'assets/images/Welcome_Home.png',
                                            width: 70,
                                            height: 70,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16, 0, 0, 0),
                                          child: Text(
                                            ShteyLocalizations.of(context)
                                                .getText(
                                              '8x0mj5ui' /* Welcome Home */,
                                            ),
                                            style: IoT_Theme.of(context)
                                                .bodyLarge
                                                .override(
                                                  fontFamily: 'Inter',
                                                  letterSpacing: 0,
                                                ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment:
                                                AlignmentDirectional(1, 0),
                                            child: IotIconButton(
                                              borderColor: IoT_Theme.of(context)
                                                  .alternate,
                                              borderRadius: 40,
                                              borderWidth: 1,
                                              buttonSize: 50,
                                              fillColor: IoT_Theme.of(context)
                                                  .alternate,
                                              icon: Icon(
                                                Icons.settings_outlined,
                                                color: IoT_Theme.of(context)
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
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 8, 16, 0),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color:
                                        IoT_Theme.of(context).primaryBackground,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        8, 8, 12, 8),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.asset(
                                            'assets/images/Wardrobe_Lighting.png',
                                            width: 70,
                                            height: 70,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16, 0, 0, 0),
                                          child: Text(
                                            ShteyLocalizations.of(context)
                                                .getText(
                                              'ehhwxzv4' /* Wardrobe Lighting */,
                                            ),
                                            style: IoT_Theme.of(context)
                                                .bodyLarge
                                                .override(
                                                  fontFamily: 'Inter',
                                                  letterSpacing: 0,
                                                ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment:
                                                AlignmentDirectional(1, 0),
                                            child: IotIconButton(
                                              borderColor: IoT_Theme.of(context)
                                                  .alternate,
                                              borderRadius: 40,
                                              borderWidth: 1,
                                              buttonSize: 50,
                                              fillColor: IoT_Theme.of(context)
                                                  .alternate,
                                              icon: Icon(
                                                Icons.settings_outlined,
                                                color: IoT_Theme.of(context)
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
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 8, 16, 44),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color:
                                        IoT_Theme.of(context).primaryBackground,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        8, 8, 12, 8),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.asset(
                                            'assets/images/Kitchen_Lighting.png',
                                            width: 70,
                                            height: 70,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16, 0, 0, 0),
                                          child: Text(
                                            ShteyLocalizations.of(context)
                                                .getText(
                                              'fsep9m08' /* Kitchen Lighting */,
                                            ),
                                            style: IoT_Theme.of(context)
                                                .bodyLarge
                                                .override(
                                                  fontFamily: 'Inter',
                                                  letterSpacing: 0,
                                                ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment:
                                                AlignmentDirectional(1, 0),
                                            child: IotIconButton(
                                              borderColor: IoT_Theme.of(context)
                                                  .alternate,
                                              borderRadius: 40,
                                              borderWidth: 1,
                                              buttonSize: 50,
                                              fillColor: IoT_Theme.of(context)
                                                  .alternate,
                                              icon: Icon(
                                                Icons.settings_outlined,
                                                color: IoT_Theme.of(context)
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