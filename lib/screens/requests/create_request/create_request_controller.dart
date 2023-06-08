import 'package:appba/commons/API/api_ausencia_employee.dart';
import 'package:appba/commons/API/api_request.dart';
import 'package:appba/commons/Models/employee.dart';
import 'package:appba/commons/Models/request.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreateRequestController {
  final Employee _employee;

  int? horasTotales, horasRealizadas;

  CreateRequestController(
    this._employee,
  );

  postRequest(TipoSolicitud tipoSolicitud, String fechaHoraInicio,
      String fechaHoraFin) {
    Request request = Request(
        empleado: _employee,
        fechaHora: DateTime.now().toString(),
        fechaHoraFin: fechaHoraFin,
        fechaHoraInicio: fechaHoraFin,
        estado: getEstadoSolicitud(),
        tipo: tipoSolicitud);
    if (canMakeRequest(tipoSolicitud, fechaHoraInicio, fechaHoraFin)) {
      ApiRequest.createRequest(request).then((value) =>
          Fluttertoast.showToast(msg: "Solicitud de ${value!.tipo} enviada"));
    }
  }

  postRequestWithHours(TipoSolicitud tipoSolicitud, String fechaInicio,
      String horaInicio, String horaFin) {
    String fechaHoraInicio = "$fechaInicio $horaInicio";
    //TODO check hora menor
    String fechaHoraFin = "$fechaInicio $horaFin";

    postRequest(tipoSolicitud, fechaHoraInicio, fechaHoraFin);
  }

  Estado getEstadoSolicitud() {
    switch (_employee.rol) {
      case "jefe recursos humanos":
        return Estado.aceptada;
      case "jefe":
        return Estado.enEsperaRrhh;
      default:
        return Estado.enEsperaJefe;
    }
  }

  bool canMakeRequest(TipoSolicitud tipoSolicitud, String fechaHoraInicio,
      String fechaHoraFin) {
    int numLeft = 0;
    Duration durationToTake = DateTime.parse(fechaHoraFin)
        .difference(DateTime.parse(fechaHoraInicio));
    int willingToTake = 0;
    String unit = "dias";

    switch (tipoSolicitud) {
      case TipoSolicitud.vacaciones:
        ApiAusenciaEmployee.getVacacionesRestantes(_employee).then((value) {
          numLeft = value;
        });
        willingToTake = durationToTake.inDays;
        break;
      case TipoSolicitud.asuntosPropios:
        ApiAusenciaEmployee.getDiasRestantes(_employee).then((value) {
          numLeft = value;
        });
        willingToTake = durationToTake.inDays;

        break;
      case TipoSolicitud.horasCompensatorias:
        ApiAusenciaEmployee.getHorasRestantes(_employee).then((value) {
          numLeft = value;
        });
        willingToTake = durationToTake.inHours;
        unit = "horas";
        break;
      default:
    }

    if (willingToTake < numLeft) {
      return true;
    } else {
      Fluttertoast.showToast(
          msg: "Solo dispone de $numLeft $unit de ${tipoSolicitud.value}");
      return false;
    }
  }
}
