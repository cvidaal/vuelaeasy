import 'package:mysql1/mysql1.dart';

class Vuelo {

  int? idvuelo;
  int? numVuelo;
  String? origen;
  String? destino;
  String? fecha; // TODO: Solucionar problema con las fechas
  String? horaSalida; // TODO: Solucionar problema con las horas
  String? horaLlegada;
  String? modeloAvion;
  int? totalAsientos;

  Vuelo({this.idvuelo, this.origen, this.destino, this.fecha, this.horaLlegada, this.horaSalida, this.totalAsientos, this.numVuelo, this.modeloAvion});

  Vuelo.fromJson(Map<String, dynamic> json) {
    idvuelo = json['idvuelo'];
    numVuelo = json['num_vuelo'];
    origen = json['origen'];
    destino = json['destino'];
    fecha = json['fecha'];
    horaSalida = _durationToString(json['hora_salida']);
    horaLlegada = _durationToString(json['hora_llegada']);
    modeloAvion = json['modelo_avion'];
    totalAsientos = json['total_asientos'];
  }

    // Función para convertir Duration a String
  String? _durationToString(dynamic duration) {
    if (duration is Duration) {
      // Convierte a formato 'HH:mm:ss'
      return '${duration.inHours}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
    } else if (duration is String) {
      return duration; // ya es un String
    }
    return null; // o el manejo de errores
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idvuelo'] = idvuelo;
    data['num_vuelo'] = numVuelo;
    data['origen'] = origen;
    data['destino'] = destino;
    data['fecha'] = fecha;
    data['hora_salida'] = horaSalida;
    data['hora_llegada'] = horaLlegada;
    data['modelo_avion'] = modeloAvion;
    data['total_asientos'] = totalAsientos;
    return data;
  }

    Vuelo copyWith({
    int? idvuelo,
    int? numVuelo,
    String? origen,
    String? destino,
    String? fecha,
    String? horaSalida,
    String? horaLlegada,
    int? totalAsientos,
  }) {
    return Vuelo(
      idvuelo: idvuelo ?? this.idvuelo,
      numVuelo: numVuelo ?? this.numVuelo,
      origen: origen ?? this.origen,
      destino: destino ?? this.destino,
      fecha: fecha ?? this.fecha,
      horaSalida: horaSalida ?? this.horaSalida,
      horaLlegada: horaLlegada ?? this.horaLlegada,
      totalAsientos: totalAsientos ?? this.totalAsientos,
    );
  }
}


