import 'package:appba/commons/Models/employee.dart';
import 'package:appba/commons/custom_widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen(this.employee, {super.key});
  final Employee employee;
  @override
  Widget build(BuildContext context) {
    print(employee.nombre);
    return BottomNavigationBarExample(employee);
  }
}
