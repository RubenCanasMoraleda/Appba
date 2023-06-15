import 'package:appba/assets/apba_theme/button_style/apba_buttons_style.dart';
import 'package:appba/commons/API/api_notification.dart';
import 'package:appba/commons/Models/employee.dart';
import 'package:appba/commons/custom_widgets/confirmation_dialog.dart';
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
        centerTitle: true,
        title: const Text("Crear notificacion"),
      ),
      body: SafeArea(
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  height: 25,
                ),
                Expanded(
                  child: Image.asset(
                    "lib/assets/png/Algeciras_Port.png",
                    width: 300,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Título"),
                      // labelText: 'Título'
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Introduce un título';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Expanded(
                  child: SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: descriptionController,
                      maxLines: 10,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Descripción',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Introduce una descripción';
                        }
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
                          showAlertDialog(context,
                              title: "Confirmar Notificación",
                              message:
                                  "¿Esta seguro de que desea publicar la notificacion \"${titleController.text}\"?",
                              onConfirm: () {
                            ApiNotification.createNotification(
                                    titleController.text,
                                    descriptionController.text)
                                .then((value) => {
                                      if (value != null)
                                        {Navigator.pop(context)}
                                    });
                          });
                        }
                      },
                      style: ApbaButtonStyle.primaryBlueButton,
                      child: const Text('Publicar'),
                    )),
              ],
            )),
      ),
    );
  }
}
