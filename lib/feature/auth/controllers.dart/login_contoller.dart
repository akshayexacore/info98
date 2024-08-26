import 'dart:async';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_91_proj/core/config/app_styles.dart';
import 'package:info_91_proj/core/widgets.dart/app_dialog.dart';
import 'package:info_91_proj/feature/auth/controllers.dart/auth_controller.dart';
import 'package:info_91_proj/feature/auth/data/auth_repository.dart';
import 'package:info_91_proj/feature/auth/data/user_repository.dart';
import 'package:info_91_proj/feature/auth/presentation/pages/login_page.dart';
import 'package:info_91_proj/feature/auth/presentation/pages/otp_page.dart';
import 'package:info_91_proj/feature/auth/presentation/widgets/login_success_dialog.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';

class LoginController extends GetxController {
  late var busy = false.obs;
  late var isPhoneValid = false.obs;
  late var isOtpValid = false.obs;
  late final resendRemaining = 0.obs;

  late Timer _timer;
  final int timerDuration2 = 180;

  final int timerDuration1 = 60;

  late final textControllerPhone = TextEditingController();
  late final textControllerOtp = TextEditingController();

  late final _authRepository = AuthRepository();
  late final _userProfileRepository = UserProfileRepository();

  late final _authController = Get.find<AuthController>();

  var country = Country.parse("IN").obs;

  var phone = PhoneNumber(isoCode: IsoCode.IN, nsn: "").obs;

  @override
  void onInit() {
    busy = _authController.busy;
    textControllerPhone.addListener(() {
      validatePhone();
    });
    super.onInit();
  }

  void verifyPhone() async {
    busy(true);
    try {
      String phoneNumber = textControllerPhone.text;

      if (phone.value.isValid()) {
        final response = await _authRepository.sendOtp(
            phone.value.nsn, phone.value.countryCode);

        if (response.isSuccess) {
          busy(false);
          print("sdfghj${response.result["otp"].runtimeType}");
          gotoOtpPage(response.result["otp"]);
        } else {
          busy(false);
          AppDialog.showSnackBar('Failed to send OTP',
              'OTP sending failed, please check the number.');
        }
      } else {
        busy(false);
        AppDialog.showSnackBar(
            'Invalid phone number', 'Please check the phone number.');
      }
    } catch (_) {
      print(_.toString());
      busy(false);
      AppDialog.showSnackBar('Login Failed', 'Something went wrong.');
    } finally {}
  }

  void gotoLoginPage() {
    Get.offAllNamed(LoginPage.routeName);
  }

  void gotoLandingPage() async {
    _authController.gotoLandingPage();
  }

  void gotoTermsCondition() {}

  void gotoCountryPicker() {
    showCountryPicker(
      context: Get.context!,
      showPhoneCode: true,
      favorite: ["IN"],
      countryListTheme: CountryListThemeData(
          borderRadius: BorderRadius.circular(15),
          bottomSheetHeight: MediaQuery.of(Get.context!).size.height * 0.6,
          textStyle: AppTextStyles.app14N,
          inputDecoration: InputDecoration(
              labelText: "Search",
              hintText: "Search",
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: const Color(0xFF8C98A8).withOpacity(0.2),
                ),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 3))),
      onSelect: (Country c) {
        country(c);
        validatePhone();
      },
    );
  }

  void validatePhone() {
    try {
      final phoneCheck = PhoneNumber.parse(
          '+${country.value.phoneCode} ${textControllerPhone.text.trim()}');
      isPhoneValid(phoneCheck.isValid(type: PhoneNumberType.mobile));
      phone(phoneCheck);
    } catch (_) {
      isPhoneValid(false);
    }
  }

  void gotoOtpPage(int otp) {
    Get.toNamed(OtpPage.routeName, arguments: {'otp': otp});
    startTimer(timerDuration1);
  }

  void startTimer(int duration) {
    resendRemaining(duration);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendRemaining.value > 0) {
        resendRemaining.value--;
      } else {
        _timer.cancel();
      }
    });
  }

  void cancelTimer() {
    _timer.cancel();
  }

  void verifyOtp() async {
    busy(true);
    try {
      if (textControllerOtp.text.isNotEmpty &&
          textControllerOtp.text.length == 4) {
        final response = await _authRepository.verifyOtp(
            phone.value, textControllerOtp.text);
        if (response.success) {
          await _authRepository
              .saveAccessToken('${response.tokenType} ${response.token}');
          await _authRepository.saveRefreshToken(response.refreshToken);
          await _userProfileRepository.saveUser(response.user!);
          showSuccessDialog();
        } else {
          AppDialog.showSnackBar('Otp Verification Failed', response.message);
          busy(false);
        }
      } else {
        Get.closeAllSnackbars();
        AppDialog.showSnackBar('Invalid OTP', 'Please enter a valid OTP');
        busy(false);
      }
    } catch (_) {
      print(_.toString());
      busy(false);
      AppDialog.showSnackBar('Otp Verification Failed', 'Something went wrong');
    } finally {}
  }
}

void showSuccessDialog() {
  Get.dialog(const LoginSuccessDialog(), barrierDismissible: false);
}
