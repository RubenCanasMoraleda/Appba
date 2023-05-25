import 'package:appba/assets/apba_theme/colors/apba_colors.dart';
import 'package:appba/assets/apba_theme/typography/apba_typography.dart';
import 'package:flutter/material.dart';

class ApbaApbarStyle {
  ApbaApbarStyle._();

  static AppBarTheme theme = AppBarTheme(
    titleTextStyle: ApbaTypography.headingTitle1.copyWith(
      color: ApbaColors.text1,
    ),
    color: ApbaColors.background1,
    iconTheme: const IconThemeData(color: ApbaColors.semanticHighlight1),
    actionsIconTheme: const IconThemeData(color: ApbaColors.semanticHighlight1),
    toolbarHeight: 64,
  );
}
