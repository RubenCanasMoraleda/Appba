import 'package:appba/assets/apba_theme/button_style/apba_buttons_style.dart';
import 'package:appba/assets/apba_theme/colors/apba_colors.dart';
import 'package:appba/assets/apba_theme/typography/apba_typography.dart';
import 'package:appba/commons/Models/employee.dart';
import 'package:appba/commons/Models/request.dart';
import 'package:appba/commons/custom_widgets/confirmation_dialog.dart';
import 'package:appba/screens/requests/create_request/create_request_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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

  static List<TipoSolicitud> dropdownList = <TipoSolicitud>[
    TipoSolicitud.vacaciones,
    TipoSolicitud.asuntosPropios,
    TipoSolicitud.horasCompensatorias,
  ];
  TipoSolicitud dropdownValue = dropdownList.first;
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Flexible(
                        flex: 1,
                        child: SvgPicture.asset("lib/assets/svg/logo.svg")),
                  ),
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Column(
                        children: [
                          const Text(
                            "Tipo de Solicitud",
                            style: ApbaTypography.body1,
                          ),
                          DropdownButtonHideUnderline(
                            child: DropdownButton<TipoSolicitud>(
                              icon: const Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Icon(
                                  FontAwesomeIcons.chevronDown,
                                  color: ApbaColors.backgroundBlue,
                                ),
                              ),
                              style: ApbaTypography.body1,
                              alignment: Alignment.center,
                              value: dropdownValue,
                              elevation: 16,
                              onChanged: (TipoSolicitud? value) {
                                setState(() {
                                  dropdownValue = value!;
                                });
                              },
                              items: dropdownList
                                  .map<DropdownMenuItem<TipoSolicitud>>(
                                      (TipoSolicitud value) {
                                return DropdownMenuItem<TipoSolicitud>(
                                  value: value,
                                  child: Center(child: Text(value.value)),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
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
                                    TipoSolicitud.horasCompensatorias
                                ? [
                                    TextFormField(
                                      controller: initDateController,
                                      readOnly: true,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Los campos no pueden estar vacios';
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          icon: Icon(FontAwesomeIcons.calendar),
                                          labelText: "Fecha Inicio"),
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
                                                  DateFormat("yyyy-MM-dd")
                                                      .format(value.start);
                                              endDateController.text =
                                                  DateFormat("yyyy-MM-dd")
                                                      .format(value.end);
                                            });
                                          }
                                        });
                                      },
                                    ),
                                    TextFormField(
                                      controller: endDateController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Los campos no pueden estar vacios';
                                        }
                                        return null;
                                      },
                                      readOnly: true,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          icon: Icon(FontAwesomeIcons.calendar),
                                          labelText: "Fecha Fin"),
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
                                                  DateFormat("yyyy-MM-dd")
                                                      .format(value.start);
                                              endDateController.text =
                                                  DateFormat("yyyy-MM-dd")
                                                      .format(value.end);
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
                                                style: ApbaButtonStyle
                                                    .secondaryButton,
                                                onPressed: () {
                                                  Navigator.pop(context);
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
                                                        title:
                                                            "Confirmar Solicitud",
                                                        message:
                                                            "¿Esta seguro de que desea realizar una solicitud de ${dropdownValue.value.toLowerCase()} desde ${initDateController.text} hasta ${endDateController.text}?",
                                                        onConfirm: () {
                                                      _controller.postRequest(
                                                          dropdownValue,
                                                          initDateController
                                                              .text,
                                                          endDateController
                                                              .text);
                                                      Navigator.pop(context);
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
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Los campos no pueden estar vacios';
                                        }
                                        return null;
                                      },
                                      readOnly: true,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          icon: Icon(
                                              FontAwesomeIcons.calendarDay),
                                          labelText: "Fecha Inicio"),
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
                                                  DateFormat("yyyy-MM-dd")
                                                      .format(value);
                                            });
                                          }
                                        });
                                      },
                                    ),
                                    TextFormField(
                                      controller: initTimeController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Los campos no pueden estar vacios';
                                        }
                                        return null;
                                      },
                                      readOnly: true,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          icon: Icon(FontAwesomeIcons.clock),
                                          labelText: "Hora Inicio"),
                                      onTap: () async {
                                        showTimePicker(
                                                context: context,
                                                initialTime: const TimeOfDay(
                                                    hour: 0, minute: 0))
                                            .then((value) {
                                          if (value != null) {
                                            setState(() {
                                              initTimeController.text =
                                                  MaterialLocalizations.of(
                                                          context)
                                                      .formatTimeOfDay(value,
                                                          alwaysUse24HourFormat:
                                                              true);
                                            });
                                          }
                                        });
                                      },
                                    ),
                                    TextFormField(
                                      controller: endTimeController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Los campos no pueden estar vacios';
                                        }
                                        return null;
                                      },
                                      readOnly: true,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          icon: Icon(FontAwesomeIcons.clock),
                                          labelText: "Hora Fin"),
                                      onTap: () async {
                                        showTimePicker(
                                                context: context,
                                                initialTime: const TimeOfDay(
                                                    hour: 0, minute: 0))
                                            .then((value) {
                                          if (value != null) {
                                            setState(() {
                                              endTimeController.text =
                                                  MaterialLocalizations.of(
                                                          context)
                                                      .formatTimeOfDay(value,
                                                          alwaysUse24HourFormat:
                                                              true);
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
                                                style: ApbaButtonStyle
                                                    .secondaryButton,
                                                onPressed: () {
                                                  Navigator.pop(context);
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
                                                        title:
                                                            "Confirmar Solicitud",
                                                        message:
                                                            "¿Esta seguro de que desea realizar una solicitud de ${dropdownValue.value.toLowerCase()} el ${initDateController.text} desde ${initTimeController.text} hasta ${endTimeController.text}?",
                                                        onConfirm: () {
                                                      _controller
                                                          .postRequestWithHours(
                                                              dropdownValue,
                                                              initDateController
                                                                  .text,
                                                              initTimeController
                                                                  .text,
                                                              endTimeController
                                                                  .text);
                                                      Navigator.pop(context);
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
