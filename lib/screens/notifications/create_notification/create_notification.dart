import 'package:appba/assets/apba_theme/button_style/apba_buttons_style.dart';
import 'package:appba/commons/API/api_notification.dart';
import 'package:appba/commons/Models/employee.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreateNotification extends StatefulWidget {
  final Employee employee;

  const CreateNotification(this.employee, {super.key});

  @override
  State<CreateNotification> createState() => _CreateNotificationState();
}

class _CreateNotificationState extends State<CreateNotification> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  bool? isRememberAccount = false;
  bool run = true;

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Crear notificacion")),
      ),
      body: SafeArea(
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 300,
                  child: Expanded(
                    child: TextFormField(
                      controller: titleController,
                      decoration: InputDecoration(
                        label: const Text("Titulo"),
                        // labelText: 'Título'
                      ),
                      validator: (value) {
                        // if (value == null || value.isEmpty) {
                        //   return 'Introduce un DNI';
                        // }
                        return null;
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: descriptionController,
                      maxLines: 10,
                      decoration: const InputDecoration(
                        labelText: 'Descripcion',
                      ),
                      validator: (value) {
                        // if (value == null || value.isEmpty) {
                        //   return 'Introduce una contraseña';
                        // }
                        return null;
                      },
                    ),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.all(20),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ApiNotification.createNotification(
                                  titleController.text,
                                  descriptionController.text)
                              .then((value) => {
                                    if (value != null)
                                      {
                                        Fluttertoast.showToast(
                                            msg:
                                                "Se ha creado la notificacion con exito",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            fontSize: 16.0),
                                        Navigator.pop(context)
                                      }
                                  });
                        }
                      },
                      style: ApbaButtonStyle.primaryBlueButton,
                      child: const Text('Entrar'),
                    )),
              ],
            )),
      ),
    );
  }
}
