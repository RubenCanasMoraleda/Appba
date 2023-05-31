import 'package:appba/commons/API/api.dart';
import 'package:appba/commons/Models/department.dart';
import 'package:appba/commons/Models/employee.dart';
import 'package:appba/commons/Models/request.dart';

class ApiEmployee {
  static Future<List<Employee>> getEmplyeeFromDepartment(
      Department department) async {
    dynamic res =
        await Api.GET_REQUEST("${Api.EMPLOYEE}byCategory/${department.id}");

    List<Employee> employee = [];
    List<dynamic> fetched = res["data"];
    print(res["data"]);

    for (var item in fetched) {
      employee.add(Employee.fromJson(item));
    }

    return employee;
  }

  static Future<Employee> Login(String dni, String password) async {
    dynamic res =
        await Api.POST_REQUEST(Api.AUTH, {"DNI": dni, "password": password});
    print(dni);
    print(res);
    Employee employee;
    employee = Employee.fromJson(res["data"]["empleado"]);

    return employee;
  }
}
