import 'employee.dart';

class Request {
  int? id;
  Employee? empleado;
  String? fechaHoraInicio;
  String? fechaHoraFin;
  String? fechaHora;
  String? tipo;
  String? estadoJefe;
  String? estadoRrhh;

  Request(
      {this.id,
      this.empleado,
      this.fechaHora,
      this.fechaHoraFin,
      this.fechaHoraInicio,
      this.estadoJefe,
      this.estadoRrhh,
      this.tipo});

  Request.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fechaHora = json['fechaHora'];
    fechaHoraInicio = json['fechaHoraInicio'];
    fechaHoraFin = json['fechaHoraFin'];
    tipo = json['tipo'];
    estadoJefe = json['estadoJefe'];
    estadoRrhh = json['estadoRrhh'];
    empleado = Employee.fromJson(json['jefe']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fechaHora'] = fechaHora;
    data['fechaHoraInicio'] = fechaHoraInicio;
    data['fechaHoraFin'] = fechaHoraFin;
    data['tipo'] = tipo;
    data['estadoJefe'] = estadoJefe;
    data['estadoRrhh'] = estadoRrhh;
    data['empleado'] = empleado?.id;
    return data;
  }
}
