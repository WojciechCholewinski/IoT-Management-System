import 'package:mobile/models/automation_model.dart';
import 'package:mobile/models/device_model.dart';
import 'package:provider/provider.dart';

import '/app_ui/icon_button.dart';
import '/app_ui/theme.dart';
import '/app_ui/util.dart';
import '/app_ui/widgets.dart';
import 'package:flutter/material.dart';
export 'automation_details_model.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

class AutomationDetailsWidget extends StatefulWidget {
  final int automationId;
  const AutomationDetailsWidget({Key? key, required this.automationId})
      : super(key: key);

  @override
  State<AutomationDetailsWidget> createState() =>
      _AutomationDetailsWidgetState();
}

class _AutomationDetailsWidgetState extends State<AutomationDetailsWidget> {
  late Automation automation;
  // late Device devices;
  // ignore: unused_field
  DateTime _dateTime = DateTime.now();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // _model = createModel(context, () => AutomationDetailsModel());
    // final appState = Provider.of<ShteyAppState>(context, listen: false);
    // automation =
    //     appState.automations.firstWhere((a) => a.id == widget.automationId);

    // final automationId =
    //     int.parse(context.queryParameters['automationId'] ?? '0');
    // final automation = Provider.of<ShteyAppState>(context, listen: false)
    //     .automations
    //     .firstWhere((a) => a.id == automationId);

    final appState = Provider.of<ShteyAppState>(context, listen: false);
    automation =
        appState.automations.firstWhere((a) => a.id == widget.automationId);
    appState.fetchDevicesNames();

