import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts/src/google_fonts_variant.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  GoogleFonts.config.allowRuntimeFetching = false;
  await _loadGoogleFonts();
  await loadAppFonts();
  return testMain();
}

/// This loads the fonts from AssetManifest.json's google_fonts/* entries.
Future<void> _loadGoogleFonts() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  final googleFonts = await rootBundle.loadStructuredData<Map<String, dynamic>>(
    'AssetManifest.json',
    (string) async {
      final assets = json.decode(string);
      // remove non-google font assets
      assets.removeWhere((key, _) => !key.startsWith("fonts/"));
      return assets;
    },
  );

  for (final fontEntry in googleFonts.entries) {
    // from fileName [<fontName>-<variantName>.ttf] -> fontName, variantName
    final fileNameParts =
        fontEntry.key.split('/').last.replaceAll('.ttf', '').split("-");
    final fontName = fileNameParts.removeAt(0);
    final variantName = fileNameParts.join("");
    // create GoogleFontsVariant from variantName
    final fontVariant = GoogleFontsVariant.fromApiFilenamePart(variantName);

    // load font: with fontFamily="<fontName>_<fontVariant>"
    final fontLoader = FontLoader("${fontName}_$fontVariant");
    for (final String font in fontEntry.value) {
      fontLoader.addFont(rootBundle.load(font));
    }
    await fontLoader.load();
  }
}
