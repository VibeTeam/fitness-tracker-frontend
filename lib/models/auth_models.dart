import 'package:json_annotation/json_annotation.dart';

part 'auth_models.g.dart';

@JsonSerializable()
class SignUpRequest {
  final String name;
  final String email;
  final String password;

  SignUpRequest({
    required this.name,
    required this.email,
    required this.password,
  });

  factory SignUpRequest.fromJson(Map<String, dynamic> json) =>
      _$SignUpRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpRequestToJson(this);
}

@JsonSerializable()
class SignUpResponse {
  @JsonKey(name: 'created_at')
  final String createdAt;
  final String email;
  final int id;
  final String name;
  @JsonKey(name: 'password_hash')
  final String? passwordHash;

  SignUpResponse({
    required this.createdAt,
    required this.email,
    required this.id,
    required this.name,
    this.passwordHash,
  });

  factory SignUpResponse.fromJson(Map<String, dynamic> json) =>
      _$SignUpResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpResponseToJson(this);
}

@JsonSerializable()
class SignInRequest {
  final String email;
  final String password;

  SignInRequest({required this.email, required this.password});

  factory SignInRequest.fromJson(Map<String, dynamic> json) =>
      _$SignInRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SignInRequestToJson(this);
}

@JsonSerializable()
class SignInResponse {
  @JsonKey(name: 'access_token')
  final String accessToken;
  @JsonKey(name: 'refresh_token')
  final String refreshToken;

  SignInResponse({required this.accessToken, required this.refreshToken});

  factory SignInResponse.fromJson(Map<String, dynamic> json) =>
      _$SignInResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SignInResponseToJson(this);
}

@JsonSerializable()
class User {
  @JsonKey(name: 'created_at')
  final String createdAt;
  final String email;
  final int id;
  final String name;
  @JsonKey(name: 'password_hash')
  final String? passwordHash;

  User({
    required this.createdAt,
    required this.email,
    required this.id,
    required this.name,
    this.passwordHash,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class RefreshTokenRequest {
  @JsonKey(name: 'refresh_token')
  final String refreshToken;

  RefreshTokenRequest({required this.refreshToken});

  factory RefreshTokenRequest.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshTokenRequestToJson(this);
}

@JsonSerializable()
class RefreshTokenResponse {
  @JsonKey(name: 'access_token')
  final String accessToken;
  @JsonKey(name: 'refresh_token')
  final String refreshToken;

  RefreshTokenResponse({required this.accessToken, required this.refreshToken});

  factory RefreshTokenResponse.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshTokenResponseToJson(this);
}
