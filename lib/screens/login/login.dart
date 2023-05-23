import 'package:appba/screens/main_screen/main_screen.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  Login({super.key});

  // Juanma si ves algo raro ntr, es copypaste de otro mio
  final _formKey = GlobalKey<FormState>();
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  //final FirebaseAuth auth = FirebaseAuth.instance;

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
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: const Placeholder(),
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
                            margin: const EdgeInsets.only(top: 20),
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  checkLogin().then((value) => value
                                      ? Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const MainScreen()))
                                      : "");
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal,
                              ),
                              child: const Text('Entrar'),
                            )),
                      ],
                    ))
              ]),
        ),
      ),
    );
  }

  Future<bool> checkLogin() async {
    return true;
    // try {
    //   FirebaseAuth auth = FirebaseAuth.instance;
    //   await auth.signInWithEmailAndPassword(
    //       email: userController.text, password: passwordController.text);
    //   return true;
    // } on FirebaseAuthException {
    //   return false;
    // }
  }
}
