import 'package:flutter/material.dart';

import '../colors/apba_colors.dart';

class ApbaTypography {
  ApbaTypography._();

  static const textTheme = TextTheme(
    bodySmall: caption,
    bodyLarge: body1,
    bodyMedium: body2,
    labelMedium: buttonMedium,
    labelSmall: buttonSmall,
    headlineLarge: headingHeadline1,
    headlineMedium: headingHeadline2,
    headlineSmall: headingHeadline3,
    displayLarge: headingHeadline1,
    displayMedium: headingHeadline2,
    displaySmall: headingHeadline3,
    titleLarge: headingTitle1,
    titleMedium: subHeadline,
    titleSmall: headingHeadline2,
  );

  static const TextStyle caption = TextStyle(
      fontFamily: "Roboto",
      height: 16 / 12,
      fontWeight: FontWeight.w400,
      fontSize: 12);
  static const TextStyle body1 = TextStyle(
      fontFamily: "Roboto",
      height: 24 / 16,
      fontWeight: FontWeight.w400,
      fontSize: 16);
  static const TextStyle body2 = TextStyle(
      fontFamily: "Roboto",
      height: 24 / 14,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: ApbaColors.text1);
  static const TextStyle bodyHighlight = TextStyle(
      fontFamily: "Roboto",
      height: 30 / 20,
      fontSize: 20,
      fontWeight: FontWeight.w400);
  static const TextStyle buttonSmall = TextStyle(
    fontFamily: "Roboto",
    height: 24 / 16,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle buttonMedium = TextStyle(
    fontFamily: "Roboto",
    height: 24 / 18,
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle headingTitle1 = TextStyle(
    fontFamily: "Roboto",
    height: 24 / 18,
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle headingTitle2 = TextStyle(
    fontFamily: "Roboto",
    height: 24 / 16,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle subHeadline = TextStyle(
    fontFamily: "Roboto",
    height: 32 / 24,
    fontSize: 24,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle headingHeadline1 = TextStyle(
    fontFamily: "Raleway",
    height: 48 / 40,
    fontSize: 40,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle headingHeadline2 = TextStyle(
    fontFamily: "Raleway",
    height: 40 / 32,
    fontSize: 32,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle headingHeadline3 = TextStyle(
    fontFamily: "Raleway",
    height: 32 / 26,
    fontSize: 26,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle headingHeadline3Bold1 = TextStyle(
      fontFamily: "Raleway",
      height: 38 / 30,
      fontSize: 30,
      fontWeight: FontWeight.w600,
      color: ApbaColors.text1);
  static const TextStyle headingHeadline3Bold2 = TextStyle(
      fontFamily: "Raleway",
      height: 32 / 26,
      fontSize: 26,
      fontWeight: FontWeight.w600,
      color: ApbaColors.text1);
}
