import 'employee.dart';

class ClockIn {
  int? id;
  String? fechaHora;
  String? tipo;
  Employee? empleado;

  ClockIn({this.id, this.fechaHora, this.tipo, this.empleado});

  ClockIn.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fechaHora = json['fecha_hora'];
    tipo = json['tipo'];
    empleado = Employee.fromJson(json['empleado']);
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
