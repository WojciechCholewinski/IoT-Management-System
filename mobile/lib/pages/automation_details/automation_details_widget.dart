import 'package:mobile/models/automation/automation_model.dart';
import 'package:provider/provider.dart';

import '../../app_ui/toggle_icon.dart';
import '../../models/automation/automation_update_model.dart';
import '../../models/device/device_name_model.dart';
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
  late TextEditingController _nameController;
  late bool _isOnState;
  // ignore: unused_field
  DateTime _dateTime = DateTime.now();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    final appState = Provider.of<ShteyAppState>(context, listen: false);
    automation =
        appState.automations.firstWhere((a) => a.id == widget.automationId);
    _isOnState = automation.isOn;
    appState.fetchDevicesNames();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final languageCode = ShteyLocalizations.of(context).languageCode;
    _nameController = TextEditingController(
      text: languageCode == "en" ? automation.name : automation.namePL,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  // Dodanie urządzenia do listy `DevicesToTurnOn`
  void _onDeviceAddedToTurnOn(DeviceName device) {
    final appState = Provider.of<ShteyAppState>(context, listen: false);
    appState.addDeviceToTurnOnList(
        device); // Dodanie do `DevicesToTurnOn` i usunięcie z `DevicesToTurnOff`
    setState(() {
      automation.devicesToTurnOn.add(device);
    });
  }

  // Dodanie urządzenia do listy `DevicesToTurnOff`
  void _onDeviceAddedToTurnOff(DeviceName device) {
    final appState = Provider.of<ShteyAppState>(context, listen: false);
    appState.addDeviceToTurnOffList(
        device); // Dodanie do `DevicesToTurnOff` i usunięcie z `DevicesToTurnOn`
    setState(() {
      automation.devicesToTurnOff.add(device);
    });
  }

  // Usunięcie urządzenia z listy `DevicesToTurnOn`
  void _onDeviceRemovedFromTurnOn(DeviceName device) {
    final appState = Provider.of<ShteyAppState>(context, listen: false);
    appState.removeDeviceFromTurnOnList(device);
    setState(() {
      automation.devicesToTurnOn.remove(device);
    });
  }

  // Usunięcie urządzenia z listy `DevicesToTurnOff`
  void _onDeviceRemovedFromTurnOff(DeviceName device) {
    final appState = Provider.of<ShteyAppState>(context, listen: false);
    appState.removeDeviceFromTurnOffList(device);
    setState(() {
      automation.devicesToTurnOff.remove(device);
    });
  }

  void _onSave() async {
    final appState = Provider.of<ShteyAppState>(context, listen: false);
    final triggerTimeFormatted =
        _dateTime.toIso8601String().split('T').last.split('.').first;

    final languageCode = ShteyLocalizations.of(context).languageCode;

    final updateModel = AutomationUpdateModel(
      name: languageCode == "en" ? _nameController.text : automation.name,
      namePL: languageCode == "pl" ? _nameController.text : automation.namePL,
      triggerDays: automation.temporarySelectedDays,
      triggerTime: triggerTimeFormatted,
      isOn: _isOnState,
    );

    await appState.updateAutomation(
      automation,
      updateModel,
    );
    await appState.saveDeviceChanges(automation.id);

    Navigator.of(context).pop();
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

  // Wyświetlanie dialogu wyboru urządzeń do dodania
  void _showDevicesDialog(
      BuildContext context, Function(DeviceName) onDeviceAdded) {
    final appState = Provider.of<ShteyAppState>(context, listen: false);
    var availableDevices = appState
        .getAvailableDevices(automation); // Przekaż aktualną automatyzację

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return AlertDialog(
                title: Text(
                  ShteyLocalizations.of(context).getText(
                    '0jp8ufnw' /* Device List */,
                  ),
                ),
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
                            onDeviceAdded(device);
                            setState(() {
                              availableDevices.remove(
                                  device); // Usunięcie urządzenia z listy po dodaniu
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
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
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: IoT_Theme.of(context).primaryBackground,
        // floatingActionButton: Align(
        //   alignment: const AlignmentDirectional(1.0, 1.0),
        //   child: Padding(
        //     padding:
        //         const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 400.0),
        //     child: FloatingActionButton(
        //       onPressed: () {
        //         _showDevicesDialog(context);
        //       },
        //       backgroundColor: IoT_Theme.of(context).primaryBackground,
        //       elevation: 8.0,
        //       child: Align(
        //         alignment: const AlignmentDirectional(0.0, 0.0),
        //         child: Icon(
        //           Icons.playlist_add,
        //           color: IoT_Theme.of(context).primaryText,
        //           size: 30.0,
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
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
                            appState.clearTemporaryLists();
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
                        5.0, 0.0, 0.0, 0.0),
                    child: Stack(
                      children: [
                        Align(
                          // Wyśrodkowanie TextField względem Column
                          alignment: Alignment.center,
                          child: TextField(
                            controller: _nameController,
                            textAlign: TextAlign.center,
                            style: IoT_Theme.of(context).titleLarge.override(
                                  fontFamily: 'Inter',
                                  color: IoT_Theme.of(context).primaryText,
                                  fontSize: 30.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Align(
                          // Ustawienie ToggleIcon w prawym rogu
                          alignment: Alignment.centerRight,
                          child: ToggleIcon(
                            onPressed: () {
                              setState(() {
                                _isOnState = !_isOnState;
                              });
                            },
                            value: _isOnState,
                            onIcon: Icon(
                              Icons.toggle_on_outlined,
                              color: IoT_Theme.of(context).primary,
                            ),
                            offIcon: Icon(
                              Icons.toggle_off_outlined,
                              color: IoT_Theme.of(context).secondaryText,
                            ),
                          ),
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
                  //
                  //
                  //
                  SizedBox(
                    height:
                        56.0, // Wymuszenie wysokości dla całego Stacka, aby dopasować do przycisku
                    child: Stack(
                      children: [
                        Align(
                          // Wyśrodkowanie TextField względem Column
                          alignment: Alignment.center,
                          child: Text(
                            ShteyLocalizations.of(context).getText(
                              'ki34z6bq' /* Turn On  */,
                            ),
                            style: automation.devicesToTurnOn.isNotEmpty
                                ? IoT_Theme.of(context).titleLarge.override(
                                      fontFamily: 'Inter',
                                      color: IoT_Theme.of(context).primaryText,
                                      fontSize: 20.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                    )
                                : IoT_Theme.of(context).titleLarge.override(
                                      fontFamily: 'Inter',
                                      color:
                                          IoT_Theme.of(context).secondaryText,
                                      fontSize: 20.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                        ),
                        Align(
                          // Ustawienie ToggleIcon w prawym rogu
                          alignment: Alignment.centerRight,
                          child: IotIconButton(
                            borderRadius: 26.0,
                            buttonSize: 56.0,
                            borderWidth: 0, // Brak obramowania
                            // borderColor: IoT_Theme.of(context).primaryText,
                            fillColor: IoT_Theme.of(context)
                                .primaryBackground, // Kolor tła
                            icon: Icon(
                              Icons.format_list_bulleted_add,
                              color: IoT_Theme.of(context).success,
                              size: 30.0, // Rozmiar ikony
                            ),
                            onPressed: () {
                              _showDevicesDialog(
                                  context, _onDeviceAddedToTurnOn);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: automation.devicesToTurnOn
                        .length, // Ustawienie flex w zależności od liczby urządzeń
                    child: automation.devicesToTurnOn.isNotEmpty
                        ? ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: automation.devicesToTurnOn.length,
                            itemBuilder: (context, index) {
                              final device = automation.devicesToTurnOn[index];
                              return Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    8.0, 0.0, 8.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      ShteyLocalizations.of(context)
                                                  .languageCode ==
                                              "en"
                                          ? device.name
                                          : device.namePL,
                                      style: IoT_Theme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Inter',
                                            color: IoT_Theme.of(context)
                                                .primaryText,
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
                                        _onDeviceRemovedFromTurnOn(device);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          )
                        : Text(
                            ShteyLocalizations.of(context).getText(
                              'lzgzah3i' /* No devices to turn on  */,
                            ),
                            style: IoT_Theme.of(context).bodyMedium.override(
                                  fontFamily: 'Inter',
                                  color: IoT_Theme.of(context).secondaryText,
                                  fontSize: 16.0,
                                ),
                          ),
                  ),

                  SizedBox(
                    height:
                        56.0, // Wymuszenie wysokości dla całego Stacka, aby dopasować do przycisku
                    child: Stack(
                      children: [
                        Align(
                          // Wyśrodkowanie TextField względem Column
                          alignment: Alignment.center,
                          child: Text(
                            ShteyLocalizations.of(context).getText(
                              'fs395hwm' /* Turn Off  */,
                            ),
                            style: automation.devicesToTurnOff.isNotEmpty
                                ? IoT_Theme.of(context).titleLarge.override(
                                      fontFamily: 'Inter',
                                      color: IoT_Theme.of(context).primaryText,
                                      fontSize: 20.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                    )
                                : IoT_Theme.of(context).titleLarge.override(
                                      fontFamily: 'Inter',
                                      color:
                                          IoT_Theme.of(context).secondaryText,
                                      fontSize: 20.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                        ),
                        Align(
                          // Ustawienie ToggleIcon w prawym rogu
                          alignment: Alignment.centerRight,
                          child: IotIconButton(
                            borderRadius: 26.0,
                            buttonSize: 56.0,
                            borderWidth: 0, // Brak obramowania
                            // borderColor: IoT_Theme.of(context).primaryText,
                            fillColor: IoT_Theme.of(context)
                                .primaryBackground, // Kolor tła
                            icon: Icon(
                              Icons.format_list_bulleted_add,
                              color: IoT_Theme.of(context).success,
                              size: 30.0, // Rozmiar ikony
                            ),
                            onPressed: () {
                              _showDevicesDialog(
                                  context, _onDeviceAddedToTurnOff);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    flex: automation.devicesToTurnOff
                        .length, // Flex zależny od liczby urządzeń w drugiej liście
                    child: automation.devicesToTurnOff.isNotEmpty
                        ? ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: automation.devicesToTurnOff.length,
                            itemBuilder: (context, index) {
                              final device = automation.devicesToTurnOff[index];
                              return Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    8.0, 0.0, 8.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      ShteyLocalizations.of(context)
                                                  .languageCode ==
                                              "en"
                                          ? device.name
                                          : device.namePL,
                                      style: IoT_Theme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Inter',
                                            color: IoT_Theme.of(context)
                                                .primaryText,
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
                                        _onDeviceRemovedFromTurnOff(device);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          )
                        : Text(
                            ShteyLocalizations.of(context).getText(
                              '4neufju5' /* No devices to turn off  */,
                            ),
                            style: IoT_Theme.of(context).bodyMedium.override(
                                  fontFamily: 'Inter',
                                  color: IoT_Theme.of(context).secondaryText,
                                  fontSize: 16.0,
                                ),
                          ),
                  ),

                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        16.0, 0.0, 16.0, 16.0),
                    child: ShteyButtonWidget(
                      onPressed: _onSave,
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
