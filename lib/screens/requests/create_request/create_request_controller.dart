import 'package:appba/commons/API/api_request.dart';
import 'package:appba/commons/Models/employee.dart';
import 'package:appba/commons/Models/request.dart';

class CreateRequestController {
  final Employee _employee;

  int? horasTotales, horasRealizadas;

  CreateRequestController(
    this._employee,
  );

  Future<Request> postRequest(request) {
    return ApiRequest.fakePostRequest(request, _employee);
  }
}
