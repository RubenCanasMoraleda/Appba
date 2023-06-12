import 'package:appba/commons/API/api_employee.dart';
import 'package:appba/commons/API/api_payslip.dart';
import 'package:file_picker/file_picker.dart';

import '../../../commons/Models/employee.dart';

class UploadPayslipcontroller {
  final Employee _employee;

  UploadPayslipcontroller(this._employee);

  Future<List<Employee>> getEmployees() {
    return ApiEmployee.getAllEmployee();
  }

  Future<String?> getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      return Future.value(result.files.single.path);
    } else {
      return null;
    }
  }

  Future uploadFile(String filePath, Employee employee) {
    return ApiPayslip.uploadPayslip(filePath, employee);
  }
}