    // _model.switchValue = automation.isOn;
    // _model.automationName = automation.name;
    // _model.automationNamePL = automation.namePL;
  }

  @override
  void dispose() {
    // _model.dispose();

    super.dispose();
  }

  Widget timePickerSpinner() {
    DateTime initialTime = automation.parsedTriggerTime;

    return TimePickerSpinner(
      time: initialTime,
      is24HourMode: true,
      normalTextStyle: TextStyle(
        fontSize: 24,
        color: IoT_Theme.of(context).alternate,
      ),
      highlightedTextStyle: TextStyle(
        fontSize: 24,
        color: IoT_Theme.of(context).primaryText,
      ),
      spacing: 1,
      itemHeight: 30,
      isForce2Digits: true,
      alignment: Alignment.center,
      onTimeChange: (time) {
        setState(() {
          _dateTime = time;
        });
      },
    );
  }

  void _showDevicesDialog(BuildContext context) {
    final appState = Provider.of<ShteyAppState>(context, listen: false);

    var availableDevices = appState.devicesNames.where((device) {
      return !automation.devices.any((d) => d.name == device.name);
    }).toList(); // Filter devices not yet in the automation
    // final devices = appState.devices; // Get the list of all available devices
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              // final availableDevices = appState.devicesNames
              //     .where((device) => !automation.devices.contains(device))
              //     .toList(); // Filter devices not yet in the automation

              return AlertDialog(
                title: Text('deviceListTitle'),
                content: SizedBox(
                  width: double.maxFinite,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: availableDevices.length,
                    itemBuilder: (context, index) {
                      final device = availableDevices[index];

                      return ListTile(
                        title: Text(
                          ShteyLocalizations.of(context).languageCode == "en"
                              ? device.name
                              : device.namePL,
                          style: IoT_Theme.of(context).bodyMedium.override(
                                fontFamily: 'Inter',
                                color: IoT_Theme.of(context).primaryText,
                                fontSize: 16.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                        trailing: IotIconButton(
                          borderRadius: 20.0,
                          buttonSize: 40.0,
                          icon: Icon(
                            Icons.add_circle_outline,
                            color: IoT_Theme.of(context).success,
                            size: 24.0,
                          ),
                          onPressed: () {
                            setState(() {
                              automation.devices.add(device);
                              availableDevices = appState.devicesNames
                                  .where((d) => !automation.devices
                                      .any((ad) => ad.name == d.name))
                                  .toList(); // Aktualizuj listę dostępnych urządzeń
                            });
                            this.setState(() {});
                            // Navigator.of(context)
                            //     .pop(); // Close the dialog after removal
                          },
                        ),
                      );
                    },
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Zamknij okienko dialogowe
                    },
                    child: Text('close'),
                  ),
                ],
              );
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<ShteyAppState>(context);
    final automation =
        appState.automations.firstWhere((a) => a.id == widget.automationId);

    return GestureDetector(
      // onTap: () => _model.unfocusNode.canRequestFocus
      //     ? FocusScope.of(context).requestFocus(_model.unfocusNode)
      //     : FocusScope.of(context).unfocus(),
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: IoT_Theme.of(context).primaryBackground,
        floatingActionButton: Align(
          alignment: const AlignmentDirectional(1.0, 1.0),
          child: Padding(
            padding:
                const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 400.0),
            child: FloatingActionButton(
              onPressed: () {
                _showDevicesDialog(context);
              },
              backgroundColor: IoT_Theme.of(context).primaryBackground,
              elevation: 8.0,
              child: Align(
                alignment: const AlignmentDirectional(0.0, 0.0),
                child: Icon(
                  Icons.playlist_add,
                  color: IoT_Theme.of(context).primaryText,
                  size: 30.0,
                ),
              ),
            ),
          ),
        ),
        body: SafeArea(
          top: true,
          child: Align(
            alignment: const AlignmentDirectional(0.0, 0.0),
            child: Padding(
              padding:
                  const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 0.0, 0.0, 26.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IotIconButton(
                          borderRadius: 30.0,
                          buttonSize: 45.0,
                          icon: Icon(
                            Icons.arrow_back_ios_rounded,
                            color: IoT_Theme.of(context).primaryText,
                            size: 22.0,
                          ),
                          onPressed: () async {
                            context.safePop();
                          },
                        ),
                        Align(
                          alignment: const AlignmentDirectional(0.0, 0.0),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 16.0),
                            child: Text(
                              ShteyLocalizations.of(context).getText(
                                'd3t1dj3t' /* Automation Details */,
                              ),
                              style: IoT_Theme.of(context)
                                  .headlineMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    color: IoT_Theme.of(context).primaryText,
                                    fontSize: 18.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        16.0, 0.0, 0.0, 0.0),
                    child: Text(
                      ShteyLocalizations.of(context).languageCode == "en"
                          ? automation.name
                          : automation.namePL,
                      style: IoT_Theme.of(context).titleLarge.override(
                            fontFamily: 'Inter',
                            color: IoT_Theme.of(context).primaryText,
                            fontSize: 30.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        16.0, 0.0, 0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          ShteyLocalizations.of(context).getText(
                            'g9h4mc3r' /* Active */,
                          ),
                          style: IoT_Theme.of(context).bodyMedium.override(
                                fontFamily: 'Inter',
                                color: IoT_Theme.of(context).primaryText,
                                fontSize: 18.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                        Switch(
                          value: automation.isOn,
                          onChanged: (newValue) async {
                            // Dodaj logikę zmiany stanu automatyzacji
                          },
                          activeColor: IoT_Theme.of(context).primaryText,
                          activeTrackColor: IoT_Theme.of(context).secondaryText,
                          inactiveTrackColor:
                              IoT_Theme.of(context).primaryBackground,
                          inactiveThumbColor:
                              IoT_Theme.of(context).secondaryText,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 30.0, 0.0, 10.0),
                    child: Text(
                      ShteyLocalizations.of(context).getText(
                        'usbnwlnd' /* Select days: */,
                      ),
                      style: IoT_Theme.of(context).titleLarge.override(
                            fontFamily: 'Inter',
                            color: IoT_Theme.of(context).primaryText,
                            fontSize: 15.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: AspectRatio(
                            aspectRatio:
                                1.0, // Proporcja 1:1 zapewniająca kształt koła
                            child: DaySelectionButton(
                              context: context,
                              text: ShteyLocalizations.of(context)
                                  .getText('m9miabzw' /* Mon */),
                              isSelected: automation.temporarySelectedDays
                                  .contains('Monday'),
                              onPressed: () async {
                                setState(() {
                                  if (automation.temporarySelectedDays
                                      .contains('Monday')) {
                                    automation.temporarySelectedDays
                                        .remove('Monday');
                                  } else {
                                    automation.temporarySelectedDays
                                        .add('Monday');
                                  }
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: AspectRatio(
                            aspectRatio:
                                1.0, // Proporcja 1:1 zapewniająca kształt koła
                            child: DaySelectionButton(
                              context: context,
                              text: ShteyLocalizations.of(context)
                                  .getText('0fmj2kgr' /* Tue */),
                              isSelected: automation.temporarySelectedDays
                                  .contains('Tuesday'),
                              onPressed: () async {
                                setState(() {
                                  if (automation.temporarySelectedDays
                                      .contains('Tuesday')) {
                                    automation.temporarySelectedDays
                                        .remove('Tuesday');
                                  } else {
                                    automation.temporarySelectedDays
                                        .add('Tuesday');
                                  }
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: AspectRatio(
                            aspectRatio:
                                1.0, // Proporcja 1:1 zapewniająca kształt koła
                            child: DaySelectionButton(
                              context: context,
                              text: ShteyLocalizations.of(context)
                                  .getText('0c7mmagq' /* Wed */),
                              isSelected: automation.temporarySelectedDays
                                  .contains('Wednesday'),
                              onPressed: () async {
                                setState(() {
                                  if (automation.temporarySelectedDays
                                      .contains('Wednesday')) {
                                    automation.temporarySelectedDays
                                        .remove('Wednesday');
                                  } else {
                                    automation.temporarySelectedDays
                                        .add('Wednesday');
                                  }
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: AspectRatio(
                            aspectRatio:
                                1.0, // Proporcja 1:1 zapewniająca kształt koła
                            child: DaySelectionButton(
                              context: context,
                              text: ShteyLocalizations.of(context)
                                  .getText('84ff23w4' /* Thu */),
                              isSelected: automation.temporarySelectedDays
                                  .contains('Thursday'),
                              onPressed: () async {
                                setState(() {
                                  if (automation.temporarySelectedDays
                                      .contains('Thursday')) {
                                    automation.temporarySelectedDays
                                        .remove('Thursday');
                                  } else {
                                    automation.temporarySelectedDays
                                        .add('Thursday');
                                  }
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: AspectRatio(
                            aspectRatio:
                                1.0, // Proporcja 1:1 zapewniająca kształt koła
                            child: DaySelectionButton(
                              context: context,
                              text: ShteyLocalizations.of(context)
                                  .getText('ky402mn0' /* Fri */),
                              isSelected: automation.temporarySelectedDays
                                  .contains('Friday'),
                              onPressed: () async {
                                setState(() {
                                  if (automation.temporarySelectedDays
                                      .contains('Friday')) {
                                    automation.temporarySelectedDays
                                        .remove('Friday');
                                  } else {
                                    automation.temporarySelectedDays
                                        .add('Friday');
                                  }
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: AspectRatio(
                            aspectRatio:
                                1.0, // Proporcja 1:1 zapewniająca kształt koła
                            child: DaySelectionButton(
                              context: context,
                              text: ShteyLocalizations.of(context)
                                  .getText('9wuxhajc' /* Sat */),
                              isSelected: automation.temporarySelectedDays
                                  .contains('Saturday'),
                              onPressed: () async {
                                setState(() {
                                  if (automation.temporarySelectedDays
                                      .contains('Saturday')) {
                                    automation.temporarySelectedDays
                                        .remove('Saturday');
                                  } else {
                                    automation.temporarySelectedDays
                                        .add('Saturday');
                                  }
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: AspectRatio(
                            aspectRatio:
                                1.0, // Proporcja 1:1 zapewniająca kształt koła
                            child: DaySelectionButton(
                              context: context,
                              text: ShteyLocalizations.of(context)
                                  .getText('ayddrvfp' /* Sun */),
                              isSelected: automation.temporarySelectedDays
                                  .contains('Sunday'),
                              onPressed: () async {
                                setState(() {
                                  if (automation.temporarySelectedDays
                                      .contains('Sunday')) {
                                    automation.temporarySelectedDays
                                        .remove('Sunday');
                                  } else {
                                    automation.temporarySelectedDays
                                        .add('Sunday');
                                  }
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 20.0, 0.0, 5.0),
                    child: Text(
                      ShteyLocalizations.of(context).getText(
                        'uybdasex' /* Set Time: */,
                      ),
                      style: IoT_Theme.of(context).titleLarge.override(
                            fontFamily: 'Inter',
                            color: IoT_Theme.of(context).primaryText,
                            fontSize: 15.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                  timePickerSpinner(),
                  // IotIconButton(
                  //   borderColor: Colors.transparent,
                  //   borderRadius: 20.0,
                  //   buttonSize: 40.0,
                  //   icon: Icon(
                  //     Icons.remove_circle_outline,
                  //     color: IoT_Theme.of(context).error,
                  //     size: 24.0,
                  //   ),
                  //   onPressed: () {
                  //     print('IconButton pressed ...');
                  //   },
                  // ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 20.0, 0.0, 0.0),
                    child: Text(
                      ShteyLocalizations.of(context).getText(
                        'ki34z6bq' /* Included Devices */,
                      ),
                      style: IoT_Theme.of(context).titleLarge.override(
                            fontFamily: 'Inter',
                            color: IoT_Theme.of(context).primaryText,
                            fontSize: 20.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: automation.devices.length,
                      itemBuilder: (context, index) {
                        final device = automation.devices[index];
                        return Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              8.0, 0.0, 8.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                ShteyLocalizations.of(context).languageCode ==
                                        "en"
                                    ? device.name
                                    : device.namePL,
                                style: IoT_Theme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Inter',
                                      color: IoT_Theme.of(context).primaryText,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                              IotIconButton(
                                borderRadius: 20.0,
                                buttonSize: 40.0,
                                icon: Icon(
                                  Icons.remove_circle_outline,
                                  color: IoT_Theme.of(context).error,
                                  size: 24.0,
                                ),
                                onPressed: () {
                                  setState(() {
                                    automation.devices.removeAt(index);
                                  });
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        16.0, 0.0, 16.0, 16.0),
                    child: ShteyButtonWidget(
                      onPressed: () {
                        appState.resetDaysSelection();
                        context.safePop();
                      },
                      text: ShteyLocalizations.of(context).getText(
                        'rq1mzqny' /* Save */,
                      ),
                      options: ShteyButtonOptions(
                        width: double.infinity,
                        height: 55.0,
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 0.0, 0.0, 0.0),
                        iconPadding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 0.0, 0.0, 0.0),
                        color: IoT_Theme.of(context).primary,
                        textStyle: IoT_Theme.of(context).titleMedium.override(
                              fontFamily: 'Inter',
                              color: Colors.white,
                              letterSpacing: 0.0,
                            ),
                        elevation: 2.0,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
