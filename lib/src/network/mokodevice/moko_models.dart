import 'package:json_annotation/json_annotation.dart';

part 'moko_models.g.dart';

@JsonSerializable()
class MQTTInformationRequest {
  int header = 4002;
  final String host;
  final int port;
  @JsonKey(name: 'connect_mode')
  final int connectMode;
  @JsonKey(name: 'clientid')
  final String clientId;
  final String username;
  final String password;
  @JsonKey(name: 'keepalive')
  final int keepAlive;
  final int qos;
  @JsonKey(name: 'clean_session')
  final int cleanSession;

  MQTTInformationRequest({
    this.header = 4002,
    required this.host,
    required this.port,
    required this.connectMode,
    required this.clientId,
    required this.username,
    required this.password,
    required this.keepAlive,
    required this.qos,
    required this.cleanSession,
  });

  factory MQTTInformationRequest.fromJson(Map<String, dynamic> json) =>
      _$MQTTInformationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MQTTInformationRequestToJson(this);
}

@JsonSerializable()
class SSLFileRequest {
  int header;
  @JsonKey(name: 'file_type')
  final int fileType;
  @JsonKey(name: 'file_size')
  final int fileSize;
  final int offset;
  @JsonKey(name: 'current_packet_len')
  final int currentPacketLen;

  final String data;

  SSLFileRequest({
    this.header = 4003,
    required this.fileType,
    required this.fileSize,
    required this.offset,
    required this.currentPacketLen,
    required this.data,
  });

  factory SSLFileRequest.fromJson(Map<String, dynamic> json) =>
      _$SSLFileRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SSLFileRequestToJson(this);
}

@JsonSerializable()
class PublishSubscribeRequest {
  int header = 4004;
  @JsonKey(name: 'set_publish_topic')
  final String publishTopic;

  //Lol, there's a typo in the original code
  @JsonKey(name: 'set_subscibe_topic')
  final String subscribeTopic;

  PublishSubscribeRequest({
    this.header = 4004,
    required this.publishTopic,
    required this.subscribeTopic,
  });

  factory PublishSubscribeRequest.fromJson(Map<String, dynamic> json) =>
      _$PublishSubscribeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PublishSubscribeRequestToJson(this);
}

@JsonSerializable()
class MokoDeviceResponse {
  final int code;
  final String message;
  final dynamic result;

  MokoDeviceResponse({
    required this.code,
    required this.message,
    required this.result,
  });

  factory MokoDeviceResponse.fromJson(Map<String, dynamic> json) =>
      _$MokoDeviceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MokoDeviceResponseToJson(this);
}

@JsonSerializable()
class EnquiryDeviceInfoResult {
  @JsonKey(name: 'header')
  final int header;

  @JsonKey(name: 'device_name')
  final String deviceName;

  @JsonKey(name: 'device_id')
  final String deviceId;

  @JsonKey(name: 'device_type')
  final String deviceType;

  EnquiryDeviceInfoResult({
    required this.header,
    required this.deviceName,
    required this.deviceId,
    required this.deviceType,
  });

  factory EnquiryDeviceInfoResult.fromJson(Map<String, dynamic> json) =>
      _$EnquiryDeviceInfoResultFromJson(json);

  Map<String, dynamic> toJson() => _$EnquiryDeviceInfoResultToJson(this);
}

@JsonSerializable()
class MQTTInformationResult {
  final int header;

  MQTTInformationResult({
    required this.header,
  });

  factory MQTTInformationResult.fromJson(Map<String, dynamic> json) =>
      _$MQTTInformationResultFromJson(json);

  Map<String, dynamic> toJson() => _$MQTTInformationResultToJson(this);
}

@JsonSerializable()
class SSLFileResult {
  final int header;

  SSLFileResult({
    required this.header,
  });

  factory SSLFileResult.fromJson(Map<String, dynamic> json) =>
      _$SSLFileResultFromJson(json);

  Map<String, dynamic> toJson() => _$SSLFileResultToJson(this);
}

@JsonSerializable()
class PublishSubscribeResult {
  final int header;

  PublishSubscribeResult({
    required this.header,
  });

  factory PublishSubscribeResult.fromJson(Map<String, dynamic> json) =>
      _$PublishSubscribeResultFromJson(json);

  Map<String, dynamic> toJson() => _$PublishSubscribeResultToJson(this);
}

@JsonSerializable()
class EnquiryDeviceInfoResponse {
  final int code;
  final String message;
  final EnquiryDeviceInfoResult result;

  EnquiryDeviceInfoResponse({
    required this.code,
    required this.message,
    required this.result,
  });

  factory EnquiryDeviceInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$EnquiryDeviceInfoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EnquiryDeviceInfoResponseToJson(this);
}

@JsonSerializable()
class MQTTInformationResponse {
  final int code;
  final String message;
  final MQTTInformationResult result;

  MQTTInformationResponse({
    required this.code,
    required this.message,
    required this.result,
  });

  factory MQTTInformationResponse.fromJson(Map<String, dynamic> json) =>
      _$MQTTInformationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MQTTInformationResponseToJson(this);
}

@JsonSerializable()
class SSLFileResponse {
  final int code;
  final String message;
  final SSLFileResult result;

  SSLFileResponse({
    required this.code,
    required this.message,
    required this.result,
  });

  factory SSLFileResponse.fromJson(Map<String, dynamic> json) =>
      _$SSLFileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SSLFileResponseToJson(this);
}

@JsonSerializable()
class PublishSubscribeResponse {
  final int code;
  final String message;
  final PublishSubscribeResult result;

  PublishSubscribeResponse({
    required this.code,
    required this.message,
    required this.result,
  });

  factory PublishSubscribeResponse.fromJson(Map<String, dynamic> json) =>
      _$PublishSubscribeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PublishSubscribeResponseToJson(this);
}

@JsonSerializable()
class WifiInformationSetupResponse {
  final int code;
  final String message;
  final PublishSubscribeResult result;

  WifiInformationSetupResponse({
    required this.code,
    required this.message,
    required this.result,
  });

  factory WifiInformationSetupResponse.fromJson(Map<String, dynamic> json) =>
      _$WifiInformationSetupResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WifiInformationSetupResponseToJson(this);
}

@JsonSerializable()
class WifiInformationSetupRequest {
  int header = 4006;
  final String wifi_ssid;
  final String wifi_pwd;
  final int wifi_security;

  WifiInformationSetupRequest({
    this.header = 4006,
    required this.wifi_ssid,
    required this.wifi_pwd,
    required this.wifi_security,
  });

  factory WifiInformationSetupRequest.fromJson(Map<String, dynamic> json) =>
      _$WifiInformationSetupRequestFromJson(json);

  Map<String, dynamic> toJson() => _$WifiInformationSetupRequestToJson(this);
}
