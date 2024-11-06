

import 'package:mysql1/mysql1.dart';
import 'package:vuelaeasy/infrastructure/models/pasajero.dart';

class PasajerosCrud {
  final MySqlConnection conn;

  PasajerosCrud(this.conn);

  Future<int?> crearPasajero(Pasajero pasajero) async{
    try{
      var result = await conn.query('''
      INSERT INTO pasajeros (nombre, apellidos, dni, telefono, direccion )
      VALUES (?, ?, ?, ?, ?)
      ''',
      [pasajero.nombre,
      pasajero.apellidos,
      pasajero.dni,
      pasajero.telefono,
      pasajero.direccion]);

      return result.insertId; // Devuelve el id generado para utilizarlo en Comprar Billetes
    } catch(e){
      print(e);
    } 
  }

  Future<List<Pasajero>> obtenerPasajeros() async{
    try{
      final resultado = await conn.query('''SELECT * FROM pasajeros''');
      return resultado.map((e) => Pasajero.fromJson(e.fields)).toList();
    } catch(e){
      print('Error al obtener pasajeros: $e');
      return [];
    }
  }

  Future<Pasajero?> obtenerPasajeroID(int idpasajero) async{
    try{
      await conn.query('''
      SELECT * FROM pasajeros WHERE idpasajero = ?
      ''', [idpasajero]);
    } catch(e){
      print('Error al obtener pasajero por id: $e');
    }
    return null;
  }

  Future<void> actualizarPasajero(Pasajero pasajero) async{
    try{
      await conn.query('''
      UPDATE pasajeros SET nombre = ?, apellidos = ?, dni = ?, telefono = ?, direccion = ? WHERE idpasajero = ?
      ''', [
        pasajero.nombre,
        pasajero.apellidos,
        pasajero.dni,
        pasajero.telefono,
        pasajero.direccion,
        pasajero.idpasajero
      ]);
    } catch(e){
      print('Error al actualizar pasajero: $e');
    }
  }

  Future<void> eliminarPasajero(Pasajero pasajero) async{
    try{
      await conn.query('''
      DELETE FROM pasajeros WHERE idpasajero = ?
      ''', [pasajero.idpasajero]);
    } catch(e){
      print('Error al eliminar pasajero: $e');
    }
  }
  
}