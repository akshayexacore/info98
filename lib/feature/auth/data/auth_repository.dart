import 'package:info_91_proj/core/config/shared_preferences_data_provider.dart';
import 'package:info_91_proj/core/utils/api_base_helper.dart';
import 'package:info_91_proj/core/utils/api_constants.dart';
import 'package:info_91_proj/core/widgets.dart/app_dialog.dart';
import 'package:info_91_proj/feature/auth/data/models/base_response.dart';
import 'package:info_91_proj/feature/auth/data/models/login.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';

class AuthRepository {
  late final ApiBaseHelper _api = ApiBaseHelper();

  late final _preferences = SharedPreferencesDataProvider();

  Future<String> getAccessToken() async {
    return await _preferences.getAccessToken();
  }

  Future<void> saveAccessToken(String token) async {
    _preferences.saveAccessToken(token);
  }

  Future<String> getRefreshToken() async {
    return await _preferences.getRefreshToken();
  }

  Future<void> saveRefreshToken(String token) async {
    _preferences.saveRefreshToken(token);
  }

  Future<bool> logoutUser() async {
    await _preferences.clear();
    return true;
  }

  Future<BaseResponse> sendOtp(String phone, String code) async {
    var body = {'phone_number':code+ phone, "country_code": code};
    try{print(body);
    final response =
        await _api.post(ApiConstants.sendOtp, body: body, headers: {});
  
    AppDialog.showToast((response['otp'] ?? '').toString());
    return BaseResponse.fromJson(response);}catch(e)
    {;
      throw(e);}
  }

  Future<BaseResponse> reSendOtp(String phone, String code) async {
    var body = {'phone_number': phone, "country_code": code};
    print(body);
    final response = await _api
        .get(ApiConstants.reSendOtp, queryParameters: body, headers: {});
    AppDialog.showToast((response['otp'] ?? '').toString());
    return BaseResponse.fromJson(response);
  }

  Future<LoginResponse> verifyOtp(PhoneNumber phone, String otp) async {
    var body = {
      'phone_number': phone.nsn,
      'otp': otp,
      "country_code": phone.countryCode
    };
    print(body);
    final response =
        await _api.post(ApiConstants.verifyOtp, body: body, headers: {});
    return LoginResponse.fromJson(response);
  }
}
