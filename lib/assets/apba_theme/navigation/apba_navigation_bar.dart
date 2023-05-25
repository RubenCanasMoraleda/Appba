import 'package:appba/assets/apba_theme/colors/apba_colors.dart';
import 'package:appba/assets/apba_theme/typography/apba_typography.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ApbaNavbarStyle {
  ApbaNavbarStyle._();

  static const IconThemeData selectedIconThemeLabel = IconThemeData(
    color: ApbaColors.semanticHighlight1,
  );
  static const IconThemeData unSelectedIconThemeLabel = IconThemeData(
    color: ApbaColors.text2,
  );

  static TextStyle selectedLabelStyle =
      GoogleFonts.roboto(textStyle: const TextStyle(color: ApbaColors.text1));

  static TextStyle unSelectedLabelStyle =
      GoogleFonts.roboto(textStyle: const TextStyle(color: ApbaColors.text2));

  static const Color selectedItemColor =
      ApbaColors.semanticBackgroundHighlight1;

  static const Color backgroundColor = ApbaColors.background1;
}
