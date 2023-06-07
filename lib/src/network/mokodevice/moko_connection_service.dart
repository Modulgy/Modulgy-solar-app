import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../result.dart';
import 'moko_models.dart';

import 'dart:io';

enum MokoDeviceReturnCode {
  receivedAndParsedSuccessfully,
  dataLengthNotMeetingRule,
  dataTypeNotMeetingRule,
  mqttWifiNetworkConfigurationOrderNotMeetingRule,
  receivedDataNotConformingJSONFormat,
  receivedJSONDataNotDefinedInDocument,
  dataTypeCorrectButValueOutOfRange,
  incompleteSSLCertificates,
  failedToGetCertificateData,
}

enum SSLFileType {
  caRootCertificate,
  clientCertificate,
  clientPrivateKey,
}

class MokoConnectionService {
  final String host;
  final int port;

  MokoConnectionService(this.host, this.port);

  Future<Result> enquiryDeviceInfo() async {
    final response = await _sendTcpRequest('{"header": 4001}');


    final jsonData = jsonDecode(response);
    var parsedResponse = EnquiryDeviceInfoResponse.fromJson(jsonData);
    return wrapResult(parsedResponse, parsedResponse.code);
  }

  Future<Result> configureMQTTInformation(
      MQTTInformationRequest request) async {
    final body = jsonEncode(request.toJson());
    final response = await _sendTcpRequest(body);

    final jsonData = jsonDecode(response);
    var parsedResponse = MQTTInformationResponse.fromJson(jsonData);
    return wrapResult(parsedResponse, parsedResponse.code);
  }

  Future<Result> sendSSLFile(SSLFileRequest request) async {
    final body = jsonEncode(request.toJson());
    final response = await _sendTcpRequest(body);

    final jsonData = jsonDecode(response);
    var parsedResponse = SSLFileResponse.fromJson(jsonData);
    return wrapResult(parsedResponse, parsedResponse.code);
  }

  Future<Result> setPublishAndSubscribeTopic(
      PublishSubscribeRequest request) async {
    final body = jsonEncode(request.toJson());
    final response = await _sendTcpRequest(body);

    final jsonData = jsonDecode(response);
    var parsedResponse = PublishSubscribeResponse.fromJson(jsonData);
    return wrapResult(parsedResponse, parsedResponse.code);
  }

  Future<Result> setWifiInformation(WifiInformationSetupRequest request) async {
    final body = jsonEncode(request.toJson());
    final response = await _sendTcpRequest(body);

    final jsonData = jsonDecode(response);
    var parsedResponse = WifiInformationSetupResponse.fromJson(jsonData);
    return wrapResult(parsedResponse, parsedResponse.code);
  }

  Future<String> _sendTcpRequest(String data) async {
    debugPrint("Sending: $data");
    final socket = await Socket.connect(InternetAddress(host), port);
    final completer = Completer<String>();

    socket.write(data);
    socket.listen(
      (List<int> data) {
        final response = utf8.decode(data);
        completer.complete(response);
      },
      onError: (error) {
        completer.completeError(error);
      },
      cancelOnError: true,
    );

    final response = await completer.future;
    socket.close();
    debugPrint("Received: $response' from TCP socket");
    return response;
  }

  Future<Result> sendSSLFileData(SSLFileType fileType, String filePath) async {
    const int maxPacketSize = 500;
    int fileTypeOrdinal = fileType.index + 1; // CA root certificate - Range from 1 to 3

    ByteData fileData = await rootBundle.load(filePath);
    Uint8List certificateBytes = fileData.buffer.asUint8List();

    int fileSize = certificateBytes.length;
    int offset = 0;

    while (offset < fileSize) {
      int currentPacketLen = offset + maxPacketSize <= fileSize
          ? maxPacketSize
          : fileSize - offset;

      List<int> packetData =
          certificateBytes.sublist(offset, offset + currentPacketLen);

      // Send the packet data using the SSLFileRequest model and network call
      SSLFileRequest request = SSLFileRequest(
        fileType: fileTypeOrdinal,
        fileSize: fileSize,
        offset: offset,
        currentPacketLen: currentPacketLen,
        data: utf8.decode(packetData),
      );

      var sslUploadResult = await sendSSLFile(request);
      if(sslUploadResult is Error) {
        return sslUploadResult;
      }

      offset += currentPacketLen;
    }

    return Success("Successfully uploaded SSL file ${fileType.toString()}");
  }

  Result wrapResult<T>(T response, int responseCode) {
    debugPrint("Connection: response code is $responseCode");
    var mokoCode = MokoDeviceReturnCode.values
        .firstWhere((element) => element.index == responseCode);
    if (mokoCode == MokoDeviceReturnCode.receivedAndParsedSuccessfully) {
      return Success<T>(response);
    } else {
      return Error(
          "There was an error with the connection with the Moko device. - ${mokoCode.toString()}");
    }
  }
}
