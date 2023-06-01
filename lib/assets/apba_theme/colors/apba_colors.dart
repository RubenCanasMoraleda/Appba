import 'package:flutter/material.dart';

class ApbaColors {
  ApbaColors._();

  static ColorScheme scheme = const ColorScheme(
      brightness: Brightness.light,
      primary: primaryBlue,
      onPrimary: primaryBlue,
      primaryContainer: primaryOrange,
      secondary: semanticHighlight1,
      onSecondary: primaryWhite,
      error: semanticError,
      onError: semanticBackgroundError,
      background: background1,
      onBackground: background2,
      surface: primaryWhite,
      onSurface: neutralGrey);

//Primary
// Los colores primarios (definidos como “primary”) se utilizarán para los elementos de mayor importancia de la interfaz.

// Tanto el azul (“Blue”) como el naranja (“Orange”) se utilizarán en elementos primarios como pueden ser los botones o links,
// o para destacar elementos dentro de la gama de semánticos (“Semantic”). El negro (“Black”) se utilizará en casos secundarios y se utilizará su paleta para los textos.
// El blanco (“White”) se usará principalmente para backgrounds y textos inversos.

//Primary Blue

  static const Color primaryBlue = primaryBlue50;

  static const Color primaryBlue10 = Color(0xffD7EEFF);
  static const Color primaryBlue20 = Color(0xffAEDCFF);
  static const Color primaryBlue30 = Color(0xff86CBFF);
  static const Color primaryBlue40 = Color(0xff5DBAFF);
  static const Color primaryBlue50 = Color(0xff35A8FF);
  static const Color primaryBlue60 = Color(0xff0C97FF);
  static const Color primaryBlue70 = Color(0xff0081E3);
  static const Color primaryBlue80 = Color(0xff006ABA);
  static const Color primaryBlue90 = Color(0xff005392);
  static const Color primaryBlue100 = Color(0xff003C69);

  static const Color primaryBlue100withOpacity20 = Color(0x33003C69);

//Primary Orange

  static const Color primaryOrange = primaryOrange50;

  static const Color primaryOrange10 = Color(0xffFFE6D4);
  static const Color primaryOrange20 = Color(0xffFECDA9);
  static const Color primaryOrange30 = Color(0xffFEB37D);
  static const Color primaryOrange40 = Color(0xffFE9A52);
  static const Color primaryOrange50 = Color(0xffFD8127);
  static const Color primaryOrange60 = Color(0xffF66902);
  static const Color primaryOrange70 = Color(0xffCB5602);
  static const Color primaryOrange80 = Color(0xffA04401);
  static const Color primaryOrange90 = Color(0xff753201);
  static const Color primaryOrange100 = Color(0xff491F01);

  //Primary Black

  static const Color primaryBlack = Color(0xff000000);

  //Primary White
  static const Color primaryWhite = Color(0xffffffff);

  //Neutral
  // Los colores neutrales (“Neutral”) se utilizarán para complementar a los colores primarios, principalmente para backgrounds, estados, textos, etc.
  static const Color neutralGrey = Color(0xff9A9A9A);

  static const Color neutralGrey10 = Color(0xffF8F8F8);
  static const Color neutralGrey20 = Color(0xffDFDFDF);
  static const Color neutralGrey30 = Color(0xffC6C6C6);
  static const Color neutralGrey40 = Color(0xffAEAEAE);
  static const Color neutralGrey50 = Color(0xff959595);
  static const Color neutralGrey60 = Color(0xff7C7C7C);
  static const Color neutralGrey70 = Color(0xff636363);
  static const Color neutralGrey80 = Color(0xff4A4A4A);
  static const Color neutralGrey90 = Color(0xff323232);
  static const Color neutralGrey100 = Color(0xff191919);

  //Semantic
// Los colores semánticos (“Semantic”) se utilizarán para describir de forma visual distintos estados y significados.
// Así, “Notification” se usará para un estado informativo; “Success” para un estado de éxito; “Warning” para une stado de alerta; y “Error” para un estado de error.

//Semantic Notification

  static const Color semanticNotification = semanticNotification50;

  static const Color semanticNotification10 = Color(0xffD5DCFF);
  static const Color semanticNotification20 = Color(0xffABB8FF);
  static const Color semanticNotification30 = Color(0xff8195FF);
  static const Color semanticNotification40 = Color(0xff5771FF);
  static const Color semanticNotification50 = Color(0xff2D4EFF);
  static const Color semanticNotification60 = Color(0xff5771FF);
  static const Color semanticNotification70 = Color(0xff0022D7);
  static const Color semanticNotification80 = Color(0xff001BAD);
  static const Color semanticNotification90 = Color(0xff001583);
  static const Color semanticNotification100 = Color(0xff000E59);

  //Semantic Success

  static const Color semanticSuccess = semanticSuccess70;

