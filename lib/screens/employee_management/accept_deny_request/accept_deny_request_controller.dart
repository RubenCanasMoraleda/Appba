import 'package:appba/commons/API/api_request.dart';
import 'package:appba/commons/Models/request.dart';

import '../../../commons/Models/employee.dart';

class AcceptDenyRequestController {
  final Employee _employee;

  AcceptDenyRequestController(this._employee);

  Future<List<Request>> getRequestsFromDepartment() {
    late Future<List<Request>> requestsList;

    switch (_employee.rol) {
      case "recursos humanos":
        requestsList = ApiRequest.getRequestsRRHH();
        break;
      case "jefe recursos humanos":
        requestsList = ApiRequest.getRequestsRRHHBoss(_employee.departamento!);
        break;
      default:
        requestsList =
            ApiRequest.getRequestFromDepartment(_employee.departamento!);
    }
    return requestsList;
  }

  acceptRequest(Request request) {
    request.estado =
        _employee.rol == "jefe" ? Estado.enEsperaRrhh : Estado.aceptada;

    ApiRequest.updateRequest(request);
  }

  denyRequest(Request request) {
    request.estado = Estado.rechazada;
    ApiRequest.updateRequest(request);
  }
}
