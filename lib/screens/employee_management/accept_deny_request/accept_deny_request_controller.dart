import 'package:appba/commons/API/api_request.dart';
import 'package:appba/commons/Models/request.dart';

import '../../../commons/Models/employee.dart';

class AcceptDenyRequestController {
  final Employee _employee;

  AcceptDenyRequestController(this._employee);

  Future<List<Request>> getRequestsFromDepartment() {
    return ApiRequest.getFakeRequestsFromEmployee(_employee);
  }

  Future<void> acceptRequest(Request request) {
    // TODO cambiar estado a aceptado
    return Future.delayed(Duration(seconds: 1));
  }

  Future<void> denyRequest(Request request) {
    // TODO cambiar estado a aceptado
    return Future.delayed(Duration(seconds: 1));
  }
}
