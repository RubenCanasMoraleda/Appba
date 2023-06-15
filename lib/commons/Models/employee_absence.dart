import 'employee.dart';

class EmployeeAbsence {
  Employee? empleado;
  int? vacacionesTotales;
  int? vacacionesCogidas;
  int? asuntosPropiosTotales;
  int? asuntosPropiosCogidos;
  int? horasCompensatoriasRestantes;
  int? horasCompensatoriasCogidas;

  EmployeeAbsence({
    this.empleado,
    this.vacacionesTotales,
    this.vacacionesCogidas,
    this.asuntosPropiosTotales,
    this.asuntosPropiosCogidos,
    this.horasCompensatoriasRestantes,
  });

  EmployeeAbsence.fromJson(Map<String, dynamic> json) {
    vacacionesTotales = json['vacacionesTotales'];
    vacacionesCogidas = json['vacacionesCogidas'];
    asuntosPropiosTotales = json['asuntosPropiosTotales'];
    asuntosPropiosCogidos = json['asuntosPropiosCogidos'];
    horasCompensatoriasRestantes = json['horasCompensatoriasRestantes'];
    horasCompensatoriasCogidas = json['horasCompensatoriasCogidas'];
    empleado = Employee.fromJson(json['jefe']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vacacionesTotales'] = vacacionesTotales;
    data['vacacionesCogidas'] = vacacionesCogidas;
    data['asuntosPropiosTotales'] = asuntosPropiosTotales;
    data['asuntosPropiosCogidos'] = asuntosPropiosCogidos;
    data['horasCompensatoriasRestantes'] = horasCompensatoriasRestantes;
    data['horasCompensatoriasCogidas'] = horasCompensatoriasCogidas;
    data['empleado'] = empleado?.id;
    return data;
  }
}
