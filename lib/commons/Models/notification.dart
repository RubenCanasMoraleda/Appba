import 'package:appba/commons/Models/employee.dart';

class Notificacion {
  int? id;
  String? date;
  String? description;

  String? title;

  Notificacion({this.id, this.description, this.date, this.title});

  Notificacion.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['fecha'];
    description = json['descripcion'];
    title = json['titulo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fecha'] = date;
    data['titulo'] = title;
    data['descripcion'] = description;
    return data;
  }
}
