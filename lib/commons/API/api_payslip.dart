import 'package:appba/commons/Models/employee.dart';
import 'package:appba/commons/Models/payslip_model.dart';

class ApiPayslip {
  static Future<List<Payslip>> getPayslipsFromEmployee(Employee employee) {
    Future<List<Payslip>> payslips = getFakePayslipsFromEmployee(employee);

    return payslips;
  }

  static Future<List<Payslip>> getFakePayslipsFromEmployee(Employee employee) {
    return Future.delayed(const Duration(seconds: 3), () {
      return List.generate(
          15,
          (index) => Payslip(
              id: index,
              fecha: "2023-05-$index",
              path:
                  "/empleado/${employee.id}/${employee.dni}_2023-05-$index.pdf",
              empleado: employee));
    });
  }
}
