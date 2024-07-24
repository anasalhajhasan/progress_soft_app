import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_soft_app/application_layer/resources/color_manager.dart';
import 'package:progress_soft_app/application_layer/resources/fonts_manager.dart';
import 'package:progress_soft_app/application_layer/resources/styles_manager.dart';

class AppThemes {
  // Private constructor
  AppThemes._internal();

  // Single instance of the class
  static final AppThemes _instance = AppThemes._internal();

  // Factory constructor to return the single instance
  factory AppThemes() {
    return _instance;
  }

  final lightTheme = ThemeData(
    canvasColor: ColorManager.white,
    focusColor: ColorManager.white,
    splashColor: HexColor.fromHex("#003169"),
    hoverColor: HexColor.fromHex("#4E4E4E"),

    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.primaryColorLight,
    primaryColorDark: ColorManager.primaryColorDark,

    listTileTheme: ListTileThemeData(
      tileColor: ColorManager.white,
    ),

    brightness: Brightness.light,
    shadowColor: Colors.grey,
    cardColor: Colors.black.withOpacity(0.1),

    // Text theme
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.poppins(
        textStyle: getRegularStyle(color: ColorManager.black),
      ),
      displayLarge: GoogleFonts.poppins(
        textStyle:
            getRegularStyle(color: ColorManager.black, fontSize: FontSize.s15),
      ),
      displayMedium: GoogleFonts.poppins(
        textStyle:
            getSemiBoldStyle(color: ColorManager.black, fontSize: FontSize.s15),
      ),
      displaySmall: GoogleFonts.poppins(
        textStyle:
            getBoldStyle(color: ColorManager.black, fontSize: FontSize.s15),
      ),
      headlineMedium: GoogleFonts.poppins(
        textStyle:
            getMediumStyle(color: ColorManager.black, fontSize: FontSize.s12),
      ),
      headlineSmall: GoogleFonts.poppins(
        textStyle: getBoldStyle(
            color: ColorManager.accentColor, fontSize: FontSize.s15),
      ),
      titleLarge: GoogleFonts.poppins(
        textStyle:
            getBoldStyle(color: ColorManager.grey, fontSize: FontSize.s14),
      ),
      bodySmall: GoogleFonts.poppins(
        textStyle:
            getMediumStyle(color: ColorManager.black, fontSize: FontSize.s12),
      ),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ColorManager.primary,
      selectedItemColor: Colors.white,
      selectedLabelStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: ColorManager.white,
      ),
    ),

    // App bar theme
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      toolbarHeight: 66.6,
      iconTheme: IconThemeData(size: 25, color: ColorManager.grey),
      titleTextStyle:
          getRegularStyle(color: ColorManager.grey, fontSize: FontSize.s15),
    ),

    inputDecorationTheme: InputDecorationTheme(
      fillColor: ColorManager.grey.withOpacity(0.1),

      // Hint style
      hintStyle: GoogleFonts.poppins(
        fontSize: 15,
        color: ColorManager.grey.withOpacity(0.5),
      ),

      // Label style
      labelStyle: GoogleFonts.poppins(
        color: ColorManager.black,
        fontSize: 13,
      ),
    ),

    iconTheme: IconThemeData(
      color: ColorManager.white,
    ),

    dividerColor: ColorManager.lightGray,
    colorScheme: ColorScheme.fromSwatch(
      accentColor: ColorManager.accentColor,
      brightness: Brightness.light,
    ).copyWith(background: ColorManager.white),
  );
}
