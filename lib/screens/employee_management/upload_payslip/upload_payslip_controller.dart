import 'dart:io';

import 'package:appba/commons/API/api_employee.dart';
import 'package:appba/commons/Models/department.dart';
import 'package:file_picker/file_picker.dart';

import '../../../commons/Models/employee.dart';

class UploadPayslipcontroller {
  final Employee _employee;

  UploadPayslipcontroller(this._employee);

  Future<List<Employee>> getEmployeesFromDepartment() {
    // TODO fix request

    return ApiEmployee.getFakeEmployees();
  }

  Future getFile(Employee employee) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      print(employee.dni);
      print(file);
    } else {
      // User canceled the picker
    }
  }
}
