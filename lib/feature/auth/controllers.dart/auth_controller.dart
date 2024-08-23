import 'package:get/get.dart';
import 'package:info_91_proj/core/config/shared_preferences_data_provider.dart';
import 'package:info_91_proj/core/utils/app_exception.dart';
import 'package:info_91_proj/core/widgets.dart/app_dialog.dart';
import 'package:info_91_proj/feature/auth/data/auth_repository.dart';
import 'package:info_91_proj/feature/auth/data/user_repository.dart';
import 'package:info_91_proj/feature/auth/presentation/pages/login_page.dart';
import 'package:info_91_proj/feature/auth/presentation/pages/welcome_page.dart';
import 'package:info_91_proj/feature/home/home_page.dart';
import 'package:info_91_proj/feature/profile/profile_page.dart';

class AuthController extends GetxController {
  late final busy = false.obs;

  late final _authRepository = AuthRepository();
  late final _userProfileRepository = UserProfileRepository();
  late final _sharedPreferences = SharedPreferencesDataProvider();

  void gotoLandingPage() async {
    try {
      busy(true);
      String token = await _authRepository.getAccessToken();
      print("token$token");
      if (token.isNotEmpty) {
        _gotoLandingPage();
      } else {
        gotoLoginPage();
      }
      busy(false);
    } catch (_) {
      print('error: landing: ${_.toString()}');
      gotoLoginPage();
    }
  }

  void _gotoLandingPage() async {
    try {
      print("ApiConstants.user");
      final response = await _userProfileRepository.getUser();
      print("ApiConstants.user${response.success}");
      if (response.success) {
        if (response.user != null && response.user!.name.isEmpty) {
          Get.offAllNamed(ProfilePage.routeName);
        } else {
          Get.offAllNamed(HomePage.routeName);
        }
      } else if (response.statusCode == 401) {
        gotoLoginPage();
      }
    } on FetchDataException catch (_) {
      showRetry();
    } catch (_) {
      if (_ is UnauthorisedException) {
        gotoLoginPage();
      } else {
        AppDialog.showToast(_.toString());
      }
    }
  }

  void showRetry() {
    AppDialog.showDialog(
        title: "No Internet connection",
        negativeText: "Retry",
        negativeOnPressed: () {
          _gotoLandingPage();
          Get.back();
        },
        content: "Please check your connection and try again.");
  }

  void gotoLoginPage() async {
    Get.offAllNamed(WelcomePage.routeName);
  }

  void _gotoProfileUpdate() {
    print("eeeeeeeq1");
    Get.offAllNamed(ProfilePage.routeName);
  }

  void logout() {
    _authRepository.logoutUser();
    print("eeeeeeeq2");
    Get.offAllNamed(LoginPage.routeName);
  }
}
