import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: primaryColor,
    onPrimary: Colors.black,
    secondary: secondaryColor,
    onSecondary: Colors.black,
    error: Colors.red,
    onError: Colors.black,
    surface: surfaceColor,
    onSurface: onSurfaceColor,
  ),
  scaffoldBackgroundColor: primaryColor,
  elevatedButtonTheme: const ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(surfaceColor),
    ),
  ),
  appBarTheme: const AppBarTheme(
    elevation: 3.0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 24,
      fontWeight: FontWeight.w600,
    ),
    backgroundColor: surfaceColor,
    centerTitle: true,
    shape: OutlineInputBorder(
      borderSide: BorderSide(
        color: onSurfaceColor,
        width: 1,
      ),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(16),
        bottomRight: Radius.circular(16),
      ),
    ),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      color: Colors.black,
      fontSize: 24,
    ),
    bodyMedium: TextStyle(
      color: Colors.black,
      fontSize: 22,
    ),
    bodySmall: TextStyle(
      color: Colors.black,
      fontSize: 20,
    ),
    labelMedium: TextStyle(
      color: Colors.black,
      fontSize: 16,
    ),
  ),
  bottomAppBarTheme: const BottomAppBarTheme(
    color: onSurfaceColor,
    elevation: 3.0,
    surfaceTintColor: surfaceColor,
  ),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: Colors.redAccent,
    contentTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
  ),
);

const Color primaryColor = Color(0xffFFE9D0);
const Color secondaryColor = Color(0xFFFFFED3);
const Color errorColor = Colors.red;
const Color surfaceColor = Color(0xffBBE9FF);
const Color onSurfaceColor = Color(0xffB1AFFF);
const Color iconColor = Colors.black54;
