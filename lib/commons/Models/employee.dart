import 'package:appba/commons/Models/department.dart';

class Employee {
  int? id;
  String? dni;
  String? fechaInicio;
  String? fechaFin;
  String? nombre;
  String? categoria;
  Department? departamento;

  Employee(
      {required this.id,
      this.dni,
      this.fechaInicio,
      this.fechaFin,
      this.nombre,
      this.categoria,
      this.departamento});

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dni = json['dni'];
    fechaInicio = json['fecha_inicio'];
    fechaFin = json['fecha_fin'];
    nombre = json['nombre'];
    categoria = json['categoria'];
    departamento = Department.fromJson(json['departamento']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['dni'] = dni;
    data['fecha_inicio'] = fechaInicio;
    data['fecha_fin'] = fechaFin;
    data['nombre'] = nombre;
    data['categoria'] = categoria;
    data['departamento'] = departamento?.id;
    return data;
  }
}
