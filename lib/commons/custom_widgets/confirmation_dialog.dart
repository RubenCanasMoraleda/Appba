import 'package:appba/assets/apba_theme/button_style/apba_buttons_style.dart';
import 'package:appba/assets/apba_theme/colors/apba_colors.dart';
import 'package:appba/assets/apba_theme/typography/apba_typography.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const AlertDialog();
  }
}

Future showAlertDialog(BuildContext context,
    {required Function onConfirm,
    String title = "Confirmación",
    String cancelText = "Cancelar",
    String acceptText = "Confirmar",
    String message = "¿Estas Seguro?"}) async {
  AlertDialog alert = AlertDialog(
    icon: const Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          FontAwesomeIcons.circleInfo,
          color: ApbaColors.semanticHighlight1,
        ),
      ],
    ),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: ApbaTypography.headingTitle1,
        ),
      ],
    ),
    content: Text(
      message,
      style: ApbaTypography.body2,
    ),
    actions: [
      Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16),
              child: ElevatedButton(
                style: ApbaButtonStyle.secondaryButton,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(cancelText),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16),
              child: ElevatedButton(
                  onPressed: () {
                    onConfirm();
                    Navigator.of(context).pop();
                  },
                  child: Text(acceptText)),
            ),
          ),
        ],
      )
    ],
  );
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
