import 'package:flutter/material.dart';

import '../colors/apba_colors.dart';
import '../styles/apba_styles.dart';

class ApbaButtonStyle {
  ApbaButtonStyle._();

  static ElevatedButtonThemeData themeData =
      ElevatedButtonThemeData(style: primaryBlueButton);

  static FloatingActionButtonThemeData floatingActionButtonThemeData =
      const FloatingActionButtonThemeData(
          iconSize: 20,
          hoverColor: ApbaColors.semanticHighlight1Hover,
          focusColor: ApbaColors.semanticBackgroundHighlight1,
          smallSizeConstraints: BoxConstraints(
              minWidth: 40, maxWidth: 40, maxHeight: 40, minHeight: 40),
          sizeConstraints: BoxConstraints(
              minWidth: 48, maxWidth: 48, maxHeight: 48, minHeight: 48),
          backgroundColor: ApbaColors.semanticHighlight1);

  static ButtonStyle primaryBlueButton = ButtonStyle(
    minimumSize: const MaterialStatePropertyAll(Size.fromHeight(48)),
    shape: const MaterialStatePropertyAll(
        RoundedRectangleBorder(borderRadius: ApbaStyles.borderRadiusFull)),
    alignment: Alignment.center,
    backgroundColor:
        MaterialStateProperty.resolveWith(getPrimaryBlueBackgroundColor),
    foregroundColor:
        MaterialStateProperty.resolveWith(getPrimaryBlueForegroundColor),
    iconSize: const MaterialStatePropertyAll(20),
  );

  static ButtonStyle primaryIconBlueButtonSmall =
      primaryBlueButtonSmall.copyWith(
    padding: const MaterialStatePropertyAll(EdgeInsets.all(20)),
    shape: const MaterialStatePropertyAll(CircleBorder(side: BorderSide())),
    iconSize: const MaterialStatePropertyAll(20),
  );
  static ButtonStyle primaryIconBlueButton = primaryBlueButton.copyWith(
    padding: const MaterialStatePropertyAll(EdgeInsets.all(20)),
    shape: const MaterialStatePropertyAll(CircleBorder(side: BorderSide())),
    iconSize: const MaterialStatePropertyAll(20),
  );

  static ButtonStyle secondaryIconBlueButton = secondaryButton.copyWith(
    padding: const MaterialStatePropertyAll(EdgeInsets.all(20)),
    shape: const MaterialStatePropertyAll(CircleBorder(side: BorderSide())),
    iconSize: const MaterialStatePropertyAll(20),
  );

  static ButtonStyle secondaryIconBlueButtonSmall =
      secondaryButtonSmall.copyWith(
    padding: const MaterialStatePropertyAll(EdgeInsets.all(20)),
    shape: const MaterialStatePropertyAll(CircleBorder(side: BorderSide())),
    iconSize: const MaterialStatePropertyAll(20),
  );

  static ButtonStyle primaryBlueButtonSmall = primaryBlueButton.copyWith(
    minimumSize: const MaterialStatePropertyAll(Size.fromHeight(40)),
  );

  static ButtonStyle primaryWhiteButton = primaryBlueButton.copyWith(
    backgroundColor:
        MaterialStateProperty.resolveWith(getPrimaryWhiteBackgroundColor),
    foregroundColor:
        MaterialStateProperty.resolveWith(getPrimaryWhiteForegroundColor),
    shape: MaterialStateProperty.resolveWith(getPrimaryWhiteBorder),
  );

  static ButtonStyle primaryWhiteButtonSmall = primaryWhiteButton.copyWith(
    minimumSize: const MaterialStatePropertyAll(Size.fromHeight(40)),
  );

  static ButtonStyle secondaryButton = primaryBlueButton.copyWith(
    backgroundColor:
        MaterialStateProperty.resolveWith(getSecondaryBackgroundColor),
    foregroundColor:
        MaterialStateProperty.resolveWith(getSecondaryForegroundColor),
  );

  static ButtonStyle secondaryButtonSmall = secondaryButton.copyWith(
    minimumSize: const MaterialStatePropertyAll(Size.fromHeight(40)),
  );

  static ButtonStyle tertiaryButton = primaryBlueButton.copyWith(
      backgroundColor:
          MaterialStateProperty.resolveWith(getTertiaryBackgroundColor),
      foregroundColor:
          MaterialStateProperty.resolveWith(getSecondaryForegroundColor),
      shadowColor: const MaterialStatePropertyAll(Colors.transparent));

  static ButtonStyle tertiaryButtonSmall = tertiaryButton.copyWith(
    minimumSize: const MaterialStatePropertyAll(Size.fromHeight(40)),
  );

  static ButtonStyle dangerButton = primaryBlueButton.copyWith(
    backgroundColor:
        MaterialStateProperty.resolveWith(getDangerBackgroundColor),
    foregroundColor:
        MaterialStateProperty.resolveWith(getDangerForegroundColor),
  );

  static ButtonStyle dangerButtonSmall = dangerButton.copyWith(
    minimumSize: const MaterialStatePropertyAll(Size.fromHeight(40)),
  );

  static ButtonStyle secondaryDangerButton = primaryBlueButton.copyWith(
    backgroundColor:
        MaterialStateProperty.resolveWith(getSecondaryDangerBackgroundColor),
    foregroundColor:
        MaterialStateProperty.resolveWith(getSecondaryDangerForegroundColor),
    shape: MaterialStateProperty.resolveWith(getSecondaryDangerBorder),
  );