  static const Color semanticSuccess10 = Color(0xffEAF5DC);
  static const Color semanticSuccess20 = Color(0xffD4EBB8);
  static const Color semanticSuccess30 = Color(0xffBFE095);
  static const Color semanticSuccess40 = Color(0xffAAD671);
  static const Color semanticSuccess50 = Color(0xff94CC4E);
  static const Color semanticSuccess60 = Color(0xff7EB735);
  static const Color semanticSuccess70 = Color(0xff65942B);
  static const Color semanticSuccess80 = Color(0xff4D7020);
  static const Color semanticSuccess90 = Color(0xff354D16);
  static const Color semanticSuccess100 = Color(0xff1C290C);

  //Semantic Warning

  static const Color semanticWarning = semanticWarning50;

  static const Color semanticWarning10 = Color(0xffFFF5D2);
  static const Color semanticWarning20 = Color(0xffFFEBA5);
  static const Color semanticWarning30 = Color(0xffFFE278);
  static const Color semanticWarning40 = Color(0xffFFD84B);
  static const Color semanticWarning50 = Color(0xffFFCE1E);
  static const Color semanticWarning60 = Color(0xffF0BC00);
  static const Color semanticWarning70 = Color(0xffC39900);
  static const Color semanticWarning80 = Color(0xff967500);
  static const Color semanticWarning90 = Color(0xff695200);
  static const Color semanticWarning100 = Color(0xff3C2F00);

  //Semantic Error

  static const Color semanticError = semanticError60;
  static const Color semanticError10 = Color(0xffF9DEDA);
  static const Color semanticError20 = Color(0xffF2BCB5);
  static const Color semanticError30 = Color(0xffEC9B90);
  static const Color semanticError40 = Color(0xffEC9B90);
  static const Color semanticError50 = Color(0xffDF5846);
  static const Color semanticError60 = Color(0xffD43A25);
  static const Color semanticError70 = Color(0xffAF301F);
  static const Color semanticError80 = Color(0xffAF301F);
  static const Color semanticError90 = Color(0xff651C12);
  static const Color semanticError100 = Color(0xff40110B);

  //Secondary
  //A continuación se muestra la gama completa de los colores base secundarios. Esta paleta servirá a su vez para definir la paleta de color de visualización de datos,
  //la cual se utilizará para gráficos.

  //No la meto porque en principio no tenemos graficos

  //Specific
  // La paleta de colores específicos
  // es la que se aplicará a todo el sistema de diseño de manera consistente.
  //Con ella se construirá el aspecto visual de textos, backgrounds, componentes, bordes, etc.

  //Text
  static const Color text1 = neutralGrey100;
  static const Color text2 = neutralGrey70;
  static const Color textHighlight = primaryOrange70;
  static const Color textInverse = primaryWhite;

  //Text State
  static const Color textStateHover = neutralGrey60;
  static const Color textStateActive = neutralGrey80;
  static const Color textStateDisable = neutralGrey60;

  //Background
  static const Color background1 = primaryWhite;
  static const Color background2 = neutralGrey10;
  static const Color backgroundOrange = primaryOrange60;
  static const Color backgroundBlue = primaryBlue90;
  static const Color backgroundEmphasis = neutralGrey60;
  static const Color backgroundOverlay = primaryBlue100withOpacity20;
  // static const Color backgroundOverlay = primaryBlue100.withOpacity(0.2);
  static Color backgroundOverlayBlack20 = primaryBlack.withOpacity(0.2);
  static Color backgroundOverlayBlack40 = primaryBlack.withOpacity(0.4);

  //State Background
  static const Color backgroundHover = neutralGrey10;
  static const Color backgroundActive = neutralGrey10;
  static const Color backgroundDisable = neutralGrey20;

  //Border
  static const Color border1 = neutralGrey40;

  //Border State
  static const Color border1Hover = neutralGrey60;
  static const Color border1Active = neutralGrey80;
  static const Color border1Disable = neutralGrey60;

  //Semantic
  static const Color semanticHighlight1 = primaryBlue90;
  static const Color semanticHighlight2 = primaryOrange60;

  //Semantic Background
  static const Color semanticBackgroundHighlight1 = primaryBlue10;
  static const Color semanticBackgroundHighlight2 = primaryOrange10;
  static const Color semanticBackgroundNotification = semanticNotification10;
  static const Color semanticBackgroundSuccess = semanticSuccess10;
  static const Color semanticBackgroundWarning = semanticWarning10;
  static const Color semanticBackgroundError = semanticError10;

  //Semantic State
  static const Color semanticHighlight1Hover = primaryBlue100;
  static const Color semanticHighlight1Active = primaryBlue80;
  static const Color semanticErrorActive = semanticError50;
  static const Color semanticErrorHover = semanticError70;

  //Semantic Background State
  static const Color semanticBackgroundHighlight1Hover = primaryBlue20;
  static const Color semanticBackgroundHighlight1Active = primaryBlue80;
  static const Color semanticBackgroundHighlight2Hover = primaryOrange20;
  static const Color semanticBackgroundHighlight2Active = primaryOrange30;

  //Semantic Border
  static const Color semanticBorderHighlight1 = primaryBlue60;
  static const Color semanticBorderHighlight2 = primaryOrange60;
  static const Color semanticBorderError = semanticError50;
  static const Color semanticBorderNotification = semanticNotification30;
  static const Color semanticBorderSuccess = semanticSuccess50;
  static const Color semanticBorderWarning = semanticWarning50;
}
