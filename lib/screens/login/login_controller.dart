import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../commons/API/api_employee.dart';
import '../../commons/Models/employee.dart';

class LoginController {
  Future<Employee> checkLogin(
      TextEditingController userController,
      TextEditingController passwordController,
      bool isRememberAccount,
      Future<SharedPreferences> prefs) async {
    Employee employee;

    employee =
        await ApiEmployee.login(userController.text, passwordController.text);

    if (isRememberAccount == true) {
      prefs.then((value) {
        value.setString('DNI', userController.text);
        value.setString('Password', passwordController.text);
        value.setBool('RememberAccount', isRememberAccount);
      });
    } else {
      prefs.then((value) {
        value.clear();
      });
    }

    return employee;
  }
}
