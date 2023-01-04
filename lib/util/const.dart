import 'package:dabbabi_service/util/colors.dart';
import 'package:flutter/material.dart';
class Constants{

  static String appName = "Dabbabi Service";
  static String appVersion= "0.0.1 Closed Beta --Debug";

  //Colors for theme
//  Color(0xfffcfcff);


  static ThemeData lightTheme = ThemeData(
    backgroundColor: AppColors.lightBG,
    primaryColor: AppColors.lightPrimary,
    accentColor:  AppColors.lightAccent,

    scaffoldBackgroundColor: AppColors.lightBG,
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(
          color: Colors.teal
      ),
      backgroundColor: Colors.black,
      titleTextStyle: TextStyle(
          color: Colors.white,
        fontSize: 18.0,
        fontWeight: FontWeight.w800,
      ),
      textTheme: TextTheme(
        subtitle1: TextStyle(
          color: AppColors.darkBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ),
//      iconTheme: IconThemeData(
//        color: lightAccent,
//      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: AppColors.darkBG,
    primaryColor: AppColors.darkPrimary,
    accentColor: AppColors.darkAccent,
    scaffoldBackgroundColor: AppColors.darkBG,

    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
 titleTextStyle: TextStyle(
   color: Colors.black,
   fontSize: 18.0,
   fontWeight: FontWeight.w800,
 ),
      iconTheme: IconThemeData(
        color: Colors.teal
      ),
      textTheme: TextTheme(

        subtitle1: TextStyle(
          color: AppColors.lightBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ),
//      iconTheme: IconThemeData(
//        color: darkAccent,
//      ),
    ),
  );


}