import 'package:appba/assets/apba_theme/apba_theme.dart';
import 'package:appba/screens/login/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ApbaTheme.lightTheme,
        home: Login());
  }
}

// TODO hacer rutas