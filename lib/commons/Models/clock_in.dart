import 'package:appba/assets/apba_theme/colors/apba_colors.dart';
import 'package:flutter/material.dart';

import 'employee.dart';

class ClockIn {
  int? id;
  String? fechaHora;
  Tipo? tipo;
  Employee? empleado;

  ClockIn({this.id, this.fechaHora, this.tipo, this.empleado});

  ClockIn.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fechaHora = json['fecha_hora'];
    if (json['tipo'] != null) {
      tipo = json['tipo'] == Tipo.entrada.value ? Tipo.entrada : Tipo.salida;
    } else {
      tipo = null;
    }

    if (json['empleado'].runtimeType == int) {
      empleado = Employee(id: json["empleado"]);
    } else if (json['empleado'].runtimeType == String) {
      id = int.parse(json["empleado"]);
      empleado = Employee(id: id);
    } else {
      empleado = Employee.fromJson(json['empleado']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fecha_hora'] = fechaHora;
    data['tipo'] = tipo;
    data['empleado'] = empleado?.id;
    return data;
  }
}

enum Tipo {
  entrada("ENTRADA", ApbaColors.semanticSuccess),
  salida("SALIDA", ApbaColors.semanticError);

  final String value;
  final Color color;

  const Tipo(this.value, this.color);
}
