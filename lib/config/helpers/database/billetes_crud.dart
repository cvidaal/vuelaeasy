import 'package:mysql1/mysql1.dart';
import 'package:vuelaeasy/config/helpers/database/vuelos_crud.dart';
import 'package:vuelaeasy/infrastructure/models/billete.dart';

class BilletesCrud {
  final MySqlConnection conn;

  BilletesCrud(this.conn);

  Future<void> crearBillete(Billete billete) async{
    try{
      await conn.query('''
      INSERT INTO billetes (idvuelo, idpasajero, fecha_compra, clase_servicio, forma_pago, precio)
      VALUES (?, ?, ?, ?, ?, ?)
    ''',
    [billete.idvuelo,
    billete.idpasajero,
    billete.fechaCompra?.toIso8601String(),
    billete.claseServicio,
    billete.formaPago,
    billete.precio]
    );

    // Llamo al método de la clase Vueloscrud para actualizar el número de asientos
    final vuelosCrud = VuelosCrud(conn);
    await vuelosCrud.restarAsientos(billete.idvuelo!);
    
    } catch(e){
      print('Error al crear billete: $e');
    }
  }

  Future<List<Map<String, dynamic>>> obtenerBilletes() async{
    // Obtiene todos los billetes y campos de las tablas pasajeros y vuelos
    try{
      final resultado = await conn.query('''
      SELECT billetes.idbillete,
      pasajeros.nombre AS nombre_pasajero, 
      vuelos.num_vuelo AS numero_vuelo,
      billetes.fecha_compra,
      billetes.clase_servicio,
      billetes.forma_pago,
      billetes.precio
    FROM billetes
    JOIN pasajeros ON billetes.idpasajero = pasajeros.idpasajero
    JOIN vuelos ON billetes.idvuelo = vuelos.idvuelo
    ''');

    return resultado.map((e) => e.fields).toList();
    } catch(e){
      print('Error al obtener billetes: $e');
      return [];
    }
  }

  Future<Map<String, dynamic>?> obtenerBilleteID(int idbillete) async{
    try{
      final resultado = await conn.query('''
      SELECT billetes.idbillete,
      pasajeros.nombre AS nombre_pasajero, 
      vuelos.num_vuelo AS numero_vuelo,
      billetes.fecha_compra,
      billetes.clase_servicio,
      billetes.forma_pago,
      billetes.precio
    FROM billetes
    JOIN pasajeros ON billetes.idpasajero = pasajeros.idpasajero
    JOIN vuelos ON billetes.idvuelo = vuelos.idvuelo
    WHERE billetes.idbillete = ?
    ''', [idbillete]);

    return resultado.isNotEmpty ? resultado.first.fields : null;
    } catch(e){
      print('Error al obtener billete por id: $e');
    }
    return null;
  }

  Future<bool> existeBilletePasajero(int idPasajero, int idVuelo) async{
    var resultado = await conn.query('''
      SELECT 1 FROM billetes WHERE idpasajero = ? AND idvuelo = ?
    ''', [idPasajero, idVuelo]);
    return resultado.isNotEmpty; //Retorna true si hay al menos un billete
  }

  Future<void> actualizarBillete(Billete billete) async{
    try{
      await conn.query('''
      UPDATE billetes SET idvuelo = ?, idpasajero = ?, fecha_compra = ?, clase_servicio = ?, forma_pago = ?, precio = ? WHERE idbillete = ?
      ''', [
        billete.idvuelo,
        billete.idpasajero,
        billete.fechaCompra?.toIso8601String(),
        billete.claseServicio,
        billete.formaPago,
        billete.precio,
        billete.idbillete
      ]);
    } catch(e){
      print('Error al actualizar billete: $e');
    }
  }

  Future<void> eliminarBillete(Billete billete) async{
    try{
      await conn.query('''
      DELETE FROM billetes WHERE idbillete = ?
      ''', [billete.idbillete]);
    } catch(e){
      print('Error al eliminar billete: $e');
    }
  }
}