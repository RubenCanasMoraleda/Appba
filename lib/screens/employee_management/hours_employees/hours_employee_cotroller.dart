import 'package:appba/commons/API/api_clock_in.dart';
import 'package:appba/commons/Models/employee.dart';

class HoursEmployeeController {
  final Employee _employee;
  HoursEmployeeController(this._employee);
  Future<List<Employee>> getHoursMonthDepartment() {
    return ApiClockIn.getHoursMonthDepartment(_employee.departamento!);
  }
}
