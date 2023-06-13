import 'package:appba/commons/API/api.dart';
import 'package:appba/commons/Models/department.dart';
import 'package:appba/commons/Models/employee.dart';

class ApiEmployee {
  static Future<List<Employee>> getEmployeeFromDepartment(
      Department department) async {
    dynamic res =
        await Api.GET_REQUEST("${Api.EMPLOYEE}byCategory/${department.id}");

    List<Employee> employee = [];
    List<dynamic> fetched = res["data"];

    for (var item in fetched) {
      employee.add(Employee.fromJson(item));
    }

    return employee;
  }

  static Future<List<Employee>> getAllEmployee() async {
    dynamic res = await Api.GET_REQUEST(Api.EMPLOYEE);

    List<Employee> employee = [];
    List<dynamic> fetched = res["empleado"];

    for (var item in fetched) {
      employee.add(Employee.fromJson(item));
    }

    return employee;
  }

  static Future<Employee> login(String dni, String password) async {
    dynamic res =
        await Api.POST_REQUEST(Api.AUTH, {"DNI": dni, "password": password});
    Employee employee;
    employee = Employee.fromJson(res["data"]["empleado"]);

    return employee;
  }
}
