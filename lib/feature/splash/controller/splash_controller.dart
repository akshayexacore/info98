import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:info_91_proj/feature/auth/controllers.dart/auth_controller.dart';
import 'package:info_91_proj/feature/auth/data/auth_repository.dart';

class SplashController extends GetxController {
  var isBusy = false.obs;
  late final _authRepository = AuthRepository();

  @override
  void onInit() {
    gotoHomePage();
    super.onInit();
  }

  void gotoHomePage() async {
    isBusy(true);
    await Future.delayed(const Duration(seconds: 3)).then((value) {
      Get.find<AuthController>().gotoLandingPage();
    });
    isBusy(false);
  }
}
