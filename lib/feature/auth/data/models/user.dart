import 'base_response.dart';
class UserResponse {
  late String message;
  late int statusCode;
  User? user;
  late String profilePic;
  late bool success;

  UserResponse(
      {this.message = '',
        this.statusCode = 0,
        this.user,
        this.profilePic = '',
        this.success = false});

  UserResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'] is String ? json['message'] : getStringFromMap(json);
    statusCode = json['statusCode'] ?? 0;
    user = json['data'] != null && json['data'] is Map ? User.fromJson(json['data']) : null;
    profilePic = json['profile_pic'] ?? '';
    success = json['success'] == "success";
    if(user!=null) {
      user?.image = profilePic;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['statusCode'] = statusCode;
    if (user != null) {
      data['data'] = user!.toJson();
    }
    data['profile_pic'] = profilePic;
    data['success'] = success;
    return data;
  }
}

class User {
  late int id;
  late String name;
  late String phoneNumber;
  late String countryCode;
  late int otp;
  late String about;
  late String image;
  late String email;
  late String emailVerifiedAt;
  late String password;
  late String rememberToken;
  late String createdAt;
  late String updatedAt;
  late String deletedAt;

  User(
      {this.id = 0,
        this.name ='',
        this.phoneNumber = '',
        this.countryCode = '',
        this.otp = 0,
        this.about = '',
        this.image = '',
        this.email = '',
        this.emailVerifiedAt = '',
        this.password = '',
        this.rememberToken = '',
        this.createdAt = '',
        this.updatedAt = '',
        this.deletedAt = ''});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? '';
    phoneNumber = json['phone_number'] ?? '';
    countryCode = json['country_code'] ?? '';
    otp = json['otp'] ?? 0;
    about = json['about'] ?? '';
    image = json['image'] ?? '';
    email = json['email'] ?? '';
    emailVerifiedAt = json['email_verified_at'] ?? '';
    password = json['password'] ?? '';
    rememberToken = json['remember_token'] ?? '';
    createdAt = json['created_at'] ?? '';
    updatedAt = json['updated_at'] ?? '';
    deletedAt = json['deleted_at'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone_number'] = phoneNumber;
    data['country_code'] = countryCode;
    data['otp'] = otp;
    data['about'] = about;
    data['image'] = image;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['password'] = password;
    data['remember_token'] = rememberToken;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
