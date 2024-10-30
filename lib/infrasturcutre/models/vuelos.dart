
class Vuelos {
  int? idvuelo;
  int? numVuelo;
  String? origen;
  String? destino;
  DateTime? fecha;
  String? horaSalida;
  String? horaLlegada;
  String? modeloAvion;
  int? totalAsientos;

  Vuelos({this.idvuelo, this.origen, this.destino, this.fecha, this.horaLlegada, this.horaSalida, this.totalAsientos, this.numVuelo, this.modeloAvion});

  Vuelos.fromJson(Map<String, dynamic> json) {
    idvuelo = json['idvuelo'];
    numVuelo = json['num_vuelo'];
    origen = json['origen'];
    destino = json['destino'];
    fecha = json['fecha'];
    horaSalida = json['hora_salida'];
    horaLlegada = json['hora_llegada'];
    modeloAvion = json['modelo_avion'];
    totalAsientos = json['total_asientos'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idvuelo'] = idvuelo;
    data['num_vuelo'] = numVuelo;
    data['origen'] = origen;
    data['destino'] = destino;
    data['fecha'] = fecha!.toIso8601String();
    data['hora_salida'] = horaSalida;
    data['hora_llegada'] = horaLlegada;
    data['modelo_avion'] = modeloAvion;
    data['total_asientos'] = totalAsientos;
    return data;
  }
}

