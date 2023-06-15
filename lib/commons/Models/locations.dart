class Location {
  int? id;
  String? name, adress;
  double? lat, long;
  Category? category;

  Location(
      {this.id, this.adress, this.name, this.category, this.lat, this.long});

  Location.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['nombre'];
    category = Category.fromString(json['categoria']);
    adress = json['direccion'];
    lat = double.parse(json['latitud']);
    long = double.parse(json['longitud']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nombre'] = name;
    data['categoria'] = category?.value;
    data['direccion'] = adress;
    data['latitud'] = lat.toString();
    data['longitud'] = long.toString();
    return data;
  }
}

enum Category {
  autoridadPortuaria(
      "AUTORIDAD_PORTUARIA", "Autoridad Portuaria de la Bahía de Algeciras"),
  estacionesMaritimas("ESTACIONES_MARITIMAS", "Estaciones Marítimas"),
  puestoInspeccionFronterizo(
      "PUESTO_INSPECCION_FRONTERIZO", "Puesto de Inspección Fronterizo"),
  totalTerminalInternational(
      "TOTAL_TERMINAL_INTERNACIONAL", "Total Terminal International Algeciras"),
  terminalTraficoPesado(
      "TERMINAL_TRAFICO_PESADO", "Terminal de Tráfico Pesado"),
  capitaniaMaritima("CAPITANIA_MARITIMA", "Capitanía Marítima"),
  aduana("ADUANA", "Aduana"),
  apmTerminals("APM_TERMINALS", "APM Terminals Algeciras"),
  centrosEducativos("CENTROS_EDUCATIVOS", "IES Saladillo");

  final String key, value;

  const Category(this.key, this.value);

  static Category? fromString(String string) {
    switch (string) {
      case "AUTORIDAD_PORTUARIA":
        return Category.autoridadPortuaria;
      case "ESTACIONES_MARITIMAS":
        return Category.estacionesMaritimas;

      case "PUESTO_INSPECCION_FRONTERIZO":
        return Category.puestoInspeccionFronterizo;

      case "TOTAL_TERMINAL_INTERNACIONAL":
        return Category.totalTerminalInternational;

      case "TERMINAL_TRAFICO_PESADO":
        return Category.terminalTraficoPesado;

      case "CAPITANIA_MARITIMA":
        return Category.capitaniaMaritima;

      case "ADUANA":
        return Category.aduana;

      case "APM_TERMINALS":
        return Category.apmTerminals;

      case "CENTROS_EDUCATIVOS":
        return Category.centrosEducativos;

      default:
        return null;
    }
  }
}
