import 'package:contacts_service/contacts_service.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:info_91_proj/core/variables.dart';
import 'package:info_91_proj/feature/auth/controllers.dart/auth_controller.dart';
import 'package:info_91_proj/feature/auth/data/auth_repository.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashController extends GetxController {
  var isBusy = false.obs;
  late final _authRepository = AuthRepository();

  @override
  void onInit() {
    gotoHomePage();
    super.onInit();
  }

  void gotoHomePage() async {
    String token = await _authRepository.getAccessToken();
    if(token.isNotEmpty){
      _requestContactPermission();
    }
    isBusy(true);
    await Future.delayed(const Duration(seconds: 3)).then((value) {
      Get.find<AuthController>().gotoLandingPage();
    });
    isBusy(false);
  }   Future<void> _requestContactPermission() async {
    if (await Permission.contacts.request().isGranted) {
      print('Contact permission get');
      fetchContacts();
    } else {
     
      print('Contact permission denied');
    }
  }
  Future<void> fetchContacts() async {
    
    try {
      final Iterable<Contact> contacts = await ContactsService.getContacts();
      print('Contact permission ge2t${contacts.length}');

      Variables.userContact= contacts.toList();
    } catch (e) {
      print('Error fetching contacts: $e');
    }
  }
}
