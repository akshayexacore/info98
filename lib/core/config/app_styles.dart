import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppFonts {
  static const primaryFontFamily = 'Poppins';
}

class AppFontSizes {
  static const xxxSmall = 10.0;
  static const xxSmall = 12.0;
  static const xSmall = 13.0;
  static const small = 14.0;
  static const medium = 16.0;
  static const large = 18.0;
  static const xLarge = 20.0;
  static const xxLarge = 24.0;
  static const xxxLarge = 36.0;

  static const appHeader = xxLarge;
  static const appTitle = large;
  static const appSubTitle = small;
  static const appContent = xSmall;
  static const appFooter = xxSmall;
  static const authTitle = xxxLarge;
  static const planTitle = large;
  static const planPrice = small;
  static const appButton = large;
  static const inputText = large;
}

class AppTextStyles {
  static const appLightText = TextStyle(
    fontSize: AppFontSizes.medium,
    fontWeight: FontWeight.w400,
    color: AppColors.textMainSubtitle,
  );

  static const appBarTitle = TextStyle(
      fontSize: AppFontSizes.large,
      fontWeight: FontWeight.w400,
      color: AppColors.white);
  static const appHeader = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: AppFontSizes.appHeader,
    color: AppColors.appBarTitle,
  );
  static const appTitle = TextStyle(
    fontSize: AppFontSizes.large,
    fontWeight: FontWeight.bold,
  );

  static const appItemTitle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
  );

  static const appFeatureTitle = TextStyle(
    fontSize: AppFontSizes.small,
    fontWeight: FontWeight.w500,
  );
  static const appSubTitle =
      TextStyle(fontSize: AppFontSizes.appSubTitle, color: AppColors.text);

  static const appContent = TextStyle(
    fontSize: AppFontSizes.appContent,
  );

  static const inputHintText = TextStyle(
    fontSize: AppFontSizes.small,
    color: AppColors.hint,
    fontWeight: FontWeight.w400,
    overflow: TextOverflow.clip,
  );

  static const alertDialogTitle = TextStyle(
    fontSize: AppFontSizes.appTitle,
    fontWeight: FontWeight.w600,
    color: AppColors.textMainSubtitle,
  );
  static const alertDialogContent = TextStyle(
    fontSize: AppFontSizes.appContent,
    color: AppColors.textSubtitle,
  );
  static const appButton = TextStyle(
    fontSize: AppFontSizes.medium,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
  );
  static const appTitleSemiBold = TextStyle(
    fontSize: AppFontSizes.medium,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
  );
  static const inputText = TextStyle(
    fontSize: AppFontSizes.small,
    color: AppColors.text,
  );
  static const textButton = TextStyle(
    fontSize: AppFontSizes.appTitle,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  static const app16B = TextStyle(
    fontSize: AppFontSizes.medium,
    fontWeight: FontWeight.w700,
    color: AppColors.text,
  );

  static const app14N = TextStyle(
    fontSize: AppFontSizes.small,
    fontWeight: FontWeight.normal,
    color: AppColors.text,
  );
  static const app12SB = TextStyle(
    fontSize: AppFontSizes.xxSmall,
    fontWeight: FontWeight.w500,
    color: AppColors.text,
  );
}

class AppThemes {
  static final appTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
    fontFamily: AppFonts.primaryFontFamily,
    textTheme: textDefault,
    primaryColor: AppColors.primary,
    primarySwatch: AppColors.primaryAppSwatch,
    splashColor: AppColors.primary.withOpacity(0.4),
    appBarTheme: AppThemes.appBar,
  );
  static const appBar = AppBarTheme(
    backgroundColor: AppColors.appBarBackgroundColor,
    elevation: AppElevations.appBar,
    iconTheme: appBarIcon,
    titleTextStyle: AppTextStyles.appBarTitle,
  );
  static const appBarIcon = IconThemeData(
    color: AppColors.appBarTitle,
  );

  static var textDefault = const TextTheme(
    bodySmall: TextStyle(),
    bodyLarge: TextStyle(),
    headlineMedium: TextStyle(),
  ).apply(
    bodyColor: AppColors.text,
    displayColor: AppColors.text,
  );
}

class AppButtonStyles {
  static final appButton = TextButton.styleFrom(
    backgroundColor: AppColors.primary,
    elevation: AppElevations.appButton,
    foregroundColor: AppColors.primary,
    padding: const EdgeInsets.all(AppPaddings.zero),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadii.xSmall)),
  );
  static final appBorderButton = TextButton.styleFrom(
    foregroundColor: Colors.white,
    backgroundColor: Colors.white,
    elevation: AppElevations.appButton,
    padding: const EdgeInsets.all(AppPaddings.zero),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadii.xSmall),
        side: const BorderSide(color: AppColors.hint, width: 1)),
  );
  static final appButtonDisabled = TextButton.styleFrom(
    foregroundColor: AppColors.primaryAccent,
    backgroundColor: AppColors.white,
    elevation: AppElevations.appButton,
    padding: const EdgeInsets.all(AppPaddings.zero),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadii.medium)),
  );
  static final appRoundButton = TextButton.styleFrom(
    foregroundColor: AppColors.primaryAccent,
    backgroundColor: AppColors.primary,
    elevation: AppElevations.appButton,
    padding: const EdgeInsets.all(AppPaddings.zero),
    shape: const StadiumBorder(),
  );
  static final appRoundButtonDisabled = TextButton.styleFrom(
    foregroundColor: AppColors.primaryAccent,
    backgroundColor: AppColors.hint,
    elevation: AppElevations.appButton,
    padding: const EdgeInsets.all(AppPaddings.zero),
    shape: const StadiumBorder(),
  );
  static final alertDialogPositive = TextButton.styleFrom(
    foregroundColor: AppColors.primaryAccent,
    backgroundColor: AppColors.primary,
    elevation: AppElevations.appButton,
    padding: const EdgeInsets.all(AppPaddings.zero),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadii.medium),
    ),
  );
  static final alertDialogNegative = TextButton.styleFrom(
    elevation: AppElevations.appButton,
    padding: const EdgeInsets.all(AppPaddings.zero),
    shape: RoundedRectangleBorder(
      side: const BorderSide(color: AppColors.black),
      borderRadius: BorderRadius.circular(AppRadii.medium),
    ),
  );
  static final textButton =
      TextButton.styleFrom(textStyle: AppTextStyles.textButton);
}

