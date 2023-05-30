import 'package:flutter/material.dart';

import '../../../commons/custom_widgets/confirmation_dialog.dart';

class UploadPayslip extends StatefulWidget {
  const UploadPayslip({super.key});

  @override
  State<UploadPayslip> createState() => _UploadPayslipState();
}

class _UploadPayslipState extends State<UploadPayslip> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 5,
        itemBuilder: (context, i) {
          return ExpansionTile(
            title: Text(i.toString()),
            children: [
              Row(
                children: [
                  // TODO boton subir archivo
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          showAlertDialog(context, onConfirm: () {});
                        },
                        child: Text("Emitir Nómina")),
                  ),
                ],
              )
            ],
          );
        });
  }
}
