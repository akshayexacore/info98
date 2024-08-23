import 'package:get/get.dart';
import 'package:info_91_proj/feature/auth/controllers.dart/auth_controller.dart';
import 'package:info_91_proj/feature/auth/controllers.dart/login_contoller.dart';
import 'package:info_91_proj/feature/auth/presentation/pages/login_page.dart';
import 'package:info_91_proj/feature/auth/presentation/pages/otp_page.dart';
import 'package:info_91_proj/feature/auth/presentation/pages/welcome_page.dart';
import 'package:info_91_proj/feature/home/controllers/home_controller.dart';
import 'package:info_91_proj/feature/home/home_page.dart';
import 'package:info_91_proj/feature/profile/controllers/profile_controller.dart';
import 'package:info_91_proj/feature/profile/profile_page.dart';
import 'package:info_91_proj/feature/splash/controller/splash_controller.dart';
import 'package:info_91_proj/feature/splash/splash_page.dart';

class Routes {
  static var getPages = [
    GetPage(
        name: SplashPage.routeName,
        page: () => SplashPage(),
        binding: BindingsBuilder(() => {
              Get.lazyPut(() => SplashController()),
              Get.lazyPut(() => AuthController()),
            })),
    GetPage(
        name: WelcomePage.routeName,
        page: () => WelcomePage(),
        binding: BindingsBuilder(() => {
              Get.lazyPut(() => LoginController()),
              Get.lazyPut(() => AuthController()),
            })),
    GetPage(
        name: LoginPage.routeName,
        page: () => LoginPage(),
        binding: BindingsBuilder(() => {
              Get.lazyPut(() => LoginController()),
              Get.lazyPut(() => AuthController()),
            })),
    GetPage(
        name: OtpPage.routeName,
        page: () => OtpPage(),
        binding: BindingsBuilder(() => {
              Get.lazyPut(() => LoginController()),
              Get.lazyPut(() => AuthController()),
            })),
    GetPage(
        name: ProfilePage.routeName,
        page: () => ProfilePage(),
        binding: BindingsBuilder(() => {
              Get.lazyPut(() => ProfileController()),
              Get.lazyPut(() => AuthController()),
            })),
    GetPage(
        name: HomePage.routeName,
        page: () => HomePage(),
        binding: BindingsBuilder(() => {
              Get.lazyPut(() => HomeController()),
              Get.lazyPut(() => ProfileController()),
            })),
  ];
}
