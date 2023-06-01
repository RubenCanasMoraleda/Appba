import 'package:appba/assets/apba_theme/button_style/apba_buttons_style.dart';
import 'package:appba/commons/API/api_employee.dart';
import 'package:appba/commons/Models/employee.dart';
import 'package:flutter/material.dart';
import 'dart:core';

import 'package:flutter_svg/svg.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool? isRememberAccount = false;
  bool init = false;
  //final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    setState(() {
      init = true;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 300,
                  height: 300,
                  margin: const EdgeInsets.all(20),
                  child: SvgPicture.asset(
                    "lib/assets/svg/simbolo.svg",
                  ),
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          width: 300,
                          child: TextFormField(
                            controller: userController,
                            decoration: const InputDecoration(labelText: 'DNI'),
                            validator: (value) {
                              // if (value == null || value.isEmpty) {
                              //   return 'Introduce un DNI';
                              // }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: 300,
                          child: TextFormField(
                            controller: passwordController,
                            decoration: const InputDecoration(
                              labelText: 'Password',
                            ),
                            validator: (value) {
                              // if (value == null || value.isEmpty) {
                              //   return 'Introduce una contraseña';
                              // }
                              return null;
                            },
                            obscureText: true,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Checkbox(
                                value: isRememberAccount,
                                onChanged: (b) {
                                  setState(() {
                                    isRememberAccount = b;
                                  });
                                },
                              ),
                              const Text("Recordar Cuenta")
                            ],
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.all(20),
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  checkLogin(userController, passwordController)
                                      .then((value) => {
                                            print(value.dni),
                                            value.runtimeType != null
                                                ? Navigator.pushNamed(
                                                    context, "/mainScreen",
                                                    arguments: value)
                                                : value
                                          });
                                }
                              },
                              style: ApbaButtonStyle.primaryBlueButton,
                              child: const Text('Entrar'),
                            )),
                      ],
                    ))
              ]),
        ),
      ),
    );
  }
}

Future<Employee> checkLogin(TextEditingController userController,
    TextEditingController passwordController) async {
  //TODO descomentar para el login del empleado
  Employee employee;

  employee =
      await ApiEmployee.Login(userController.text, passwordController.text);

  print(employee.dni);

  return employee;

  // try {
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   await auth.signInWithEmailAndPassword(
  //       email: userController.text, password: passwordController.text);
  //   return true;
  // } on FirebaseAuthException {
  //   return false;
  // }
}
