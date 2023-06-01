// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:appba/commons/API/api_clock_in.dart';
import 'package:appba/commons/Models/clock_in.dart';
import 'package:appba/commons/Models/employee.dart';

class ClockInListController {
  final Employee _employee;

  int? horasTotales, horasRealizadas;

  ClockInListController(this._employee);

  Future<List<ClockIn>> getClocksIn() async {
    return await ApiClockIn.getClocksInFromEmployee(_employee);
  }

  Future<int> getHoursMonth() async {
    return await ApiClockIn.getHoursMonth(_employee);
  }
}
