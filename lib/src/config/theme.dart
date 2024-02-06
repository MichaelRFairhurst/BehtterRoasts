import 'package:flutter/material.dart';

final appTheme = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'Roboto',
  colorScheme: const ColorScheme.dark().copyWith(
    primary: Colors.purple,
    secondary: Colors.grey,
  ),
  bottomAppBarTheme: BottomAppBarTheme(
    color: Colors.grey[800],
  ),
  appBarTheme: const AppBarTheme(
    //backgroundColor: Colors.white,
    //foregroundColor: Colors.black,
  ),
  //textTheme: ThemeData.light().textTheme.copyWith(
  //      bodyText2: const TextStyle(
  //        fontWeight: FontWeight.w600,
  //      ),
  //    ),
  //dialogTheme: DialogTheme(
  //  shape: RoundedRectangleBorder(
  //    borderRadius: BorderRadius.circular(16),
  //  ),
  //),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
    ),
  ),
  //elevatedButtonTheme: ElevatedButtonThemeData(
  //  style: ElevatedButton.styleFrom(
  //    maximumSize: const Size(1000, 48),
  //    minimumSize: const Size(0, 48),
  //    padding: const EdgeInsets.all(8),
  //    primary: Colors.white,
  //    onPrimary: Colors.black,
  //    elevation: 1.0,
  //    shape: RoundedRectangleBorder(
  //      borderRadius: BorderRadius.circular(24),
  //      side: const BorderSide(color: Colors.black, width: 1.0),
  //    ),
  //  ),
  //),
  //floatingActionButtonTheme: FloatingActionButtonThemeData(
  //  backgroundColor: Colors.grey,
  //  foregroundColor: Colors.white,
  //  elevation: 0.0,
  //  iconSize: 15,
  //  // TODO: why does it require a size of 40 to match ElevatedButton's height of 48?
  //  smallSizeConstraints: BoxConstraints.tight(const Size(40, 40)),
  //),
);
