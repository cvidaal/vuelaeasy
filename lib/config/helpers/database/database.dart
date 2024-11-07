
import 'package:mysql1/mysql1.dart';

class Database{

  final String _host = 'localhost';
  final int _port = 3306;
  final String _user = 'root';


  instalacion() async{
    var settings = ConnectionSettings(
      host: _host,
      port: _port,
      user: _user,
    );

    var conn = await MySqlConnection.connect(settings);
    try{
      await _crearDB(conn);
      await _crearTablaVuelos(conn);
      await _crearTablaPasajeros(conn);
      await _crearTablaBilletes(conn);
    } catch(e){
      print('Error al instalar la base de datos: $e');
      await conn.close();
    }
  }

  Future<MySqlConnection> conexion() async {
    var settings = ConnectionSettings(
        host: _host,
        port: _port,
        user: _user,
        db: 'vuelaeasy');

    return await MySqlConnection.connect(settings);
  }

  _crearDB(conn) async{
    await conn.query('CREATE DATABASE IF NOT EXISTS vuelaeasy');
    await conn.query('USE vuelaeasy');
  } 

  //TODO: PROBLEMA CON LAS FECHAS
  _crearTablaVuelos(conn) async{
    await conn.query('''CREATE TABLE IF NOT EXISTS vuelos(
    idvuelo INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    num_vuelo INT NOT NULL,
    origen VARCHAR(50) NOT NULL,
    destino VARCHAR(50) NOT NULL,
    fecha VARCHAR(20) NOT NULL,
    hora_salida TIME NOT NULL,
    hora_llegada TIME NOT NULL, 
    modelo_avion VARCHAR(50) NOT NULL,
    total_asientos INT NOT NULL);
    ''');
  }
  
  _crearTablaPasajeros(conn) async{
    await conn.query('''CREATE TABLE IF NOT EXISTS pasajeros (
    idpasajero INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellidos VARCHAR(50) NOT NULL,
    dni VARCHAR(15) UNIQUE NOT NULL,
    telefono VARCHAR(9),
    direccion VARCHAR(100)
    );
    ''');
  }

  _crearTablaBilletes(conn) async{
    await conn.query('''CREATE TABLE IF NOT EXISTS billetes (
      idbillete INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
      idvuelo INT NOT NULL,
      idpasajero INT NOT NULL,
      fecha_compra DATE NOT NULL,
      clase_servicio VARCHAR(20) NOT NULL,
      forma_pago VARCHAR(20) NOT NULL,
      precio DECIMAL(10, 2) NOT NULL,
      FOREIGN KEY (idvuelo) REFERENCES vuelos(idvuelo) ON DELETE CASCADE,
      FOREIGN KEY (idpasajero) REFERENCES pasajeros(idpasajero) ON DELETE CASCADE
    );''');
  }
}