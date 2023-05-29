import 'package:appba/commons/API/api_payslip.dart';
import 'package:appba/commons/Models/employee.dart';
import 'package:appba/commons/Models/payslip_model.dart';

class PayslipListController {
  final Employee _employee;

  int? horasTotales, horasRealizadas;

  PayslipListController(
    this._employee,
  );

  Future<List<Payslip>> getPayslips() {
    return ApiPayslip.getPayslipsFromEmployee(_employee);
  }
}
