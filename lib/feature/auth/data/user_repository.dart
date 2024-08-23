import 'package:flutter/foundation.dart';
import 'package:info_91_proj/core/config/shared_preferences_data_provider.dart';
import 'package:info_91_proj/core/utils/api_base_helper.dart';
import 'package:info_91_proj/core/utils/api_constants.dart';
import 'package:info_91_proj/feature/auth/data/auth_repository.dart';
import 'package:info_91_proj/feature/auth/data/models/base_response.dart';
import 'package:info_91_proj/feature/auth/data/models/user.dart';

class UserProfileRepository {
  late final _api = ApiBaseHelper();
  late final _preferences = SharedPreferencesDataProvider();

  Future<void> saveUser(User user) async {
    await _preferences.saveUserId(user.id);
    await _preferences.saveUserName(user.name);
    await _preferences.saveUserMobile(user.phoneNumber);
    await _preferences.saveUserImage(user.image);
    await _preferences.saveUserMail(user.email);
  }

  Future<UserResponse> getUser() async {
    String token = await AuthRepository().getAccessToken();
    var headers = {'Authorization': token};
    print(token);
    final response = await _api.get(ApiConstants.user, headers: headers);
    return UserResponse.fromJson(response);
  }

  Future<BaseResponse> updateUser(String name, String about, String image,
      ValueChanged<int> onProgress) async {
    String token = await AuthRepository().getAccessToken();
    var header = {'Authorization': token};
    debugPrint(token);
    var body = {
      "full_name": name,
      "about": about,
    };
    final response = await _api.postMultipart(ApiConstants.updateUser,
        body: body, headers: header, file: image);
    return BaseResponse.fromJson(response);
  }
}
