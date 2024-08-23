import 'package:get/get.dart';
import 'package:info_91_proj/feature/auth/data/auth_repository.dart';
import 'package:info_91_proj/feature/profile/controllers/profile_controller.dart';

class HomeController extends GetxController {
  late final _authRepository = AuthRepository();
  @override
  void onInit() {
    super.onInit();
  }

  void logout() {
    Get.find<ProfileController>().logout();
  }
}
