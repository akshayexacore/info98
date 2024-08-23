import 'package:info_91_proj/feature/auth/data/models/base_response.dart';
import 'package:info_91_proj/feature/auth/data/models/user.dart';

class LoginResponse {
  late String message;
  late int statusCode;
  late User? user;
  late String token;
  late String tokenType;
  late String refreshToken;
  late bool success;

  LoginResponse(
      {this.message = '',
      this.statusCode = 0,
      this.user,
      this.token = '',
      this.success = false,
      this.tokenType = ''});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    message =
        json['message'] is String ? json['message'] : getStringFromMap(json);
    statusCode = json['statusCode'] ?? 0;
    user = json['data'] != null && json['data'] is Map
        ? User.fromJson(json['data'])
        : null;
    token =
        json['token'] != null ? json['token']['original']['access_token'] : '';
    tokenType = 'Bearer';
    success = json['success'] == "success";
    refreshToken = json['random_string'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['statusCode'] = statusCode;
    if (user != null) {
      data['data'] = user!.toJson();
    }
    data['success'] = success;
    return data;
  }
}
