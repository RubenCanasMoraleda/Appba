import 'package:appba/commons/API/api.dart';
import 'package:appba/commons/Models/department.dart';
import 'package:appba/commons/Models/employee.dart';
import 'package:appba/commons/Models/request.dart';

class ApiRequest {
  static Future<List<Request>> getRequestsFromEmployee(
      Employee employee) async {
    dynamic res =
        await Api.GET_REQUEST("${Api.REQUEST}fromEmpleado/${employee.id}");

    List<Request> requestConf = [];
    List<dynamic> fetched = res["data"];

    for (var item in fetched) {
      requestConf.add(Request.fromJson(item));
    }

    return requestConf;
  }

  static Future<List<Request>> getRequestsRRHH() async {
    dynamic res = await Api.GET_REQUEST("${Api.REQUEST}rrhh");

    List<Request> requestConf = [];
    List<dynamic> fetched = res["data"];

    for (var item in fetched) {
      requestConf.add(Request.fromJson(item));
    }

    return requestConf;
  }

  static Future<Request?> createRequest(Request request) async {
    dynamic body = request.toJson();
    dynamic res = await Api.POST_REQUEST(Api.REQUEST, body);

    Request requestConf = Request.fromJson(res["data"]);

    return requestConf;
  }

  static Future<Request?> updateRequest(Request request) async {
    dynamic body = request.toJson();
    dynamic res = await Api.PATCH_REQUEST(Api.REQUEST, body);
    print(res);
    Request requestConf = Request.fromJson(res["data"]);

// Todo refresh de la lista de solicitudes
    return requestConf;
  }

  static Future<List<Request>> getRequestFromDepartment(
      Department department) async {
    dynamic res = await Api.GET_REQUEST(
        "${Api.REQUEST}fromDepartamento/${department.id}");

    List<Request> requestConf = [];
    List<dynamic> fetched = res["data"];

    for (var item in fetched) {
      requestConf.add(Request.fromJson(item));
    }

    return requestConf;
  }

  static Future<List<Request>> getRequestsRRHHBoss(
      Department department) async {
    dynamic res = await Api.GET_REQUEST("${Api.REQUEST}rrhh");

    List<Request> requestConf = [];
    List<dynamic> fetched = res["data"];

    for (var item in fetched) {
      requestConf.add(Request.fromJson(item));
    }

    res = await Api.GET_REQUEST(
        "${Api.REQUEST}fromDepartamento/${department.id}");

    fetched = res["data"];

    for (var item in fetched) {
      requestConf.add(Request.fromJson(item));
    }

    return requestConf;
  }
}
