import 'package:vyapapp/utils/helpers/safe_converters.dart';

class AuthModel {
  final int id;
  final String email;
  final String name;
  final String? accessToken;
  final String? refreshToken;

  AuthModel({
    required this.id,
    this.email = '',
    this.name = '',
    this.accessToken,
    this.refreshToken,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
    id: convertToInt(json['company_id']),
    email: convertToString(json['email']),
    name: convertToString(json['name']),
    accessToken: convertToString(json['access']),
    refreshToken: convertToString(json['refresh']),
  );
}

class CommonResponseModel {
  final String message;
  final bool status;

  CommonResponseModel({required this.message, required this.status});

  factory CommonResponseModel.fromJson(Map<String, dynamic> json) =>
      CommonResponseModel(
        message: convertToString(json['message']),
        status: convertToBool(json['status']),
      );
}
