import 'package:flutter/material.dart';

ThemeData appThemeDark() {
  return ThemeData(
    // This is the theme of your application.
    //
    // Try running your application with "flutter run". You'll see the
    // application has a blue toolbar. Then, without quitting the app, try
    // changing the primarySwatch below to Colors.green and then invoke
    // "hot reload" (press "r" in the console where you ran "flutter run",
    // or simply save your changes to "hot reload" in a Flutter IDE).
    // Notice that the counter didn't reset back to zero; the application
    // is not restarted.
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
    primaryColor: Color.fromARGB(255, 60, 59, 59),
    scaffoldBackgroundColor: Color.fromARGB(255, 24, 24, 24),
    appBarTheme: const AppBarTheme(
      color: Colors.transparent,
      elevation: 0,
      toolbarTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
      foregroundColor: Colors.white,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: TextStyle(
        color: Color.fromARGB(255, 208, 207, 207),
        fontSize: 12,
      ),
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    tabBarTheme: const TabBarTheme(
      labelColor: Colors.red,
      unselectedLabelColor: Color.fromARGB(255, 208, 207, 207),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(
        color: Colors.white,
      ),
      border: UnderlineInputBorder(
        borderSide: BorderSide(
          width: 10,
          color: Colors.white,
        ),
      ),
    ),
  );
}
