import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class RoastAppTheme {
  //static const lilac = Color(0xFF9787B5);
  static const lilac = Color(0xFFA08DB5);
  static const lilacDark = Color(0xFF6E4A94);
  static const indigo = Color(0xFFACBEE3);
  static const indigoDark = Color(0xFF517A8F);
  static const cremaDark = Color(0xFFB8A89C);
  static const crema = Color(0xFFDED8D3);
  static const cremaLight = Color(0xFFFAF5F0);
  static const cremaLightest = Color(0xFFFFFBF8);
  static const capuccino = Color(0xFF3B312A);
  static const capuccinoLight = Color(0xFF4B413A);
  static const capuccinoLightest = Color(0xFF695344);
  static const metal = Color(0xFF606466);
  static const metalDark = Color(0xFF494F52);
  static const metalLight = Color(0xFFA9A7AB);
  static const lime = Color(0xFFC8E6D6);
  static const limeDark = Color(0xFF9BCCB0);
  static const errorColor = Color(0xFFB85544);
  static const alertColor = Color(0xFFC9BF3c);

  static final roastNotesStyle = materialTheme.textTheme.bodyMedium!.copyWith(
    fontStyle: FontStyle.italic,
  );

  static final checkTempTextStyle = materialTheme.textTheme.bodySmall!.copyWith(
    fontWeight: FontWeight.bold,
  );

  static final welcomeTextStyle =
      materialTheme.textTheme.displayMedium!.copyWith(
    color: RoastAppTheme.capuccinoLight,
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

  static final phaseButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
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

  static final formCardTheme = CardTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: const BorderSide(
        color: RoastAppTheme.metalLight,
      ),
    ),
    color: cremaLightest,
    elevation: 0,
  );

  static final materialTheme = ThemeData.localize(
    ThemeData(
      brightness: Brightness.light,
      fontFamily: 'Noto Sans',
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
      cardTheme: const CardTheme(
        //color: cremaLightest,
        color: cremaLightest,
        elevation: 6.0,
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: crema,
        scrimColor: capuccino,
      ),
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
      dividerColor: RoastAppTheme.metalLight,
      iconTheme: const IconThemeData(
        color: capuccinoLightest,
      ),
      inputDecorationTheme: InputDecorationTheme(
        iconColor: MaterialStateColor.resolveWith((states) {
          if (states.contains(MaterialState.error)) {
            return errorColor;
          } else if (states.contains(MaterialState.focused)) {
            return limeDark;
          }

          return capuccinoLightest;
        }),
      ),
      textTheme: GoogleFonts.notoSansTextTheme().copyWith(
        displayLarge: GoogleFonts.vollkorn(
            textStyle: ThemeData.light().textTheme.displayLarge),
        displayMedium: GoogleFonts.vollkorn(
            textStyle: ThemeData.light().textTheme.displayMedium),
        displaySmall: GoogleFonts.vollkorn(
            textStyle: ThemeData.light().textTheme.displaySmall),
        headlineLarge: GoogleFonts.vollkorn(
            textStyle: ThemeData.light().textTheme.headlineLarge),
        headlineMedium: GoogleFonts.vollkorn(
            textStyle: ThemeData.light().textTheme.headlineMedium),
        headlineSmall: GoogleFonts.vollkorn(
            textStyle: ThemeData.light().textTheme.headlineSmall),
        titleLarge: GoogleFonts.vollkorn(
            textStyle: ThemeData.light().textTheme.titleLarge),
      ),
    ),
    Typography.material2021().geometryThemeFor(ScriptCategory.englishLike),
  );
}
