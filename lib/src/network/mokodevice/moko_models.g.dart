// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moko_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MQTTInformationRequest _$MQTTInformationRequestFromJson(
        Map<String, dynamic> json) =>
    MQTTInformationRequest(
      header: (json['header'] as num?)?.toInt() ?? 4002,
      host: json['host'] as String,
      port: (json['port'] as num).toInt(),
      connectMode: (json['connect_mode'] as num).toInt(),
      clientId: json['clientid'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
      keepAlive: (json['keepalive'] as num).toInt(),
      qos: (json['qos'] as num).toInt(),
      cleanSession: (json['clean_session'] as num).toInt(),
    );

Map<String, dynamic> _$MQTTInformationRequestToJson(
        MQTTInformationRequest instance) =>
    <String, dynamic>{
      'header': instance.header,
      'host': instance.host,
      'port': instance.port,
      'connect_mode': instance.connectMode,
      'clientid': instance.clientId,
      'username': instance.username,
      'password': instance.password,
      'keepalive': instance.keepAlive,
      'qos': instance.qos,
      'clean_session': instance.cleanSession,
    };

SSLFileRequest _$SSLFileRequestFromJson(Map<String, dynamic> json) =>
    SSLFileRequest(
      header: (json['header'] as num?)?.toInt() ?? 4003,
      fileType: (json['file_type'] as num).toInt(),
      fileSize: (json['file_size'] as num).toInt(),
      offset: (json['offset'] as num).toInt(),
      currentPacketLen: (json['current_packet_len'] as num).toInt(),
      data: json['data'] as String,
    );

Map<String, dynamic> _$SSLFileRequestToJson(SSLFileRequest instance) =>
    <String, dynamic>{
      'header': instance.header,
      'file_type': instance.fileType,
      'file_size': instance.fileSize,
      'offset': instance.offset,
      'current_packet_len': instance.currentPacketLen,
      'data': instance.data,
    };

PublishSubscribeRequest _$PublishSubscribeRequestFromJson(
        Map<String, dynamic> json) =>
    PublishSubscribeRequest(
      header: (json['header'] as num?)?.toInt() ?? 4004,
      publishTopic: json['set_publish_topic'] as String,
      subscribeTopic: json['set_subscibe_topic'] as String,
    );

Map<String, dynamic> _$PublishSubscribeRequestToJson(
        PublishSubscribeRequest instance) =>
    <String, dynamic>{
      'header': instance.header,
      'set_publish_topic': instance.publishTopic,
      'set_subscibe_topic': instance.subscribeTopic,
    };

MokoDeviceResponse _$MokoDeviceResponseFromJson(Map<String, dynamic> json) =>
    MokoDeviceResponse(
      code: (json['code'] as num).toInt(),
      message: json['message'] as String,
      result: json['result'],
    );

Map<String, dynamic> _$MokoDeviceResponseToJson(MokoDeviceResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'result': instance.result,
    };

EnquiryDeviceInfoResult _$EnquiryDeviceInfoResultFromJson(
        Map<String, dynamic> json) =>
    EnquiryDeviceInfoResult(
      header: (json['header'] as num).toInt(),
      deviceName: json['device_name'] as String,
      deviceId: json['device_id'] as String,
      deviceType: json['device_type'] as String,
    );

Map<String, dynamic> _$EnquiryDeviceInfoResultToJson(
        EnquiryDeviceInfoResult instance) =>
    <String, dynamic>{
      'header': instance.header,
      'device_name': instance.deviceName,
      'device_id': instance.deviceId,
      'device_type': instance.deviceType,
    };

MQTTInformationResult _$MQTTInformationResultFromJson(
        Map<String, dynamic> json) =>
    MQTTInformationResult(
      header: (json['header'] as num).toInt(),
    );

Map<String, dynamic> _$MQTTInformationResultToJson(
        MQTTInformationResult instance) =>
    <String, dynamic>{
      'header': instance.header,
    };

SSLFileResult _$SSLFileResultFromJson(Map<String, dynamic> json) =>
    SSLFileResult(
      header: (json['header'] as num).toInt(),
    );

Map<String, dynamic> _$SSLFileResultToJson(SSLFileResult instance) =>
    <String, dynamic>{
      'header': instance.header,
    };

PublishSubscribeResult _$PublishSubscribeResultFromJson(
        Map<String, dynamic> json) =>
    PublishSubscribeResult(
      header: (json['header'] as num).toInt(),
    );

Map<String, dynamic> _$PublishSubscribeResultToJson(
        PublishSubscribeResult instance) =>
    <String, dynamic>{
      'header': instance.header,
    };

EnquiryDeviceInfoResponse _$EnquiryDeviceInfoResponseFromJson(
        Map<String, dynamic> json) =>
    EnquiryDeviceInfoResponse(
      code: (json['code'] as num).toInt(),
      message: json['message'] as String,
      result: EnquiryDeviceInfoResult.fromJson(
          json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EnquiryDeviceInfoResponseToJson(
        EnquiryDeviceInfoResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'result': instance.result,
    };

MQTTInformationResponse _$MQTTInformationResponseFromJson(
        Map<String, dynamic> json) =>
    MQTTInformationResponse(
      code: (json['code'] as num).toInt(),
      message: json['message'] as String,
      result: MQTTInformationResult.fromJson(
          json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MQTTInformationResponseToJson(
        MQTTInformationResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'result': instance.result,
    };

SSLFileResponse _$SSLFileResponseFromJson(Map<String, dynamic> json) =>
    SSLFileResponse(
      code: (json['code'] as num).toInt(),
      message: json['message'] as String,
      result: SSLFileResult.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SSLFileResponseToJson(SSLFileResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'result': instance.result,
    };

PublishSubscribeResponse _$PublishSubscribeResponseFromJson(
        Map<String, dynamic> json) =>
    PublishSubscribeResponse(
      code: (json['code'] as num).toInt(),
      message: json['message'] as String,
      result: PublishSubscribeResult.fromJson(
          json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PublishSubscribeResponseToJson(
        PublishSubscribeResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'result': instance.result,
    };

WifiInformationSetupResponse _$WifiInformationSetupResponseFromJson(
        Map<String, dynamic> json) =>
    WifiInformationSetupResponse(
      code: (json['code'] as num).toInt(),
      message: json['message'] as String,
      result: PublishSubscribeResult.fromJson(
          json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WifiInformationSetupResponseToJson(
        WifiInformationSetupResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'result': instance.result,
    };

WifiInformationSetupRequest _$WifiInformationSetupRequestFromJson(
        Map<String, dynamic> json) =>
    WifiInformationSetupRequest(
      header: (json['header'] as num?)?.toInt() ?? 4006,
      wifi_ssid: json['wifi_ssid'] as String,
      wifi_pwd: json['wifi_pwd'] as String,
      wifi_security: (json['wifi_security'] as num).toInt(),
    );

Map<String, dynamic> _$WifiInformationSetupRequestToJson(
        WifiInformationSetupRequest instance) =>
    <String, dynamic>{
      'header': instance.header,
      'wifi_ssid': instance.wifi_ssid,
      'wifi_pwd': instance.wifi_pwd,
      'wifi_security': instance.wifi_security,
    };
