import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:vuelaeasy/config/helpers/database/billetes_crud.dart';
import 'package:vuelaeasy/config/helpers/database/database.dart';
import 'package:vuelaeasy/config/helpers/database/pasajeros_crud.dart';
import 'package:vuelaeasy/infrastructure/models/vuelo.dart';
import 'package:vuelaeasy/presentation/screens/comprar_billete_screen.dart';

class InfoVueloScreen extends StatefulWidget {
  final Vuelo vuelo; // Recibe el vuelo a mostrar

  const InfoVueloScreen({super.key, required this.vuelo});

  @override
  State<InfoVueloScreen> createState() => _InfoVueloScreenState();
}

class _InfoVueloScreenState extends State<InfoVueloScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del Vuelo'),
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Título
                  Text(
                    'Vuelo de ${widget.vuelo.origen} a ${widget.vuelo.destino}',
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
        
                  // Lista de detalles del vuelo
                  _buildDetailTile(Icons.flight_takeoff, 'Número de Vuelo',
                      widget.vuelo.numVuelo.toString()),
                  _buildDetailTile(
                      Icons.place, 'Origen', widget.vuelo.origen.toString()),
                  _buildDetailTile(
                      Icons.place_outlined, 'Destino', widget.vuelo.destino.toString()),
                  _buildDetailTile(
                      Icons.calendar_today, 'Fecha', widget.vuelo.fecha.toString()),
                  _buildDetailTile(Icons.schedule, 'Hora de Salida',
                      widget.vuelo.horaSalida.toString()),
                  _buildDetailTile(Icons.access_time_filled, 'Hora de Llegada',
                      widget.vuelo.horaLlegada.toString()),
                  _buildDetailTile(Icons.airplanemode_active, 'Modelo de Avión',
                      widget.vuelo.modeloAvion.toString()),
                  _buildDetailTile(Icons.event_seat, 'Asientos disponibles',
                      widget.vuelo.totalAsientos.toString()),
        
                  const SizedBox(height: 10,),
                  FilledButton(
                      onPressed: () async{
                        MySqlConnection conn = await Database().conexion(); // Conexión a la base de datos

                        Navigator.push(context, MaterialPageRoute(builder: (context) => ComprarBilleteScreen(
                          vuelo: widget.vuelo, // Incluye el vuelo en la instancia
                          pasajerosCrud: PasajerosCrud(conn),
                          billetesCrud: BilletesCrud(conn),
                        )));
                      }
                      ,
                      style: FilledButton.styleFrom(
                          // Esta línea sirve para agregar estilo al boton
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10)),
                      child: const Text(
                        'Comprar billete',
                        style: TextStyle(fontSize: 20),
                      )),
                      
                      const SizedBox(height: 10,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Función para construir cada fila de información con íconos y datos
  Widget _buildDetailTile(IconData icon, String title, String value) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 4),
      leading: Icon(icon, color: Colors.blue, size: 30),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(value, style: const TextStyle(fontSize: 16)),
    );
  }
}
