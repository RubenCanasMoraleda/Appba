import 'package:appba/commons/API/api.dart';
import 'package:appba/commons/Models/clock_in.dart';
import 'package:appba/commons/Models/employee.dart';

class ApiClockIn {
  static Future<List<ClockIn>> getClocksInFromEmployee(
      Employee employee) async {
    dynamic res =
        await Api.GET_REQUEST("${Api.CLOCK_IN}fromEmpleado/${employee.id}");

    List<ClockIn> clockIns = [];
    // print(res["marcaje"]);
    List<dynamic> fetched = res["marcaje"];
    // print("marcajes" + fetched.toString());

    for (var item in fetched) {
      clockIns.add(ClockIn.fromJson(item));
    }
    return clockIns;
  }

  static Future<ClockIn> getLastClockInTypeFromEmployee(
      Employee employee) async {
    dynamic res =
        await Api.GET_REQUEST("${Api.CLOCK_IN}byEmployee/${employee.id}/last");

    ClockIn clockIn = ClockIn.fromJson(res["marcaje"]);

    return clockIn;
  }

  static Future<ClockIn> createClockIn(Employee employee, Tipo tipo) async {
    DateTime now = DateTime.now();
    dynamic body = {
      "fecha_hora": now,
      "tipo": tipo.value,
      "empleado": employee.id
    };
    dynamic res = await Api.POST_REQUEST("${Api.CLOCK_IN}create", body);

    ClockIn clockIn = ClockIn.fromJson(res["marcaje"]);

    return clockIn;
  }

  static getHoursMonth(Employee employee) async {
    dynamic res =
        await Api.GET_REQUEST("${Api.CLOCK_IN}getHours/${employee.id}");

    int hours = res["horas"];

    return hours;
  }

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
}
