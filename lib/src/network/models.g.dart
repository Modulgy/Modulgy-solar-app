// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EnergyProductionResponseBody _$EnergyProductionResponseBodyFromJson(
        Map<String, dynamic> json) =>
    EnergyProductionResponseBody(
      energyProduced: (json['energyProduced'] as List<dynamic>)
          .map((e) => EnergyProduced.fromJson(e as Map<String, dynamic>))
          .toList(),
      period: json['period'] as String,
      to: json['to'] as String,
      from: json['from'] as String,
    );

Map<String, dynamic> _$EnergyProductionResponseBodyToJson(
        EnergyProductionResponseBody instance) =>
    <String, dynamic>{
      'energyProduced': instance.energyProduced,
      'period': instance.period,
      'to': instance.to,
      'from': instance.from,
    };

EnergyProduced _$EnergyProducedFromJson(Map<String, dynamic> json) =>
    EnergyProduced(
      energyProduced: (json['energyProduced'] as num).toDouble(),
      date: json['date'] as String,
    );

Map<String, dynamic> _$EnergyProducedToJson(EnergyProduced instance) =>
    <String, dynamic>{
      'energyProduced': instance.energyProduced,
      'date': instance.date,
    };

UsersResponseBody _$UsersResponseBodyFromJson(Map<String, dynamic> json) =>
    UsersResponseBody(
      users: (json['users'] as List<dynamic>)
          .map((e) => UserData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UsersResponseBodyToJson(UsersResponseBody instance) =>
    <String, dynamic>{
      'users': instance.users,
    };

UserResponseBody _$UserResponseBodyFromJson(Map<String, dynamic> json) =>
    UserResponseBody(
      user: UserData.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserResponseBodyToJson(UserResponseBody instance) =>
    <String, dynamic>{
      'user': instance.user,
    };

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      isActivated: json['isActivated'] as bool,
      lastLoginAt: json['lastLoginAt'] as String,
      email: json['email'] as String,
      createdAt: json['createdAt'] as String,
      uuid: json['uuid'] as String,
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'isActivated': instance.isActivated,
      'lastLoginAt': instance.lastLoginAt,
      'email': instance.email,
      'createdAt': instance.createdAt,
      'uuid': instance.uuid,
    };

EnergyProductionSummaryResponseBody
    _$EnergyProductionSummaryResponseBodyFromJson(Map<String, dynamic> json) =>
        EnergyProductionSummaryResponseBody(
          energyProduced: (json['energyProduced'] as List<dynamic>)
              .map((e) =>
                  SumOfEnergyProduced.fromJson(e as Map<String, dynamic>))
              .toList(),
          period: json['period'] as String,
          to: json['to'] as String,
          from: json['from'] as String,
        );

Map<String, dynamic> _$EnergyProductionSummaryResponseBodyToJson(
        EnergyProductionSummaryResponseBody instance) =>
    <String, dynamic>{
      'energyProduced': instance.energyProduced,
      'period': instance.period,
      'to': instance.to,
      'from': instance.from,
    };

SumOfEnergyProduced _$SumOfEnergyProducedFromJson(Map<String, dynamic> json) =>
    SumOfEnergyProduced(
      sumOfEnergyProduced: (json['sumOfEnergyProduced'] as num).toDouble(),
      date: json['date'] as String,
    );

Map<String, dynamic> _$SumOfEnergyProducedToJson(
        SumOfEnergyProduced instance) =>
    <String, dynamic>{
      'sumOfEnergyProduced': instance.sumOfEnergyProduced,
      'date': instance.date,
    };

AuthRequest _$AuthRequestFromJson(Map<String, dynamic> json) => AuthRequest(
      type: json['type'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$AuthRequestToJson(AuthRequest instance) =>
    <String, dynamic>{
      'type': instance.type,
      'email': instance.email,
      'password': instance.password,
    };

ActivateRequestBody _$ActivateRequestBodyFromJson(Map<String, dynamic> json) =>
    ActivateRequestBody(
      verificationCode: json['verificationCode'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$ActivateRequestBodyToJson(
        ActivateRequestBody instance) =>
    <String, dynamic>{
      'verificationCode': instance.verificationCode,
      'email': instance.email,
    };

ResendCodeBody _$ResendCodeBodyFromJson(Map<String, dynamic> json) =>
    ResendCodeBody(
      email: json['email'] as String,
    );

Map<String, dynamic> _$ResendCodeBodyToJson(ResendCodeBody instance) =>
    <String, dynamic>{
      'email': instance.email,
    };

PasswordResetRequestBody _$PasswordResetRequestBodyFromJson(
        Map<String, dynamic> json) =>
    PasswordResetRequestBody(
      email: json['email'] as String,
    );

Map<String, dynamic> _$PasswordResetRequestBodyToJson(
        PasswordResetRequestBody instance) =>
    <String, dynamic>{
      'email': instance.email,
    };

PasswordChangeRequestBody _$PasswordChangeRequestBodyFromJson(
        Map<String, dynamic> json) =>
    PasswordChangeRequestBody(
      verificationCode: (json['verificationCode'] as num).toDouble(),
      password: json['password'] as String,
      uuid: json['uuid'] as String,
    );

Map<String, dynamic> _$PasswordChangeRequestBodyToJson(
        PasswordChangeRequestBody instance) =>
    <String, dynamic>{
      'verificationCode': instance.verificationCode,
      'password': instance.password,
      'uuid': instance.uuid,
    };

NewUserData _$NewUserDataFromJson(Map<String, dynamic> json) => NewUserData(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$NewUserDataToJson(NewUserData instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };

AuthToken _$AuthTokenFromJson(Map<String, dynamic> json) => AuthToken(
      type: json['type'] as String,
      body: json['body'] as String,
    );

Map<String, dynamic> _$AuthTokenToJson(AuthToken instance) => <String, dynamic>{
      'type': instance.type,
      'body': instance.body,
    };

Article _$ArticleFromJson(Map<String, dynamic> json) => Article(
      id: json['id'] as int,
      date: json['date'] as String,
      link: json['link'] as String,
      title: json['title'] as String,
      featuredMediaUrl:
          Article._featuredMediaFromJson(json['wp:featuredmedia']),
    );

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
      'link': instance.link,
      'title': instance.title,
      'wp:featuredmedia':
          Article._featuredMediaToJson(instance.featuredMediaUrl),
    };
