import 'package:akij_login_app/constants/app_colors.dart';
import 'package:akij_login_app/constants/app_size.dart';
import 'package:akij_login_app/constants/app_style.dart';
import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData mainTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.bgCol,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      centerTitle: true,
      titleTextStyle: appbarTextStyle,
    ),
    hintColor: AppColors.hintTextColor,
    inputDecorationTheme: InputDecorationTheme(
      focusColor: AppColors.butCol,
      border: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(
          Radius.circular(AppSize.textFieldBorderRadius),
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(
          Radius.circular(AppSize.textFieldBorderRadius),
        ),
      ),
      filled: true,
      fillColor: AppColors.textFieldGrey,
    ),
    scrollbarTheme: const ScrollbarThemeData().copyWith(
      thumbColor: MaterialStateProperty.all(AppColors.primCol),
    ),

    // bottomAppBarColor: Colors.white,
    // bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    //     type: BottomNavigationBarType.fixed,
    //     backgroundColor: Colors.white,
    //     selectedItemColor: Colors.white),
    textTheme: TextTheme(
      displayLarge: displayLarge,
      displayMedium: displayMedium,
      displaySmall: displaySmall,
      headlineMedium: headlineMedium,
      headlineSmall: headlineSmall,
      bodyLarge: bodyLarge,
      bodyMedium: bodyMedium,
      bodySmall: bodySmall,
      titleMedium: titleMedium,
      labelLarge: labelLarge,
      labelMedium: labelMedium,
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    fontFamily: "Montserrat",
  );
}
