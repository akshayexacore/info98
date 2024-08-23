import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesDataProvider {
  static const String token = 'authorization_token';
  static const String refresh = 'refresh_token';
  static const String isFirstLaunch = 'is_first_launch';
  static const String userId = 'user_id';
  static const String userPin = 'user_pin';
  static const String userName = 'user_name';
  static const String userMobile = 'user_mobile';
  static const String userMail = 'user_mail';
  static const String userImage = 'user_image';
  static const String shouldAskRatingFor = 'should_ask_rating_for';

  Future<bool> clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }

  Future<bool> saveAccessToken(String accessToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(token, accessToken);
  }

  Future<String> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(token) ?? '';
  }

  Future<bool> saveRefreshToken(String refreshToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(refresh, refreshToken);
  }

  Future<String> getRefreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(refresh) ?? '';
  }

  Future<bool> saveIsFirstLaunch(bool val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(isFirstLaunch, val);
  }

  Future<bool> getIsFirstLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isFirstLaunch) ?? true;
  }

  Future<bool> saveUserId(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setInt(userId, id);
  }

  Future<int> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(userId) ?? 0;
  }

  Future<bool> saveUserPin(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(userPin, id);
  }

  Future<String> getUserPin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userPin) ?? '';
  }

  Future<bool> saveUserName(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(userName, name);
  }

  Future<String> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userName) ?? '';
  }

  Future<bool> saveUserMobile(String mobile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(userMobile, mobile);
  }

  Future<String> getUserMobile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userMobile) ?? '';
  }

  Future<bool> saveUserImage(String mobile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(userImage, mobile);
  }

  Future<String> getUserImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userImage) ?? '';
  }

  Future<bool> saveUserMail(String mobile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(userMail, mobile);
  }

  Future<String> getUserMail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userMail) ?? '';
  }
}
