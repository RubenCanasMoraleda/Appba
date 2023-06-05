import 'package:appba/commons/API/api_request.dart';
import 'package:appba/commons/Models/employee.dart';
import 'package:appba/commons/Models/request.dart';

class CreateRequestController {
  final Employee _employee;

  int? horasTotales, horasRealizadas;

  CreateRequestController(
    this._employee,
  );

  Future<Request> postRequest(TipoSolicitud tipoSolicitud,
      String fechaHoraInicio, String fechaHoraFin) {
    Request request = Request(
        empleado: _employee,
        fechaHora: DateTime.now().toString(),
        fechaHoraFin: fechaHoraFin,
        fechaHoraInicio: fechaHoraFin,
        estado: Estado.enEsperaJefe,
        tipo: tipoSolicitud);

    return ApiRequest.fakePostRequest(request);
  }

  Future<Request> postRequestWithHours(TipoSolicitud tipoSolicitud,
      String fechaInicio, String horaInicio, String horaFin) {
    // TODO convertir fecha inicio, hora inicio y hora fin en fechahorainicio y fechahorafin

    return postRequest(tipoSolicitud, fechaInicio, horaFin);
  }
}