  static ButtonStyle secondaryDangerButtonSmall =
      secondaryDangerButton.copyWith(
    minimumSize: const MaterialStatePropertyAll(Size.fromHeight(40)),
  );

  static ButtonStyle tertiaryDangerButton = primaryBlueButton.copyWith(
      backgroundColor:
          MaterialStateProperty.resolveWith(getTertiaryDangerBackgroundColor),
      foregroundColor:
          MaterialStateProperty.resolveWith(getSecondaryDangerForegroundColor),
      shadowColor: const MaterialStatePropertyAll(Colors.transparent));

  static ButtonStyle tertiaryDangerButtonSmall = tertiaryDangerButton.copyWith(
    minimumSize: const MaterialStatePropertyAll(Size.fromHeight(40)),
  );
}

Color getPrimaryBlueForegroundColor(Set<MaterialState> states) {
  if (states.contains(MaterialState.disabled)) {
    return ApbaColors.textStateDisable;
  }
  return ApbaColors.textInverse;
}

Color getPrimaryBlueBackgroundColor(Set<MaterialState> states) {
  if (states.contains(MaterialState.disabled)) {
    return ApbaColors.backgroundDisable;
  }
  if (states.contains(MaterialState.pressed)) {
    return ApbaColors.semanticBackgroundHighlight1Active;
  }
  return ApbaColors.semanticHighlight1;
}

Color getPrimaryWhiteBackgroundColor(Set<MaterialState> states) {
  if (states.contains(MaterialState.disabled)) {
    return ApbaColors.backgroundDisable;
  }
  if (states.contains(MaterialState.pressed)) {
    return ApbaColors.backgroundActive;
  }
  return ApbaColors.background1;
}

Color getPrimaryWhiteForegroundColor(Set<MaterialState> states) {
  if (states.contains(MaterialState.disabled)) {
    return ApbaColors.textStateDisable;
  }
  return ApbaColors.semanticHighlight1;
}

RoundedRectangleBorder getPrimaryWhiteBorder(Set<MaterialState> states) {
  if (states.contains(MaterialState.disabled)) {
    return const RoundedRectangleBorder(
        borderRadius: ApbaStyles.borderRadiusFull,
        side: BorderSide(color: ApbaColors.border1Disable, width: 2));
  }
  return const RoundedRectangleBorder(
      borderRadius: ApbaStyles.borderRadiusFull,
      side: BorderSide(color: ApbaColors.semanticHighlight1, width: 2));
}

Color getSecondaryBackgroundColor(Set<MaterialState> states) {
  if (states.contains(MaterialState.disabled)) {
    return ApbaColors.backgroundDisable;
  }
  if (states.contains(MaterialState.pressed)) {
    return ApbaColors.semanticBackgroundHighlight1Active;
  }
  return ApbaColors.semanticBackgroundHighlight1;
}

Color getSecondaryForegroundColor(Set<MaterialState> states) {
  if (states.contains(MaterialState.disabled)) {
    return ApbaColors.textStateDisable;
  }
  if (states.contains(MaterialState.pressed)) {
    return ApbaColors.semanticHighlight1Active;
  }
  return ApbaColors.semanticHighlight1;
}

Color getTertiaryBackgroundColor(Set<MaterialState> states) {
  if (states.contains(MaterialState.pressed)) {
    return ApbaColors.backgroundActive;
  }
  return Colors.transparent;
}

Color getDangerBackgroundColor(Set<MaterialState> states) {
  if (states.contains(MaterialState.disabled)) {
    return ApbaColors.backgroundDisable;
  }
  if (states.contains(MaterialState.pressed)) {
    return ApbaColors.semanticError50;
  }
  return ApbaColors.semanticError60;
}

Color getDangerForegroundColor(Set<MaterialState> states) {
  if (states.contains(MaterialState.disabled)) {
    return ApbaColors.textStateDisable;
  }
  return ApbaColors.textInverse;
}

RoundedRectangleBorder getSecondaryDangerBorder(Set<MaterialState> states) {
  if (states.contains(MaterialState.disabled)) {
    return const RoundedRectangleBorder(
        borderRadius: ApbaStyles.borderRadiusFull,
        side: BorderSide(color: ApbaColors.border1Disable, width: 2));
  }
  if (states.contains(MaterialState.pressed)) {
    return const RoundedRectangleBorder(
        borderRadius: ApbaStyles.borderRadiusFull,
        side: BorderSide(color: ApbaColors.semanticError50, width: 2));
  }
  return const RoundedRectangleBorder(
      borderRadius: ApbaStyles.borderRadiusFull,
      side: BorderSide(color: ApbaColors.semanticError60, width: 2));
}

Color getSecondaryDangerBackgroundColor(Set<MaterialState> states) {
  if (states.contains(MaterialState.disabled)) {
    return ApbaColors.backgroundDisable;
  }
  if (states.contains(MaterialState.pressed)) {
    return ApbaColors.backgroundActive;
  }
  return ApbaColors.background1;
}

Color getSecondaryDangerForegroundColor(Set<MaterialState> states) {
  if (states.contains(MaterialState.disabled)) {
    return ApbaColors.textStateDisable;
  }
  if (states.contains(MaterialState.pressed)) {
    return ApbaColors.semanticError60;
  }
  return ApbaColors.semanticError50;
}

Color getTertiaryDangerBackgroundColor(Set<MaterialState> states) {
  if (states.contains(MaterialState.pressed)) {
    return ApbaColors.backgroundActive;
  }
  return Colors.transparent;
}
