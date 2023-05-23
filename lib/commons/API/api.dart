import 'package:appba/commons/Models/clock_in.dart';
import 'package:appba/commons/Models/employee.dart';

class Api {
  Api._();

  static Future<List<ClockIn>> getClocksInFromEmployee(
      Employee employee) async {
    //TODO http request

    Future<List<ClockIn>> clockIns = getFakeClocksInFromEmployee(employee);

    return clockIns;
  }

  static Future<List<ClockIn>> getFakeClocksInFromEmployee(Employee employee) {
    return Future.delayed(const Duration(seconds: 3), () {
      return List.generate(
          15,
          (index) => ClockIn(
              id: index,
              fechaHora: "2023-05-16 $index:33:04",
              tipo: index % 2 == 0 ? Tipo.entrada : Tipo.salida,
              empleado: employee));
    });
  }

  //Fake data methods
}
