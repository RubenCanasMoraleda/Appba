import 'dart:io';

import 'package:appba/commons/API/api_employee.dart';
import 'package:appba/commons/API/api_payslip.dart';
import 'package:appba/commons/Models/department.dart';
import 'package:file_picker/file_picker.dart';

import '../../../commons/Models/employee.dart';

class UploadPayslipcontroller {
  final Employee _employee;

  UploadPayslipcontroller(this._employee);

  Future<List<Employee>> getEmployeesFromDepartment() {
    return ApiEmployee.getAllEmployee();
  }

  Future getFile(Employee employee) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      ApiPayslip.uploadPayslip(result.files.single.path!, employee);
    } else {
      print("nuse");
    }
  }
}