class AppColors {
  static const primary = Color(0xFF262262);
  static const secondary = Color(0xffFF7500);
  static const primaryAccent = primary;
  static const text = Color(0xff333333);
  static const lightText = Color(0xFF897B86);
  static const border = Color.fromRGBO(0, 0, 0, 0.25);
  static const textContent = Color(0xFF848484);
  static const textSubtitle = Color(0xFF2D2D2D);
  static const textCategory = Color(0xFF3E3E3E);
  static const textMainSubtitle = Color(0xFF737373);
  static const divider = Color(0xFFADADAD);
  static const primaryAppSwatch = MaterialColor(0xFF5c2a7a, color);
  static const scaffoldBackgroundColor = Colors.white;
  static const white = Colors.white;
  static const black = Colors.black;
  static const hint = text;
  static const shadow = Color.fromRGBO(41, 41, 41, 0.8);

  static const color = {
    50: Color.fromRGBO(28, 117, 178, .1),
    100: Color.fromRGBO(28, 117, 178, .2),
    200: Color.fromRGBO(28, 117, 178, .3),
    300: Color.fromRGBO(28, 117, 178, .4),
    400: Color.fromRGBO(28, 117, 178, .5),
    500: Color.fromRGBO(28, 117, 178, .6),
    600: Color.fromRGBO(28, 117, 178, .7),
    700: Color.fromRGBO(28, 117, 178, .8),
    800: Color.fromRGBO(28, 117, 178, .9),
    900: Color.fromRGBO(28, 117, 178, 1),
  };

  static const Color shimmerBaseColor = Color(0xffF0F1F4);
  static const Color shimmerHighlightColor = Color(0xffDBDFE9);
  static const Color fb = Color(0xff3B5998);
  static const Color google = Color(0xffEFEFEF);
  static const appBarBackgroundColor = backgroundWhite;
  static const appBarTitle = text;
  static const backgroundWhite = white;
  static const splashBackground = Color(0xffEEEEEE);
  static const inputLightBorder = shimmerHighlightColor;
}

class AppSpacings {
  static const zero = 0.0;
  static const xxSmall = 4.0;
  static const xSmall = 8.0;
  static const small = 12.0;
  static const medium = 24.0;
  static const xMedium = 20.0;
  static const xxMedium = 15.0;
  static const xxLarge = 30.0;
  static const xxxLarge = 54.0;
  static const logoSpaceTop = 84.0;
}

class AppPaddings {
  static const zero = 0.0;
  static const xxxSmall = 3.0;
  static const xxSmall = 5.0;
  static const xSmall = 8.0;
  static const small = 12.0;
  static const medium = 15.0;
  static const mediumX = 18.0;
  static const large = 20.0;
  static const xLarge = 24.0;
  static const xxLarge = 30.0;
  static const xxxLarge = xxLarge;

  static const appBarDefault = xxLarge;
  static const inputTextVertical = 6.0;
  static const inputTextHorizontal = large;
  static const authContent = xxxLarge;
  static const onBoardingContent = xxxLarge;
  static const alertDialog = large;
  static const otpContent = 40.0;
  static const otpInputPadding = xxLarge;
}

class AppElevations {
  static const zero = 0.0;

  static const appButton = zero;
  static const appBar = zero;
}

class AppSizes {
  static const appButton = 230.0;
  static const appButtonHeight = 50.0;
  static const dialogButtonHeight = 42.0;
  static const appBarHeight = 80.0;
  static const appBackButton = 46.0;
  static const logoHeight = 100.0;
  static const logoWidth = 180.0;
  static const alertDialog = 320.0;
  static const bottomNavigationIconSize = 24.0;
}

class AppRadii {
  static double zero = 0.0;
  static const xSmall = 8.0;
  static const small = 15.0;
  static const medium = 20.0;
  static const large = 30.0;
}

class AppBorders {
  /* static final inputText = OutlineInputBorder(
    borderRadius: BorderRadius.circular(AppRadii.inputText),
    borderSide: const BorderSide(
      color: AppColors.inputTextBorder,
      width: 2.0,
    ),
  );
  static final inputTextDark = OutlineInputBorder(
    borderRadius: BorderRadius.circular(AppRadii.inputText),
    borderSide: const BorderSide(
      color: AppColors.inputTextBorderDark,
      width: 2.0,
    ),
  );*/
}

class AppShadows {
  static final shadow = BoxShadow(
    color: AppColors.shadow.withOpacity(0.08),
    blurRadius: 10,
    offset: const Offset(0, 0),
  );
}
