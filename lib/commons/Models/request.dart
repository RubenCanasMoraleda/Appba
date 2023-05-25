import 'package:appba/assets/apba_theme/colors/apba_colors.dart';
import 'package:flutter/material.dart';

import 'employee.dart';

class Request {
  int? id;
  Employee? empleado;
  String? fechaHoraInicio;
  String? fechaHoraFin;
  String? fechaHora;
  TipoSolicitud? tipo;
  Estado? estado;

  Request(
      {this.id,
      this.empleado,
      this.fechaHora,
      this.fechaHoraFin,
      this.fechaHoraInicio,
      this.estado,
      this.tipo});

  Request.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fechaHora = json['fechaHora'];
    fechaHoraInicio = json['fechaHoraInicio'];
    fechaHoraFin = json['fechaHoraFin'];
    tipo = json['tipo'];
    estado = json['estado'];
    empleado = Employee.fromJson(json['jefe']);

    switch (json['tipo']) {
      case "ASUNTOS_PROPIOS":
        tipo = TipoSolicitud.asuntosPropios;
        break;
      case "VACACIONES":
        tipo = TipoSolicitud.vacaciones;
        break;
      case "HORAS_COMPENSATORIAS":
        tipo = TipoSolicitud.horasCompensatorias;
        break;
      default:
        tipo = null;
    }
    switch (json['estado']) {
      case "EN_ESPERA_JEFE":
        estado = Estado.enEsperaJefe;
        break;
      case "ACEPTADA_JEFE":
        estado = Estado.aceptadaJefe;
        break;
      case "EN_ESPERA_RRHH":
        estado = Estado.enEsperaRrhh;
        break;
      case "ACEPTADA_RRHH":
        estado = Estado.aceptadaRrhh;
        break;
      case "RECHAZADA":
        estado = Estado.rechazada;
        break;
      default:
        tipo = null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fechaHora'] = fechaHora;
    data['fechaHoraInicio'] = fechaHoraInicio;
    data['fechaHoraFin'] = fechaHoraFin;
    data['tipo'] = tipo!.value;
    data['estado'] = estado;
    data['empleado'] = empleado?.id;
    return data;
  }
}

enum TipoSolicitud {
  asuntosPropios("ASUNTOS_PROPIOS", "ASUNTOS PROPIOS"),
  vacaciones("VACACIONES", "VACACIONES"),
  horasCompensatorias("HORAS_COMPENSATORIAS", "HORAS COMPENSATORIAS");

  final String key, value;

  const TipoSolicitud(this.key, this.value);
}

enum Estado {
  enEsperaJefe("EN_ESPERA_JEFE", "EN ESPERA", ApbaColors.primaryOrange),
  aceptadaJefe("ACEPTADA_JEFE", "EN ESPERA", ApbaColors.primaryOrange),
  enEsperaRrhh("EN_ESPERA_RRHH", "EN ESPERA", ApbaColors.primaryOrange),
  aceptadaRrhh("ACEPTADA_RRHH", "ACEPTADA", ApbaColors.semanticSuccess),
  rechazada("RECHAZADA", "RECHAZADA", ApbaColors.semanticError);

  final String key, value;
  final Color color;

  const Estado(this.key, this.value, this.color);
}
