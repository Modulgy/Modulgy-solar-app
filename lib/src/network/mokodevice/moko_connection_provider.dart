import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:moduluenergy/src/network/mokodevice/moko_connection_service.dart';
import 'package:moduluenergy/src/network/mokodevice/moko_models.dart';

import '../../../generated/l10n.dart';
import '../../database/database_helper.dart';
import '../../utils/utils.dart';
import '../../views/devices/Device.dart';
import '../result.dart';

enum DeviceConnectionStatus {
  idle,
  connecting,
  connected,
  error
}

enum DeviceConfigurationStep {
  idle,
  enquiryDeviceInfo,
  configureMQTTInformation,
  sendSSLFile,
  setPublishAndSubscribeTopic,
  configureWifi
}

Map<DeviceConfigurationStep, String> configurationStepDescriptions = {
  DeviceConfigurationStep.idle: 'Idle',
  DeviceConfigurationStep.enquiryDeviceInfo: 'Getting Device information...',
  DeviceConfigurationStep.configureMQTTInformation: 'Configuring MQTT parameters...',
  DeviceConfigurationStep.sendSSLFile: 'Sending SSL files...',
  DeviceConfigurationStep.setPublishAndSubscribeTopic: 'Setting up MQTT topics...',
  DeviceConfigurationStep.configureWifi: 'Configuring WiFi parameters...'
};

class MokoConnectionProvider with ChangeNotifier {
  static const String mokoDeviceHost = "192.168.4.1";
  static const int mokoDevicePort = 8266;
  static const awsHost = 'a1avzbmryjv42h-ats.iot.eu-west-1.amazonaws.com';
  static const awsPort = 8883;
  static const int keepAlive = 120;
  static const int qos = 1;
  static const int cleanSession = 1;
  static const int selfSignedCertificates = 3;

  DeviceConnectionStatus _connectionStatus = DeviceConnectionStatus.idle;
  DeviceConnectionStatus get connectionStatus => _connectionStatus;

  DeviceConfigurationStep _configurationStep = DeviceConfigurationStep.idle;
  DeviceConfigurationStep get configurationStep => _configurationStep;

  Future<Result> configureMQTTParameters(String uuid) async {
    final mokoConnectionService = MokoConnectionService(mokoDeviceHost, mokoDevicePort);

    Result result = Success("");

    _updateStatus(DeviceConnectionStatus.connecting, DeviceConfigurationStep.enquiryDeviceInfo);
    var deviceInfo = await mokoConnectionService.enquiryDeviceInfo();
    if (deviceInfo is Error) {
      return _handleError(deviceInfo, DeviceConfigurationStep.enquiryDeviceInfo);
    }

    _updateStep(DeviceConfigurationStep.configureMQTTInformation);
    var mqttInfoRequest = _getMQTTInformationRequest(uuid);
    var mqttInfo = await mokoConnectionService.configureMQTTInformation(mqttInfoRequest);

    if (mqttInfo is Error) {
      return _handleError(mqttInfo, DeviceConfigurationStep.configureMQTTInformation);
    }

    _updateStep(DeviceConfigurationStep.sendSSLFile);
    var sslFileResult = await _configureSSLAuthentication(mokoConnectionService);
    if (sslFileResult is Error) {
      return _handleError(sslFileResult, DeviceConfigurationStep.sendSSLFile);
    }

    _updateStep(DeviceConfigurationStep.setPublishAndSubscribeTopic);
    var topicSetupResult = await mokoConnectionService.setPublishAndSubscribeTopic(
        PublishSubscribeRequest(
          publishTopic: "prod-energy_meter/energy/production",
          subscribeTopic: "topicfilter/test",
        )
    );

    if (topicSetupResult is Error) {
      return _handleError(topicSetupResult, DeviceConfigurationStep.setPublishAndSubscribeTopic);
    }

    _updateStep(DeviceConfigurationStep.configureWifi);
    return result;
  }

  Future<Result> _configureSSLAuthentication(MokoConnectionService service) async {
    const caFilePath = 'assets/ca.pem';
    const certFilePath = 'assets/cert.pem.crt';
    const keyFilePath = 'assets/private.pem.key';

    debugPrint("Sending CA file...");
    var caUploadResult = await service.sendSSLFileData(SSLFileType.caRootCertificate, caFilePath);
    if (caUploadResult is Error) {
      return caUploadResult;
    }

    var certUploadResult = await service.sendSSLFileData(SSLFileType.clientCertificate, certFilePath);
    if (certUploadResult is Error) {
      return certUploadResult;
    }

    var keyUploadResult = await service.sendSSLFileData(SSLFileType.clientPrivateKey, keyFilePath);
    if (keyUploadResult is Error) {
      return keyUploadResult;
    }

    return Success("Successfully uploaded SSL files!");
  }

  Future<Result> configureWifiInformation(String ssid, String password) async {
    final mokoConnectionService = MokoConnectionService(mokoDeviceHost, mokoDevicePort);

    Result result = Success("");
    var wifiConfigurationRequest = WifiInformationSetupRequest(
        wifi_ssid: ssid,
        wifi_pwd: password,
        wifi_security: 2 // has to be WPA
    );

    var wifiConfigurationResult = await mokoConnectionService.setWifiInformation(wifiConfigurationRequest);
    print("wifi result $wifiConfigurationResult");

    if (wifiConfigurationResult is Error) {
      return _handleError(wifiConfigurationResult, DeviceConfigurationStep.configureWifi);
    }

    _connectionStatus = DeviceConnectionStatus.connected;
    notifyListeners();
    return result;
  }

  MQTTInformationRequest _getMQTTInformationRequest(String clientId) {
    return MQTTInformationRequest(
      host: awsHost,
      port: awsPort,
      connectMode: selfSignedCertificates,
      clientId: clientId,
      username: "",
      password: "",
      keepAlive: keepAlive,
      qos: qos,
      cleanSession: cleanSession,
    );
  }

  Error _handleError(Object obj, DeviceConfigurationStep step) {
    _connectionStatus = DeviceConnectionStatus.error;
    _configurationStep = DeviceConfigurationStep.idle;
    notifyListeners();
    String errorMessage = Localized.current.error_operation(step.toString(), obj.toString());
    return Error(errorMessage);
  }

  void _updateStatus(DeviceConnectionStatus status, DeviceConfigurationStep step) {
    _connectionStatus = status;
    _configurationStep = step;
    notifyListeners();
  }

  void _updateStep(DeviceConfigurationStep step) {
    _configurationStep = step;
    notifyListeners();
  }
}