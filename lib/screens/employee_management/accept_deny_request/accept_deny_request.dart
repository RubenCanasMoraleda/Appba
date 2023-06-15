import 'package:appba/assets/apba_theme/button_style/apba_buttons_style.dart';
import 'package:appba/commons/Models/employee.dart';
import 'package:appba/commons/Models/request.dart';
import 'package:appba/commons/custom_widgets/confirmation_dialog.dart';
import 'package:appba/screens/employee_management/accept_deny_request/accept_deny_request_controller.dart';
import 'package:appba/screens/employee_management/accept_deny_request/search_employee_delegate.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "Solicitudes pendientes",
                style: ApbaTypography.headingTitle1,
              ),
              IconButton(
                icon: const Icon(FontAwesomeIcons.magnifyingGlass),
                onPressed: () async {
                  showSearch(
                      context: context,
                      delegate:
                          SearchEmployeeDelegate(await _requests, _controller));
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: FutureBuilder(
              future: _requests,
              builder: (BuildContext context,
                  AsyncSnapshot<List<Request>> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.isNotEmpty) {
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
                                      bottom: BorderSide(
                                          color: ApbaColors.border1))),
                              child: RequestTile(
                                  controller: _controller,
                                  request: snapshot.data![index]),
                            );
                          }),
                    );
                  } else {
                    return Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("No quedan solicitudes por gestionar"),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 48,
                          child: ElevatedButton(
                              style: ApbaButtonStyle.secondaryButton,
                              onPressed: loadRequests,
                              child: const Icon(FontAwesomeIcons.arrowsRotate)),
                        )
                      ],
                    ));
                  }
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

class RequestTile extends StatelessWidget {
  const RequestTile({
    super.key,
    required AcceptDenyRequestController controller,
    required Request request,
  })  : _controller = controller,
        _request = request;

  final AcceptDenyRequestController _controller;
  final Request _request;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(_request.tipo!.value),
      subtitle: Text(_request.empleado!.nombre!),
      children: [
        Row(
          children: [
            Expanded(
                child: Column(
              children: [
                Text("Desde: ${_request.fechaHoraInicio!}"),
                Text("Hasta: ${_request.fechaHoraFin!}"),
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
                              title: "Confirmar Solicitud",
                              message:
                                  "¿Esta seguro de que desea aceptar una solicitud de ${_request.empleado!.nombre} de ${_request.tipo!.value.toLowerCase()}?",
                              onConfirm: () {
                            _controller.acceptRequest(_request);
                          });
                        },
                        child: const Text("Aceptar")),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: ElevatedButton(
                        style: ApbaButtonStyle.secondaryButton,
                        onPressed: () {
                          showAlertDialog(context,
                              title: "Rechazar Solicitud",
                              message:
                                  "¿Esta seguro de que desea rechazar una solicitud de ${_request.empleado!.nombre} de ${_request.tipo!.value.toLowerCase()}?",
                              onConfirm: () {
                            _controller.denyRequest(_request);
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
    );
  }
}
