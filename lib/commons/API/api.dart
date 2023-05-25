import 'package:appba/commons/Models/clock_in.dart';
import 'package:appba/commons/Models/employee.dart';
import 'package:appba/commons/Models/request.dart';

class Api {
  Api._();

  static Future<List<ClockIn>> getClocksInFromEmployee(
      Employee employee) async {
    //TODO http request

    Future<List<ClockIn>> clockIns = getFakeClocksInFromEmployee(employee);

    return clockIns;
  }

  static Future<List<Request>> getRequestsFromEmployee(Employee employee) {
    Future<List<Request>> requests = getFakeRequestsFromEmployee(employee);

    return requests;
  }

  //Fake data methods

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

  static Future<List<Request>> getFakeRequestsFromEmployee(Employee employee) {
    return Future.delayed(const Duration(seconds: 3), () {
      return List.generate(
          15,
          (index) => Request(
              id: index,
              fechaHora: "2023-05-16 $index:33:04",
              fechaHoraInicio: "2023-06-$index $index:33:04",
              fechaHoraFin: "2023-$index-15 $index:33:04",
              tipo: index % 2 == 0
                  ? TipoSolicitud.vacaciones
                  : TipoSolicitud.asuntosPropios,
              estado: index % 2 == 0 ? Estado.aceptadaJefe : Estado.rechazada,
              empleado: employee));
    });
  }
}
