import 'package:appba/commons/Models/employee.dart';
import 'package:appba/commons/Models/request.dart';
import 'package:appba/commons/custom_widgets/confirmation_dialog.dart';
import 'package:appba/screens/employee_management/accept_deny_request/accept_deny_request_controller.dart';
import 'package:flutter/material.dart';

import '../../../assets/apba_theme/colors/apba_colors.dart';
import '../../../commons/custom_widgets/loading_list.dart';

class AcceptDenyRequest extends StatefulWidget {
  final Employee employee;
  const AcceptDenyRequest(this.employee, {super.key});

  @override
  State<AcceptDenyRequest> createState() => _AcceptDenyRequestState();
}

class _AcceptDenyRequestState extends State<AcceptDenyRequest> {
  late AcceptDenyRequestController _controller;

  @override
  void initState() {
    _controller = AcceptDenyRequestController(widget.employee);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _controller.getRequestsFromDepartment(),
        builder: (BuildContext context, AsyncSnapshot<List<Request>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount:
                    snapshot.data!.length > 60 ? 60 : snapshot.data?.length,
                itemBuilder: (context, index) {
                  Color background = index % 2 == 0
                      ? ApbaColors.background1
                      : ApbaColors.background2;
                  return Container(
                    decoration: BoxDecoration(
                        color: background,
                        border: const Border(
                            bottom: BorderSide(color: ApbaColors.border1))),
                    child: ExpansionTile(
                      title: Text(index.toString()),
                      children: [
                        Row(
                          children: [
                            Expanded(child: Text("Info")),
                            Expanded(
                              child: Column(
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        showAlertDialog(context,
                                            onConfirm: () {});
                                      },
                                      child: Text("Aceptar")),
                                  ElevatedButton(
                                      onPressed: () {
                                        showAlertDialog(context,
                                            onConfirm: () {});
                                      },
                                      child: Text("Rechazar")),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                });
          } else {
            return LoadingList.of(
                60,
                ListTile(
                  title: Container(
                    height: 15,
                    width: 20,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ));
          }
        });
  }
}
