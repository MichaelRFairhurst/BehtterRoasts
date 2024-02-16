import 'package:flutter/material.dart';

class RoastAppTheme {

  //static const lilac = Color(0xFF9787B5);
  static const lilac = Color(0xFFA08DB5);
  static const indigo = Color(0xFFACBEE3);
  static const crema = Color(0xFFDED8D3);
  static const cremaLight = Color(0xFFFAF5F0);
  static const capuccino = Color(0xFF3B312A);
  static const capuccinoLight = Color(0xFF4B413A);
  static const metal = Color(0xFF606466);
  static const metalDark = Color(0xFF494F52);
  static const metalLight = Color(0xFFA9A7AB);
  static const lime = Color(0xFFC8E6D6);

  static final keypadButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        foregroundColor: capuccino,
        backgroundColor: crema,
		shadowColor: capuccino,
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: const BorderSide(color: Colors.black, width: 1.0),
        ),
	),
  );

  static final materialTheme = ThemeData.localize(
    ThemeData(
	  brightness: Brightness.light,
	  fontFamily: 'Roboto',
	  colorScheme: const ColorScheme.light().copyWith(
		primary: capuccino,
		secondary: indigo,
		tertiary: indigo,
		surface: cremaLight,
	  ),
	  bottomAppBarTheme: const BottomAppBarTheme(
		color: lime,
		elevation: 4.0,
	  ),
	  outlinedButtonTheme: OutlinedButtonThemeData(
		style: OutlinedButton.styleFrom(
		  backgroundColor: Colors.black,
		  foregroundColor: Colors.white,
		),
	  ),
	  canvasColor: cremaLight,
	  elevatedButtonTheme: ElevatedButtonThemeData(
		style: ElevatedButton.styleFrom(
		  foregroundColor: capuccino,
		  backgroundColor: lilac,
		  side: const BorderSide(
			color: metal,
			width: 0.0,
		  ),
		  shadowColor: capuccino,
		  elevation: 1.0,
		  shape: RoundedRectangleBorder(
			borderRadius: BorderRadius.circular(24),
			side: const BorderSide(color: Colors.black, width: 1.0),
		  ),
		),
	  ),
	),
	Typography.material2021().geometryThemeFor(ScriptCategory.englishLike),
  );
}
