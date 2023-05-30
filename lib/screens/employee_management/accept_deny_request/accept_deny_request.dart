import 'package:appba/commons/custom_widgets/confirmation_dialog.dart';
import 'package:flutter/material.dart';

class AcceptDenyRequest extends StatefulWidget {
  const AcceptDenyRequest({super.key});

  @override
  State<AcceptDenyRequest> createState() => _AcceptDenyRequestState();
}

class _AcceptDenyRequestState extends State<AcceptDenyRequest> {
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
                  Expanded(child: Text("Info")),
                  Expanded(
                    child: Column(
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              showAlertDialog(context, onConfirm: () {});
                            },
                            child: Text("Aceptar")),
                        ElevatedButton(
                            onPressed: () {
                              showAlertDialog(context, onConfirm: () {});
                            },
                            child: Text("Rechazar")),
                      ],
                    ),
                  ),
                ],
              )
            ],
          );
        });
  }
}
