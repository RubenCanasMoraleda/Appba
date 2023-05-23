// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:appba/commons/API/api.dart';
import 'package:appba/commons/Models/clock_in.dart';
import 'package:appba/commons/Models/employee.dart';

class ClockInListController {
  final Employee _employee;

  int? horasTotales, horasRealizadas;

  ClockInListController(
    this._employee,
  );

  Future<List<ClockIn>> getClocksIn() {
    return Api.getClocksInFromEmployee(_employee);
  }
}
