import 'package:appba/commons/Models/employee.dart';

class Department {
  int? id;
  String? nombre;
  Employee? jefe;

  Department({this.id, this.nombre, this.jefe});

  Department.fromJson(Map<String, dynamic> json) {
    print(json['jefe'].runtimeType);
    id = json['id'];
    nombre = json['nombre'];
    jefe = json['jefe'].runtimeType == int
        ? Employee(id: json['jefe'])
        : Employee.fromJson(json['jefe']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nombre'] = nombre;
    data['jefe'] = jefe?.id;
    return data;
  }
}
