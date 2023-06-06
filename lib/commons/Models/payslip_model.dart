import 'package:appba/commons/Models/employee.dart';

class Payslip {
  int? id;
  Employee? empleado;
  String? fecha;
  String? path;

  Payslip({this.id, this.empleado, this.fecha, this.path});

  Payslip.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fecha = json['fecha'];
    path = json['path'];
    empleado = json['empleado'].runtimeType == int
        ? Employee(id: json['empleado'])
        : Employee.fromJson(json['empleado']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fecha'] = fecha;
    data['path'] = path;
    data['empleado'] = empleado?.id;
    return data;
  }
}
