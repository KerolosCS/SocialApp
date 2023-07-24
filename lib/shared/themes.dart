import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_app/shared/colors.dart';

ThemeData darkTheme = ThemeData(
  textTheme: const TextTheme(
    titleMedium: TextStyle(
      color: Colors.white,
      fontSize: 16,
    ),
  ),
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: const Color(0xff282C34),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
    elevation: 20,
    backgroundColor: Color(0xff282C34),
  ),
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    backgroundColor: Color(0xff282C34),
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Color(0xff282C34),
    ),
  ),
);

ThemeData lightMode = ThemeData(
  textTheme: const TextTheme(
    titleMedium: TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
  ),
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    elevation: 20,
  ),
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    backgroundColor: Colors.white,
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.white,
    ),
  ),
);
