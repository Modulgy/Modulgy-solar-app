import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:moduluenergy/src/network/mokodevice/moko_connection_service.dart';
import 'package:moduluenergy/src/network/mokodevice/moko_models.dart';

import '../result.dart';

enum DeviceConnectionStatus {
  idle,
  connecting,
  connected,
  error
  //TODO more precise steps?
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
  DeviceConfigurationStep.configureMQTTInformation:
      'Configuring device to connect with the MQTT broker...',
  DeviceConfigurationStep.sendSSLFile: 'Authenticating with the MQTT broker...',
  DeviceConfigurationStep.setPublishAndSubscribeTopic:
      'Setting up MQTT topics...',
  DeviceConfigurationStep.configureWifi: 'Configuring WiFi parameters...',
};

class MokoConnectionProvider with ChangeNotifier {
  //Hardcoded as per documentation
  static const String mokoDeviceHost = "192.168.4.1";
  static const int mokoDevicePort = 8266;

  // AWS IoT MQTT default endpoint
  static const awsHost = 'a1avzbmryjv42h-ats.iot.eu-west-1.amazonaws.com';
  static const awsPort = 8883;

  //Additional MQTT params for AWS connection
  static const int keepAlive = 120;
  static const int qos = 1;
  static const int cleanSession = 1;
  static const int selfSignedCertificates = 3;

  DeviceConnectionStatus _connectionStatus = DeviceConnectionStatus.idle;

  DeviceConnectionStatus get connectionStatus => _connectionStatus;

  DeviceConfigurationStep _configurationStep = DeviceConfigurationStep.idle;

  DeviceConfigurationStep get configurationStep => _configurationStep;

  Future<Result> configureMQTTParameters(String uuid) async {
    final mokoConnectionService =
        MokoConnectionService(mokoDeviceHost, mokoDevicePort);

    Result result = Success("");

    _connectionStatus = DeviceConnectionStatus.connecting;
    _configurationStep = DeviceConfigurationStep.enquiryDeviceInfo;
    notifyListeners();
    var deviceInfo = await mokoConnectionService.enquiryDeviceInfo();
    if (deviceInfo is Error) {
      result =
          onErrorHandler(deviceInfo, DeviceConfigurationStep.enquiryDeviceInfo);
      return result;
    }

    var deviceInfoData =
        (deviceInfo as Success<EnquiryDeviceInfoResponse>).data;
    debugPrint("deviceInfoData: $deviceInfoData");

    _configurationStep = DeviceConfigurationStep.configureMQTTInformation;
    notifyListeners();

    var mqttInfoRequest = _getMQTTInformationRequest(uuid);
    var mqttInfo =
        await mokoConnectionService.configureMQTTInformation(mqttInfoRequest);

    if (mqttInfo is Error) {
      result = onErrorHandler(
          deviceInfo, DeviceConfigurationStep.configureMQTTInformation);
      return result;
    }

    _configurationStep = DeviceConfigurationStep.sendSSLFile;
    notifyListeners();

    var sslFileResult = await configureSSLAuthentication(mokoConnectionService);
    if (sslFileResult is Error) {
      result = onErrorHandler(deviceInfo, DeviceConfigurationStep.sendSSLFile);
      return result;
    }

    _configurationStep = DeviceConfigurationStep.setPublishAndSubscribeTopic;
    notifyListeners();

    var publishSubscribeTopicRequest = PublishSubscribeRequest(
      publishTopic: "prod-energy_meter/energy/production",
      subscribeTopic: "topicfilter/test",
    );

    var topicSetupResult = await mokoConnectionService
        .setPublishAndSubscribeTopic(publishSubscribeTopicRequest);

    if (topicSetupResult is Error) {
      result = onErrorHandler(
          deviceInfo, DeviceConfigurationStep.setPublishAndSubscribeTopic);
      return result;
    }

    _configurationStep = DeviceConfigurationStep.configureWifi;
    notifyListeners();

    return result;
  }

  Future<Result> configureSSLAuthentication(
      MokoConnectionService service) async {
    const caFilePath = 'assets/ca.pem';
    const certFilePath = 'assets/cert.pem.crt';
    const keyFilePath = 'assets/private.pem.key';

    debugPrint("Sending CA file...");
    var caUploadResult = await service.sendSSLFileData(
        SSLFileType.caRootCertificate, caFilePath);
    if (caUploadResult is Error) {
      return caUploadResult;
    }

    var certUploadResult = await service.sendSSLFileData(
        SSLFileType.clientCertificate, certFilePath);
    if (certUploadResult is Error) {
      return certUploadResult;
    }

    var keyUploadResult = await service.sendSSLFileData(
        SSLFileType.clientPrivateKey, keyFilePath);
    if (keyUploadResult is Error) {
      return keyUploadResult;
    }

    return Success("Successfully uploaded SSL files!");
  }

  Future<Result> configureWifiInformation(String ssid, String password) async {
    final mokoConnectionService =
        MokoConnectionService(mokoDeviceHost, mokoDevicePort);

    Result result = Success("");

    var wifiConfigurationRequest = WifiInformationSetupRequest(
        wifi_ssid: ssid, wifi_pwd: password, wifi_security: 2 // has to be WPA
        );

    var wifiConfigurationResult = await mokoConnectionService
        .setWifiInformation(wifiConfigurationRequest);

    if (wifiConfigurationResult is Error) {
      result = onErrorHandler(wifiConfigurationResult.errorMessage,
          DeviceConfigurationStep.configureWifi);
      return result;
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

  Error onErrorHandler(Object obj, DeviceConfigurationStep operationType) {
    String errorMessage = "";
    debugPrint(obj.toString());
    _connectionStatus = DeviceConnectionStatus.error;
    _configurationStep = DeviceConfigurationStep.idle;
    notifyListeners();
    debugPrint("error: ${obj}");
    errorMessage = "Error during $operationType: ${obj.toString()}";
    return Error(errorMessage);
  }
}
