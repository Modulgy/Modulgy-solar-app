import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moduluenergy/main.dart';
import 'package:moduluenergy/src/network/mokodevice/moko_connection_provider.dart';
import 'package:moduluenergy/src/network/result.dart';
import 'package:moduluenergy/src/utils/spacing_extensions.dart';
import 'package:moduluenergy/src/utils/user_preferences.dart';
import 'package:provider/provider.dart';
import 'package:wifi_iot/wifi_iot.dart';
import 'package:wifi_scan/wifi_scan.dart';

import '../../../generated/l10n.dart';
import '../../network/models.dart';
import '../../network/mokodevice/moko_models.dart';
import '../../utils/utils.dart';
import '../../widgets/app_button.dart';
import '../auth/login_components.dart';

class ConnectDeviceScreen extends StatefulWidget {
  const ConnectDeviceScreen({super.key});

  @override
  State<ConnectDeviceScreen> createState() => _ConnectDeviceScreenState();
}

class _ConnectDeviceScreenState extends State<ConnectDeviceScreen> {
  var _wifiList = <WiFiAccessPoint>[];
  final mokoWifiRegEx = RegExp(r'^MK117.*');
  final mokoApWifiPassword = "Moko4321";
  late String mokoApSsid = "";
  int _selectedIndex = -1; // Track the selected index
  TextEditingController ssidController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isConnected = false;
  String _connectionMessage = '';

  late UserData currentUser;

