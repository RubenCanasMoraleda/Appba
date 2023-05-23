import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const AlertDialog();
  }
}

showAlertDialog(BuildContext context,
    {required Function onConfirm,
    String title = "Confirmation",
    String cancelText = "Cancel",
    String acceptText = "Yes",
    String message = "Are you sure?"}) {
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text(cancelText),
      ),
      TextButton(
          onPressed: () {
            onConfirm();
            Navigator.of(context).pop();
          },
          child: Text(acceptText))
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
