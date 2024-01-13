import 'package:flutter/material.dart';

const Color primaryColor = Color.fromARGB(255, 150, 143, 255);
const Color accentColor = Color.fromARGB(255, 255, 91, 121);
const Color darkColor = Color(0xFF131218);
const Color buttonColor = Color.fromARGB(255, 233, 231, 130);
const Color backgroundColor = Color(0xFF161516);

const Color backgroundColor2 = Color(0xFF17203A);
const Color backgroundColorLight = Color(0xFFF2F6FF);
const Color backgroundColorDark = Color(0xFF25254B);
const Color shadowColorLight = Color(0xFF4A5367);
const Color shadowColorDark = Colors.black;

final ThemeData themeData = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: const Color.fromARGB(255, 22, 21, 22),
  primaryColor: primaryColor,
  appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent),
  brightness: Brightness.dark,
  fontFamily: "Raleway",
  visualDensity: VisualDensity.adaptivePlatformDensity,
);
