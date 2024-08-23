import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_91_proj/core/config/app_styles.dart';
import 'package:info_91_proj/core/image_view.dart';
import 'package:info_91_proj/core/tiny/app_button.dart';
import 'package:info_91_proj/core/tiny/app_input_text.dart';
import 'package:info_91_proj/feature/auth/controllers.dart/login_contoller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  static const routeName = '/login';

  final _loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.splashBackground,
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.12,
                  child: Image.asset('assets/images/ic_enter_phone.png')),
              SizedBox(
                height: AppSpacings.xMedium,
              ),
              Text(
                "Enter your phone number",
                style: AppTextStyles.appTitle,
              ),
              SizedBox(
                height: AppSpacings.xSmall,
              ),
              Text("We will send you a confirmation code as SMS",
                  style: AppTextStyles.app14N, textAlign: TextAlign.center),
              const SizedBox(
                height: AppSpacings.medium,
              ),
              AppInputText(
                  shadow: false,
                  border: true,
                  hintText: "Mobile number",
                  keyboardType: TextInputType.phone,
                  controller: _loginController.textControllerPhone,
                  prefixIcon: Obx(() {
                    return GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: _loginController.gotoCountryPicker,
                      child: SizedBox(
                        height: 30,
                        child: Container(
                          padding: const EdgeInsets.only(top: 0, right: 12),
                          margin: const EdgeInsetsDirectional.only(
                              top: 6, bottom: 6),
                          decoration: const BoxDecoration(
                              border: Border(
                                  right: BorderSide(
                            width: 1,
                            color: AppColors.border,
                          ))),
                          child: Text(
                            "${_loginController.country.value.flagEmoji} +${_loginController.country.value.phoneCode}",
                            style: AppTextStyles.inputText,
                          ),
                        ),
                      ),
                    );
                  }),
                  suffixIcon: Obx(() {
                    if (_loginController.isPhoneValid.isFalse) {
                      return const SizedBox.shrink();
                    }
                    return const SizedBox(
                        height: 20,
                        width: 20,
                        child: Center(
                            child: AppAssetImage(
                          "assets/images/ic_correct.png",
                          width: 20,
                          height: 20,
                        )));
                  })),
              const SizedBox(
                height: AppSpacings.medium,
              ),
              Obx(() {
                return AppButton(
                    text: "SEND OTP",
                    busy: _loginController.busy.value,
                    onPressed: _loginController.verifyPhone);
              }),
              Spacer(),
              Text.rich(
                TextSpan(
                  text: "By continuing you are agreeing to our\n",
                  style: AppTextStyles.app12SB,
                  children: <TextSpan>[
                    TextSpan(
                      text: "Terms of use",
                      recognizer: TapGestureRecognizer()..onTap = () {},
                      style: AppTextStyles.app12SB.copyWith(
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w800),
                    ),
                    TextSpan(
                      text: " and ",
                    ),
                    TextSpan(
                      text: "Privacy policy",
                      recognizer: TapGestureRecognizer()..onTap = () {},
                      style: AppTextStyles.app12SB.copyWith(
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
