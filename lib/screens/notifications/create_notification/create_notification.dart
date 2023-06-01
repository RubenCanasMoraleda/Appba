import 'package:appba/assets/apba_theme/button_style/apba_buttons_style.dart';
import 'package:flutter/material.dart';

class CreateNotification extends StatefulWidget {
  const CreateNotification({super.key});

  @override
  State<CreateNotification> createState() => _CreateNotificationState();
}

class _CreateNotificationState extends State<CreateNotification> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
                      controller: userController,
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
                      controller: passwordController,
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
                        if (_formKey.currentState!.validate()) {}
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
