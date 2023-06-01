import 'package:appba/assets/apba_theme/colors/apba_colors.dart';
import 'package:appba/assets/apba_theme/typography/apba_typography.dart';
import 'package:appba/commons/Models/employee.dart';
import 'package:appba/commons/Models/request.dart';
import 'package:appba/commons/custom_widgets/confirmation_dialog.dart';
import 'package:appba/screens/requests/create_request/create_request_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class CreateRequest extends StatefulWidget {
  final Employee employee;

  const CreateRequest(this.employee, {super.key});

  @override
  State<CreateRequest> createState() => _CreateRequestState();
}

class _CreateRequestState extends State<CreateRequest> {
  late CreateRequestController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CreateRequestController(widget.employee);
  }

  static List<String> dropdownList = <String>[
    TipoSolicitud.vacaciones.value,
    TipoSolicitud.asuntosPropios.value,
    TipoSolicitud.horasCompensatorias.value,
  ];
  String dropdownValue = dropdownList.first;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController initDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController initTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Crear Solicitud',
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                    flex: 1,
                    child: DropdownButton<String>(
                      icon: const Icon(FontAwesomeIcons.chevronDown),
                      style: ApbaTypography.body1,
                      alignment: Alignment.center,
                      value: dropdownValue,
                      elevation: 16,
                      onChanged: (String? value) {
                        setState(() {
                          dropdownValue = value!;
                        });
                      },
                      items: dropdownList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Center(child: Text(value)),
                        );
                      }).toList(),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Form(
                        key: _formKey,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: dropdownValue !=
                                    TipoSolicitud.horasCompensatorias.value
                                ? [
                                    TextFormField(
                                      controller: initDateController,
                                      readOnly: true,
                                      decoration: const InputDecoration(
                                          icon: Icon(Icons.calendar_today),
                                          labelText: "Init Date"),
                                      onTap: () async {
                                        showDateRangePicker(
                                                context: context,
                                                firstDate: DateTime.now().add(
                                                    const Duration(days: 2)),
                                                lastDate: DateTime.now().add(
                                                    const Duration(days: 300)))
                                            .then((value) {
                                          if (value != null) {
                                            setState(() {
                                              initDateController.text =
                                                  DateFormat("dd/MM/yyyy")
                                                      .format(value.start);
                                              endDateController.text =
                                                  DateFormat("dd/MM/yyyy")
                                                      .format(value.end);
                                            });
                                          }
                                        });
                                      },
                                    ),
                                    TextFormField(
                                      controller: endDateController,
                                      readOnly: true,
                                      decoration: const InputDecoration(
                                          icon: Icon(Icons.calendar_today),
                                          labelText: "End Date"),
                                      onTap: () async {
                                        showDateRangePicker(
                                                context: context,
                                                firstDate: DateTime.now().add(
                                                    const Duration(days: 2)),
                                                lastDate: DateTime.now().add(
                                                    const Duration(days: 300)))
                                            .then((value) {
                                          if (value != null) {
                                            setState(() {
                                              initDateController.text =
                                                  value.start.toString();
                                              endDateController.text =
                                                  value.end.toString();
                                            });
                                          }
                                        });
                                      },
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Expanded(
                                          child: Container(
                                              margin: const EdgeInsets.all(10),
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    Navigator.pop(context);
                                                  }
                                                },
                                                child: const Text('Cancelar'),
                                              )),
                                        ),
                                        Expanded(
                                          child: Container(
                                              margin: const EdgeInsets.all(10),
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    showAlertDialog(context,
                                                        onConfirm: () {
                                                      _controller.postRequest(
                                                          Request());
                                                    });
                                                  }
                                                },
                                                child: const Text('Enviar'),
                                              )),
                                        ),
                                      ],
                                    ),
                                  ]
                                : [
                                    TextFormField(
                                      controller: initDateController,
                                      readOnly: true,
                                      decoration: const InputDecoration(
                                          icon: Icon(Icons.calendar_today),
                                          labelText: "Init Date"),
                                      onTap: () async {
                                        showDatePicker(
                                                context: context,
                                                firstDate: DateTime.now().add(
                                                    const Duration(days: 2)),
                                                lastDate: DateTime.now().add(
                                                    const Duration(days: 300)),
                                                initialDate: DateTime.now().add(
                                                    const Duration(days: 2)))
                                            .then((value) {
                                          if (value != null) {
                                            setState(() {
                                              initDateController.text =
                                                  DateFormat("dd/MM/yyyy")
                                                      .format(value);
                                            });
                                          }
                                        });
                                      },
                                    ),
                                    TextFormField(
                                      controller: initTimeController,
                                      readOnly: true,
                                      decoration: const InputDecoration(
                                          icon: Icon(Icons.calendar_today),
                                          labelText: "Start hour"),
                                      onTap: () async {
                                        showTimePicker(
                                                context: context,
                                                initialTime: const TimeOfDay(
                                                    hour: 0, minute: 0))
                                            .then((value) {
                                          setState(() {
                                            initTimeController.text =
                                                value!.format(context);
                                          });
                                        });
                                      },
                                    ),
                                    TextFormField(
                                      controller: endTimeController,
                                      readOnly: true,
                                      decoration: const InputDecoration(
                                          icon: Icon(Icons.calendar_today),
                                          labelText: "End hour"),
                                      onTap: () async {
                                        showTimePicker(
                                                context: context,
                                                initialTime: const TimeOfDay(
                                                    hour: 0, minute: 0))
                                            .then((value) {
                                          setState(() {
                                            endTimeController.text =
                                                value!.format(context);
                                          });
                                        });
                                      },
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Expanded(
                                          child: Container(
                                              margin: const EdgeInsets.all(10),
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    Navigator.pop(context);
                                                  }
                                                },
                                                child: const Text('Cancelar'),
                                              )),
                                        ),
                                        Expanded(
                                          child: Container(
                                              margin: const EdgeInsets.all(10),
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    showAlertDialog(context,
                                                        onConfirm: () {
                                                      _controller.postRequest(
                                                          Request());
                                                    });
                                                  }
                                                },
                                                child: const Text('Enviar'),
                                              )),
                                        ),
                                      ],
                                    ),
                                  ])),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
