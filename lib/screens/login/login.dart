import 'package:appba/assets/apba_theme/colors/apba_colors.dart';
import 'package:appba/screens/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'dart:core';

import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final LoginController _controller = LoginController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isRememberAccount = false;

  @override
  void initState() {
    _prefs.then((value) {
      userController.text = value.getString("DNI") ?? "";
      passwordController.text = value.getString("Password") ?? "";
      setState(() {
        isRememberAccount = value.getBool("RememberAccount") ?? false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
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
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: TextFormField(
                            maxLength: 9,
                            controller: userController,
                            decoration: const InputDecoration(
                                labelText: 'DNI', border: OutlineInputBorder()),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Introduce un DNI';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: TextFormField(
                              controller: passwordController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Contraseña',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Introduce una contraseña';
                                }
                                return null;
                              },
                              obscureText: true,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: 20,
                              bottom: 20,
                              left: MediaQuery.of(context).size.width * 0.10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Checkbox(
                                side: const BorderSide(
                                    color: ApbaColors.semanticHighlight1),
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4))),
                                fillColor: MaterialStateProperty.all(
                                    ApbaColors.semanticBackgroundHighlight1),
                                checkColor: ApbaColors.semanticHighlight1,
                                value: isRememberAccount,
                                onChanged: (b) {
                                  setState(() {
                                    isRememberAccount = b!;
                                  });
                                },
                              ),
                              const Text("Recordar Cuenta")
                            ],
                          ),
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            margin: const EdgeInsets.all(20),
                            child: ElevatedButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return const Center(
                                        child: CircularProgressIndicator(
                                          color: ApbaColors.semanticHighlight2,
                                        ),
                                      );
                                    });
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    _controller
                                        .checkLogin(
                                            userController,
                                            passwordController,
                                            isRememberAccount,
                                            _prefs)
                                        .then((value) => {
                                              print(value.dni),
                                              print(isRememberAccount),
                                              print(userController.value),
                                              Navigator.pop(context),
                                              Navigator.pushNamed(
                                                  context, "/mainScreen",
                                                  arguments: value)
                                            });
                                  });
                                }
                              },
                              child: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  child: Text('Entrar')),
                            )),
                      ],
                    ))
              ]),
        ),
      ),
    );
  }
}
