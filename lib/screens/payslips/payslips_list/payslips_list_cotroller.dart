// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:appba/commons/API/api.dart';
import 'package:appba/commons/Models/employee.dart';
import 'package:appba/commons/Models/payslip_model.dart';

class PayslipListController {
  final Employee _employee;

  int? horasTotales, horasRealizadas;

  PayslipListController(
    this._employee,
  );

  Future<List<Payslip>> getPayslips() {
    return Api.getPayslipsFromEmployee(_employee);
  }
}
