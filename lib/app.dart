import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:info_91_proj/core/config/app_styles.dart';
import 'package:info_91_proj/feature/splash/splash_page.dart';
import 'package:info_91_proj/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (BuildContext context) => 'info91',
      theme: AppThemes.appTheme,
      initialRoute: SplashPage.routeName,
      getPages: Routes.getPages,
    );
  }
}