  @override
  void initState() {
    UserPreferences().getUser().then((user) => {
          setState(() {
            currentUser = user;
          })
        });
    // Wifi Scan only supported on Android :/
    if (Platform.isAndroid) {
      _startScan();
      _getScannedResults();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.fromLTRB(20, 70, 20, 20),
      child: BodyWidget(),
    ));
  }

  Widget availableDevicesList(List<WiFiAccessPoint> deviceList) {
    return _wifiList.isEmpty
        ? Expanded(
            child: Center(
                child: Text(
            Localized.of(context).no_wifi_devices,
            style: const TextStyle(fontSize: 18),
          )))
        : Expanded(
            child: ListView.builder(
                itemCount: _wifiList.length,
                itemBuilder: (context, index) {
                  final isSelected =
                      index == _selectedIndex; // Check if the item is selected
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (index == _selectedIndex) {
                          _selectedIndex = -1;
                          mokoApSsid = "";
                        } else {
                          _selectedIndex = index; // Update the selected index
                          mokoApSsid = _wifiList[index].ssid;
                        }
                      });
                    },
                    child: ListTile(
                        title: Text(_wifiList[index].ssid),
                        subtitle: Text(_wifiList[index].bssid),
                        trailing: isSelected
                            ? const Icon(Icons.check_circle,
                                color: ModulgyApp.primaryColor)
                            : null // Highlight the selected item
                        ),
                  );
                }));
  }

  Widget loadingView(MokoConnectionProvider provider) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
                height: 64,
                width: 64,
                child: CircularProgressIndicator(
                  strokeWidth: 5,
                )).marginBottom(30),
            Text(
              configurationStepDescriptions[provider.configurationStep] ??
                  Localized.of(context).connecting,
              style:
                  const TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0),
            )
          ],
        ),
      ),
    );
  }

  Widget BodyWidget() {
    MokoConnectionProvider connectionProvider =
        Provider.of<MokoConnectionProvider>(context);

    return Column(
      children: [
        Transform.translate(
          offset: const Offset(-12.0, 0.0),
          child: Row(
            children: [
              IconButton(
                  onPressed: () => {Navigator.pop(context)},
                  icon: Icon(
                    Icons.arrow_back,
                    size: 28,
                    color: Colors.black.withOpacity(0.5),
                  )),
              const Spacer()
            ],
          ),
        ),
        Row(children: [
          Expanded(
              flex: 5,
              child: WelcomeHeader(Localized.of(context).connect_to_device,
                  Localized.of(context).press_power_button_text)),
          Platform.isAndroid
              ? Flexible(
                  child: IconButton(
                      onPressed: () => {_startScan(), _getScannedResults()},
                      icon: const Icon(
                        Icons.refresh,
                        size: 32,
                        color: Colors.black,
                      )))
              : Container(),
        ]),
        if (connectionProvider.connectionStatus ==
            DeviceConnectionStatus.connecting)
          loadingView(connectionProvider)
        else if (Platform.isAndroid)
          availableDevicesList(_wifiList)
        else if (Platform.isIOS)
          showiOSPromptToConnectToWifi(),
        ModulgyButton(
            title: Localized.of(context).connect_button,
            buttonState: ((Platform.isAndroid && _selectedIndex == -1 ||
                    connectionProvider.connectionStatus ==
                        DeviceConnectionStatus.connecting))
                ? ButtonState.disabled
                : ButtonState.enabled,
            onPressed: () => {
                  if (Platform.isAndroid)
                    {
                      startConnectionFlow(_wifiList[_selectedIndex],
                          connectionProvider, currentUser.uuid, null)
                    }
                  else
                    {
                      startConnectionFlowiOS(
                          connectionProvider, currentUser.uuid)
                    }
                }).marginOnly(bottom: 20),
        if (_connectionMessage.isNotEmpty)
          Text(
            _connectionMessage,
            style: TextStyle(
                color: _isConnected ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold),
          )
      ],
    );
  }

  void _startScan() async {
    // check platform support and necessary requirements
    final can = await WiFiScan.instance.canStartScan(askPermissions: true);
    switch (can) {
      case CanStartScan.yes:
        // start full scan async-ly
        await WiFiScan.instance.startScan();
        break;
      case CanStartScan.noLocationPermissionDenied:
      case CanStartScan.noLocationPermissionRequired:
      case CanStartScan.notSupported:
        showSnackbarError("Error: ${can.toString()}");
        break;
      case CanStartScan.noLocationPermissionUpgradeAccuracy:
        showSnackbarError(Localized.current.location_permission_error);
        break;
      case CanStartScan.noLocationServiceDisabled:
        showSnackbarError(Localized.current.location_service_error);
        break;
      case CanStartScan.failed:
        showSnackbarError(Localized.current.scan_start_error);
        break;
    }
  }

  void showSnackbarError(String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
      ),
    );
  }

  void _getScannedResults() async {
    // check platform support and necessary requirements
    final can =
        await WiFiScan.instance.canGetScannedResults(askPermissions: true);
    switch (can) {
      case CanGetScannedResults.yes:
        // get scanned results
        final accessPoints = await WiFiScan.instance.getScannedResults();
        setState(() {
          _wifiList = accessPoints
              .where((element) => mokoWifiRegEx.hasMatch(element.ssid))
              .toList();
        });
        debugPrint(accessPoints.toString());
        break;
      case CanGetScannedResults.notSupported:
        showSnackbarError("Error: ${can.toString()}");
        break;
      case CanGetScannedResults.noLocationPermissionRequired:
        showSnackbarError(Localized.current.location_permission_error);
        break;
      case CanGetScannedResults.noLocationPermissionDenied:
        showSnackbarError(Localized.current.location_permission_error);
        break;
      case CanGetScannedResults.noLocationPermissionUpgradeAccuracy:
        showSnackbarError(Localized.current.location_permission_error);
        break;
      case CanGetScannedResults.noLocationServiceDisabled:
        showSnackbarError(Localized.current.location_service_error);
        break;
    }
  }

  void startConnectionFlow(
      WiFiAccessPoint accessPoint,
      MokoConnectionProvider provider,
      String userUuid,
      bool? continueConnection) async {
    var wifiConnectionResult = Platform.isAndroid
        ? await WiFiForIoTPlugin.connect(accessPoint.ssid,
            password: mokoApWifiPassword, security: NetworkSecurity.WPA)
        : true;
    debugPrint("Wifi Connection result is: $wifiConnectionResult");

    if (wifiConnectionResult) {
      var forceWifiResult = await WiFiForIoTPlugin.forceWifiUsage(true);
      debugPrint("Force Wifi result is: $forceWifiResult");

      if (continueConnection == false) return;

      _mqttConnectionInternal(provider, userUuid);
    } else {
      showSnackbarError(Localized.current.wifi_connection_error);
    }
  }

  void startConnectionFlowiOS(
      MokoConnectionProvider provider, String userUuid) async {
    _mqttConnectionInternal(provider, userUuid);
  }

  Future<bool> _checkSSIDAvailability(String ssid) async {
    final accessPoints = await WiFiScan.instance.getScannedResults();
    for (var network in accessPoints) {
      print(network.ssid);
      if (network.ssid == ssid) {
        return true;
      }
    }
    return false;
  }

  void _mqttConnectionInternal(
      MokoConnectionProvider provider, String userUuid) async {
    var mqttParametersConfigurationResult =
        await provider.configureMQTTParameters(userUuid);
    debugPrint(
        "MQTT Parameters configuration result is: $mqttParametersConfigurationResult");

    if (mqttParametersConfigurationResult is Success) {
      // now we're going to ask the wifi credentials.
      showWifiDialog(context, (ssid, password) async {
        print(ssid);
        bool ssidAval = await _checkSSIDAvailability(ssid);
        bool connected = await _connectToWiFi(ssid, password);

        if (!ssidAval || !connected) {
          print(ssidAval);
          print(connected);
          showSnackbarError("Não foi possível conectar à rede fornecida.");
          setState(() {
            _isConnected = false;
            _connectionMessage = "Erro ao conectar à rede fornecida.";
          });
          return;
        }

        connected = await _connectToWiFi(mokoApSsid, mokoApWifiPassword);

        if (!connected) {
          showSnackbarError(Localized.current.wifi_connection_error);
          setState(() {
            _isConnected = false;
            _connectionMessage = "Erro ao conectar à rede fornecida.";
          });
          return;
        }

        Utils.saveDeviceToDatabase(
            mqttParametersConfigurationResult.data as EnquiryDeviceInfoResponse,
            true);

        provider
            .configureWifiInformation(ssid, password)
            .then((Result wifiParametersConfigurationResult) async {
          if (wifiParametersConfigurationResult is Success) {
            await _connectToWiFi(ssid, password);
            await Future.delayed(const Duration(seconds: 10));
            setState(() {
              _isConnected = true;
              _connectionMessage =
                  Localized.current.device_configuration_success;
            });
          } else {
            await _connectToWiFi(ssid, password);
            setState(() {
              _isConnected = false;
              _connectionMessage = Localized.current
                  .wifi_parameters_configuration_error(
                      (wifiParametersConfigurationResult as Error)
                          .errorMessage);
            });
          }
        });
      });
    } else {
      showSnackbarError(Localized.current.wifi_parameters_configuration_error(
          (mqttParametersConfigurationResult as Error).errorMessage));
    }
  }

  Future<bool> _connectToWiFi(String ssid, String password) async {
    bool isConnected = false;
    try {
      isConnected = await WiFiForIoTPlugin.connect(ssid,
          password: password,
          security: NetworkSecurity.WPA,
          withInternet: true);
      WiFiForIoTPlugin.forceWifiUsage(true);
    } catch (e) {
      debugPrint("Error connecting to wifi: $e");
    }
    return isConnected;
  }

  void showWifiDialog(
      BuildContext context, void Function(String, String) onSubmitted) {
    final _formKey = GlobalKey<FormState>();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Localized.current.wifi_setup),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: ssidController,
                  decoration: InputDecoration(
                    labelText: Localized.current.network_name_label,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return Localized.current.empty_ssid_error;
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: Localized.current.password_hint,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return Localized.current.empty_password_error;
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.of(context).pop();
                  onSubmitted(ssidController.text, passwordController.text);
                }
              },
              child: Text(Localized.current.save_button),
            ),
          ],
        );
      },
    );
  }

  Widget showiOSPromptToConnectToWifi() {
    return Expanded(
        child: Column(
      children: [
        Container(
          height: 150,
          child: Center(
              child: const Icon(
            Icons.wifi,
            size: 80,
          ).marginBottom(16)),
        ), // Replace with the actual image path,
        RichText(
          text: TextSpan(
            style: TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontFamily: GoogleFonts.urbanist().fontFamily,
                height: 1.5),
            children: <TextSpan>[
              TextSpan(
                text: Localized.current.connection_instructions,
                style: const TextStyle(fontWeight: FontWeight.normal),
              ),
              TextSpan(
                text: Localized.current.connection_step1 +
                    Localized.current.connection_step2 +
                    Localized.current.connection_step3 +
                    Localized.current.connection_step4,
                style: const TextStyle(fontWeight: FontWeight.normal),
              ),
              const TextSpan(
                text: 'Moko4321',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: '.\n${Localized.current.connection_step5}',
                style: const TextStyle(fontWeight: FontWeight.normal),
              ),
              TextSpan(
                text: Localized.current.connect_button,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const TextSpan(
                text: '.',
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ).marginBottom(16),
        TextButton(
          onPressed: () {
            AppSettings.openWIFISettings();
          },
          child: Text(
            Localized.current.open_settings_button,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ],
    ));
  }
}
