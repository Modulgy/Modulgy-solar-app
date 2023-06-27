// Additional imports
import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

@JsonSerializable()
class EnergyProductionResponseBody {
  final List<EnergyProduced> energyProduced;
  final String period;
  final String to;
  final String from;

  EnergyProductionResponseBody({
    required this.energyProduced,
    required this.period,
    required this.to,
    required this.from,
  });

  factory EnergyProductionResponseBody.fromJson(Map<String, dynamic> json) =>
      _$EnergyProductionResponseBodyFromJson(json);

  Map<String, dynamic> toJson() => _$EnergyProductionResponseBodyToJson(this);
}

@JsonSerializable()
class EnergyProduced {
  final double energyProduced;
  final String date;

  EnergyProduced({
    required this.energyProduced,
    required this.date,
  });

  factory EnergyProduced.fromJson(Map<String, dynamic> json) =>
      _$EnergyProducedFromJson(json);

  Map<String, dynamic> toJson() => _$EnergyProducedToJson(this);
}

@JsonSerializable()
class UsersResponseBody {
  final List<UserData> users;

  UsersResponseBody({
    required this.users,
  });

  factory UsersResponseBody.fromJson(Map<String, dynamic> json) =>
      _$UsersResponseBodyFromJson(json);

  Map<String, dynamic> toJson() => _$UsersResponseBodyToJson(this);
}

@JsonSerializable()
class UserResponseBody {
  final UserData user;

  UserResponseBody({
    required this.user,
  });

  factory UserResponseBody.fromJson(Map<String, dynamic> json) =>
      _$UserResponseBodyFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseBodyToJson(this);
}

@JsonSerializable()
class UserData {
  final bool isActivated;
  final String lastLoginAt;
  final String email;
  final String createdAt;
  final String uuid;

  UserData({
    required this.isActivated,
    required this.lastLoginAt,
    required this.email,
    required this.createdAt,
    required this.uuid,
  });

  static UserData empty = UserData(
      isActivated: false, lastLoginAt: "", email: "", createdAt: "", uuid: "");

  bool isValid() {
    return lastLoginAt.isNotEmpty &&
        email.isNotEmpty &&
        createdAt.isNotEmpty &&
        uuid.isNotEmpty;
  }

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}

@JsonSerializable()
class EnergyProductionSummaryResponseBody {
  final List<SumOfEnergyProduced> energyProduced;
  final String period;
  final String to;
  final String from;

  EnergyProductionSummaryResponseBody({
    required this.energyProduced,
    required this.period,
    required this.to,
    required this.from,
  });

  factory EnergyProductionSummaryResponseBody.fromJson(
          Map<String, dynamic> json) =>
      _$EnergyProductionSummaryResponseBodyFromJson(json);

  Map<String, dynamic> toJson() =>
      _$EnergyProductionSummaryResponseBodyToJson(this);
}

@JsonSerializable()
class SumOfEnergyProduced {
  final double sumOfEnergyProduced;
  final String date;

  SumOfEnergyProduced({
    required this.sumOfEnergyProduced,
    required this.date,
  });

  factory SumOfEnergyProduced.fromJson(Map<String, dynamic> json) =>
      _$SumOfEnergyProducedFromJson(json);

  Map<String, dynamic> toJson() => _$SumOfEnergyProducedToJson(this);
}

@JsonSerializable()
class AuthRequest {
  String type = "user";
  final String email;
  final String password;

  AuthRequest({
    required this.type,
    required this.email,
    required this.password,
  });

  factory AuthRequest.fromJson(Map<String, dynamic> json) =>
      _$AuthRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AuthRequestToJson(this);
}

@JsonSerializable()
class ActivateRequestBody {
  final String verificationCode;
  final String email;

  ActivateRequestBody({
    required this.verificationCode,
    required this.email,
  });

  factory ActivateRequestBody.fromJson(Map<String, dynamic> json) =>
      _$ActivateRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$ActivateRequestBodyToJson(this);
}

@JsonSerializable()
class ResendCodeBody {
  final String email;

  ResendCodeBody({required this.email});

  factory ResendCodeBody.fromJson(Map<String, dynamic> json) =>
      _$ResendCodeBodyFromJson(json);

  Map<String, dynamic> toJson() => _$ResendCodeBodyToJson(this);
}

@JsonSerializable()
class PasswordResetRequestBody {
  final String email;

  PasswordResetRequestBody({
    required this.email,
  });

  factory PasswordResetRequestBody.fromJson(Map<String, dynamic> json) =>
      _$PasswordResetRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$PasswordResetRequestBodyToJson(this);
}

@JsonSerializable()
class PasswordChangeRequestBody {
  final double verificationCode;
  final String password;
  final String uuid;

  PasswordChangeRequestBody({
    required this.verificationCode,
    required this.password,
    required this.uuid,
  });

  factory PasswordChangeRequestBody.fromJson(Map<String, dynamic> json) =>
      _$PasswordChangeRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$PasswordChangeRequestBodyToJson(this);
}

@JsonSerializable()
class NewUserData {
  final String email;
  final String password;

  NewUserData({
    required this.email,
    required this.password,
  });

  factory NewUserData.fromJson(Map<String, dynamic> json) =>
      _$NewUserDataFromJson(json);

  Map<String, dynamic> toJson() => _$NewUserDataToJson(this);
}

@JsonSerializable()
class AuthToken {
  final String type;
  final String body;

  AuthToken({
    required this.type,
    required this.body,
  });

  factory AuthToken.fromJson(Map<String, dynamic> json) =>
      _$AuthTokenFromJson(json);

  Map<String, dynamic> toJson() => _$AuthTokenToJson(this);
}

@JsonSerializable()
class Article {
  final int id;
  final String date;
  final String link;
  final String title;

  @JsonKey(
    name: 'wp:featuredmedia',
    fromJson: _featuredMediaFromJson,
    toJson: _featuredMediaToJson,
  )
  String featuredMediaUrl;

  Article({
    required this.id,
    required this.date,
    required this.link,
    required this.title,
    required this.featuredMediaUrl,
  });

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleToJson(this);

  static String _featuredMediaFromJson(dynamic value) {
    // Retrieve the source URL from the provided JSON structure
    return value[0]['source_url'] + ".webp";
  }

  static dynamic _featuredMediaToJson(String value) {
    // Not required for serialization, only used during deserialization
    throw UnimplementedError();
  }
}
