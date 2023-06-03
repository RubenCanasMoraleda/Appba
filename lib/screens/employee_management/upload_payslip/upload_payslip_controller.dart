import 'package:appba/commons/API/api_employee.dart';
import 'package:appba/commons/Models/department.dart';

import '../../../commons/Models/employee.dart';

class UploadPayslipcontroller {
  final Employee _employee;

  UploadPayslipcontroller(this._employee);

  Future<List<Employee>> getEmployeesFromDepartment() {
    // TODO fix request

    return ApiEmployee.getFakeEmployees();
  }
}
