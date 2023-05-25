// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:appba/commons/API/api.dart';
import 'package:appba/commons/Models/employee.dart';
import 'package:appba/commons/Models/request.dart';

class CreateRequestController {
  final Employee _employee;

  int? horasTotales, horasRealizadas;

  CreateRequestController(
    this._employee,
  );

  Future<Request> postRequest(request) {
    return Api.fakePostRequest(request, _employee);
  }
}
