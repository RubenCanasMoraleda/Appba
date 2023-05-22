import 'package:appba/assets/apba_theme/typography/apba_typography.dart';
import 'package:flutter/material.dart';

import 'button_style/apba_buttons_style.dart';
import 'colors/apba_colors.dart';

class ApbaTheme {
  ApbaTheme._();
  static ThemeData lightTheme = ThemeData(
    //fontFamily: "Roboto",
    //primarySwatch: Colors.blue,
    //primaryColor: ApbaColors.primaryBlue,
    textTheme: ApbaTypography.textTheme,
    colorScheme: ApbaColors.scheme,
    disabledColor: ApbaColors.backgroundDisable,
    hoverColor: ApbaColors.backgroundHover,
    elevatedButtonTheme: ApbaButtonStyle.themeData,
    //useMaterial3: true,
  );
}
