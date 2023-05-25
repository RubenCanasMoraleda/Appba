import 'package:appba/commons/Models/clock_in.dart';
import 'package:appba/commons/Models/employee.dart';
import 'package:appba/commons/Models/payslip_model.dart';
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

  static Future<List<Payslip>> getPayslipsFromEmployee(Employee employee) {
    Future<List<Payslip>> payslips = getFakePayslipsFromEmployee(employee);

    return payslips;
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

  static Future<Request> fakePostRequest(Request request, Employee employee) {
    return Future.delayed(const Duration(seconds: 3), () {
      return request;
    });
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
