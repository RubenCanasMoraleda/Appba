import 'package:appba/commons/Models/employee.dart';
import 'package:appba/commons/Models/request.dart';

class ApiRequest {
  static Future<List<Request>> getRequestsFromEmployee(Employee employee) {
    Future<List<Request>> requests = getFakeRequestsFromEmployee(employee);

    return requests;
  }

  static Future<Request> fakePostRequest(Request request) {
    return Future.delayed(const Duration(seconds: 3), () {
      return request;
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
