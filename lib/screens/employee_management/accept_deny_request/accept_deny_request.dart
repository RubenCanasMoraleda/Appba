import 'package:appba/assets/apba_theme/button_style/apba_buttons_style.dart';
import 'package:appba/commons/Models/employee.dart';
import 'package:appba/commons/Models/request.dart';
import 'package:appba/commons/custom_widgets/confirmation_dialog.dart';
import 'package:appba/screens/employee_management/accept_deny_request/accept_deny_request_controller.dart';
import 'package:flutter/material.dart';

import '../../../assets/apba_theme/colors/apba_colors.dart';
import '../../../assets/apba_theme/typography/apba_typography.dart';
import '../../../commons/custom_widgets/loading_list.dart';

class AcceptDenyRequest extends StatefulWidget {
  final Employee employee;
  const AcceptDenyRequest(this.employee, {super.key});

  @override
  State<AcceptDenyRequest> createState() => _AcceptDenyRequestState();
}

class _AcceptDenyRequestState extends State<AcceptDenyRequest>
    with AutomaticKeepAliveClientMixin<AcceptDenyRequest> {
  late AcceptDenyRequestController _controller;
  late Future<List<Request>> _requests;

  @override
  void initState() {
    _controller = AcceptDenyRequestController(widget.employee);
    loadRequests();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(16),
          color: ApbaColors.semanticBackgroundHighlight1,
          child: const Center(
            child: Text(
              "Solicitudes pendientes",
              style: ApbaTypography.headingTitle1,
            ),
          ),
        ),
        Expanded(
          child: FutureBuilder(
              future: _requests,
              builder: (BuildContext context,
                  AsyncSnapshot<List<Request>> snapshot) {
                if (snapshot.hasData) {
                  return RefreshIndicator(
                    onRefresh: loadRequests,
                    color: ApbaColors.semanticHighlight2,
                    child: ListView.builder(
                        itemCount: snapshot.data!.length > 60
                            ? 60
                            : snapshot.data?.length,
                        itemBuilder: (context, index) {
                          Color background = index % 2 == 0
                              ? ApbaColors.background1
                              : ApbaColors.background2;
                          return Container(
                            decoration: BoxDecoration(
                                color: background,
                                border: const Border(
                                    bottom:
                                        BorderSide(color: ApbaColors.border1))),
                            child: ExpansionTile(
                              title: Text(snapshot.data![index].tipo!.value),
                              subtitle:
                                  Text(snapshot.data![index].empleado!.nombre!),
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        child: Column(
                                      children: [
                                        Text(
                                            "Fecha Inicio: ${snapshot.data![index].fechaHoraInicio!}"),
                                        Text(
                                            "Fecha Fin: ${snapshot.data![index].fechaHoraFin!}"),
                                      ],
                                    )),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  showAlertDialog(context,
                                                      title:
                                                          "Confirmar Solicitud",
                                                      message:
                                                          "¿Esta seguro de que desea aceptar una solicitud de ${snapshot.data![index].empleado!.nombre} de ${snapshot.data![index].tipo!.value.toLowerCase()}?",
                                                      onConfirm: () {
                                                    _controller.acceptRequest(
                                                        snapshot.data![index]);
                                                  });
                                                },
                                                child: const Text("Aceptar")),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: ElevatedButton(
                                                style: ApbaButtonStyle
                                                    .secondaryButton,
                                                onPressed: () {
                                                  showAlertDialog(context,
                                                      title:
                                                          "Rechazar Solicitud",
                                                      message:
                                                          "¿Esta seguro de que desea rechazar una solicitud de ${snapshot.data![index].empleado!.nombre} de ${snapshot.data![index].tipo!.value.toLowerCase()}?",
                                                      onConfirm: () {
                                                    _controller.denyRequest(
                                                        snapshot.data![index]);
                                                  });
                                                },
                                                child: const Text("Rechazar")),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        }),
                  );
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
              }),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;

  Future<void> loadRequests() async {
    setState(() {
      _requests = _controller.getRequestsFromDepartment();
    });
  }
}
