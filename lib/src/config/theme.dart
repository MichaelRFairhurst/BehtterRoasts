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
  static const errorColor = Color(0xFFB85544);
  static const alertColor = Color(0xFFC9BF3c);

  static final roastNotesStyle = materialTheme.textTheme.bodyMedium!.copyWith(
	fontStyle: FontStyle.italic,
  );

  static final checkTempTextStyle = materialTheme.textTheme.caption!.copyWith(
    fontWeight: FontWeight.bold,
  );

  static final tinyButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        foregroundColor: capuccino,
        backgroundColor: metalLight,
		shadowColor: capuccino,
        elevation: 1.0,
		fixedSize: const Size(12, 12),
		minimumSize: const Size(12, 12),
		maximumSize: const Size(12, 12),
		padding: const EdgeInsets.all(2.0),
	),
  );

  static final largeButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        foregroundColor: capuccino,
        backgroundColor: lilac,
		shadowColor: capuccino,
        elevation: 5.0,
		minimumSize: const Size(64, 48),
		padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14.0),
		shape: RoundedRectangleBorder(
		  borderRadius: BorderRadius.circular(32),
		),
		textStyle: materialTheme.textTheme.titleMedium,
	),
  );

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

  static final limeButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        foregroundColor: capuccino,
        backgroundColor: lime,
		shadowColor: capuccino,
        elevation: 1.0,
	),
  );

  static final cancelButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        backgroundColor: errorColor,
        foregroundColor: capuccino,
		shadowColor: capuccino,
        elevation: 1.0,
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
		error: errorColor,
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
