import 'package:mysql1/mysql1.dart';
import 'package:vuelaeasy/infrastructure/models/vuelo.dart';

class VuelosCrud {
  final MySqlConnection conn;

  VuelosCrud(this.conn);

  // Método para crear vuelos
  Future<void> crearVuelos(Vuelo vuelo) async{
    try{
      await conn.query('''
      INSERT INTO vuelos (num_vuelo, origen, destino, fecha, hora_salida, hora_llegada, modelo_avion, total_asientos) 
      VALUES (?, ?, ?, ?, ?, ?, ?, ?)
      ''', 
      [vuelo.numVuelo, 
      vuelo.origen, 
      vuelo.destino, 
      vuelo.fecha, 
      vuelo.horaSalida, 
      vuelo.horaLlegada, 
      vuelo.modeloAvion, 
      vuelo.totalAsientos]
    );
    } catch(e){
      print('Error al crear vuelo: $e');
    }
    }
  
  // Método para obtener vuelos
  Future<List<Vuelo>> obtenerVuelos() async{ 
    try{
      final results = await conn.query('SELECT * FROM vuelos'); // <-- Devuelve una lista de objetos de la tabla vuelos
      //print(results.map((e) => e.fields).toList());
      return results.map((e) => Vuelo.fromJson(e.fields)).toList(); // <-- e.fields contiene los datos de cada fila en forma de Map<String, dynamic>
    } catch(e){
      print('Error al obtener vuelos $e');
      return [];
    }
  }

  //Obtener vuelos por id
  Future<Vuelo?> obtenerVueloID(String destino) async{
    try{
      var result = await conn.query('''
      SELECT * FROM vuelos WHERE destino = ?
      ''', [destino]);
      return Vuelo.fromJson(result.first.fields);
    } catch(e){
      print('Error al obtener vuelo por destino: $e');
    }
    return null;
  }

  // Método para actualizar vuelo
  Future<void> actualizarVuelo(Vuelo vuelo) async{
    try{
    await conn.query('''
    UPDATE vuelos SET num_vuelo = ?, origen = ?, destino = ?, fecha = ?, hora_salida = ?, hora_llegada = ?, modelo_avion = ?, total_asientos = ? WHERE idvuelo = ?
    ''', [
      vuelo.numVuelo,
      vuelo.origen,
      vuelo.destino,
      vuelo.fecha,
      vuelo.horaSalida,
      vuelo.horaLlegada,
      vuelo.modeloAvion,
      vuelo.totalAsientos,
      vuelo.idvuelo
    ]);
    } catch(e){
      print('Error al actualizar vuelo: $e');
    }
  }

  // Método para eliminar vuelo
  Future<void> eliminarVuelo(Vuelo vuelo) async{
    try{
    await conn.query('''
    DELETE FROM vuelos WHERE idvuelo = ?
    ''', [vuelo.idvuelo]);
    } catch(e){
      print('Error al eliminar vuelo: $e');
  }
  }
}