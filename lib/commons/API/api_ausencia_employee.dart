import 'package:appba/commons/Models/employee.dart';

import 'api.dart';

class ApiAusenciaEmployee {
  static Future<int> getVacacionesRestantes(Employee employee) async {
    dynamic res =
        await Api.GET_REQUEST(Api.VACACIONESRESTANTES + employee.id.toString());

    return ((res["data"]));
  }

  static Future<int> getDiasRestantes(Employee employee) async {
    dynamic res =
        await Api.GET_REQUEST(Api.VACACIONESRESTANTES + employee.id.toString());

    return ((res["data"]));
  }

  static Future<int> getHorasRestantes(Employee employee) async {
    dynamic res =
        await Api.GET_REQUEST("${Api.VACACIONESRESTANTES}${employee.id}");
    return ((res["data"]));
  }
}
