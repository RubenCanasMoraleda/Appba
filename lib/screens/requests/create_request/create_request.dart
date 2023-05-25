import 'package:appba/commons/Models/employee.dart';
import 'package:appba/commons/Models/request.dart';
import 'package:appba/commons/custom_widgets/confirmation_dialog.dart';
import 'package:appba/screens/requests/create_request/create_request_controller.dart';
import 'package:flutter/material.dart';

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
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DropdownButton<String>(
                  value: dropdownValue,
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      dropdownValue = value!;
                    });
                  },
                  items: dropdownList
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                Form(
                    key: _formKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: dropdownValue ==
                                TipoSolicitud.horasCompensatorias.value
                            ? [
                                SizedBox(
                                  width: 300,
                                  child: DatePickerDialog(
                                      initialDate: DateTime(2023),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2040)),
                                ),
                                const TimePickerDialog(
                                    initialTime: TimeOfDay(hour: 0, minute: 0)),
                                const TimePickerDialog(
                                    initialTime: TimeOfDay(hour: 0, minute: 0)),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      child: Container(
                                          margin: const EdgeInsets.all(20),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                Navigator.pop(context);
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.teal,
                                            ),
                                            child: const Text('Cancelar'),
                                          )),
                                    ),
                                    Expanded(
                                      child: Container(
                                          margin: const EdgeInsets.all(20),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                showAlertDialog(context,
                                                    onConfirm: () {
                                                  _controller
                                                      .postRequest(Request());
                                                });
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.teal,
                                            ),
                                            child: const Text('Enviar'),
                                          )),
                                    ),
                                  ],
                                ),
                              ]
                            : [
                                DatePickerDialog(
                                    initialDate: DateTime(2023),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2040)),
                                DatePickerDialog(
                                    initialDate: DateTime(2023),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2040)),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      child: Container(
                                          margin: const EdgeInsets.all(20),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                Navigator.pop(context);
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.teal,
                                            ),
                                            child: const Text('Cancelar'),
                                          )),
                                    ),
                                    Expanded(
                                      child: Container(
                                          margin: const EdgeInsets.all(20),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                showAlertDialog(context,
                                                    onConfirm: () {
                                                  _controller
                                                      .postRequest(Request());
                                                });
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.teal,
                                            ),
                                            child: const Text('Enviar'),
                                          )),
                                    ),
                                  ],
                                ),
                              ])),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
