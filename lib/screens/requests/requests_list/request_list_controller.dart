// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:appba/commons/API/api_request.dart';
import 'package:appba/commons/Models/employee.dart';
import 'package:appba/commons/Models/request.dart';

class RequestListController {
  final Employee _employee;

  int? horasTotales, horasRealizadas;

  RequestListController(
    this._employee,
  );

  Future<List<Request>> getRequests() async {
    return ApiRequest.getRequestsFromEmployee(_employee);
  }
}
