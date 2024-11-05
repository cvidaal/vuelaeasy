import 'package:flutter/material.dart';
import 'package:vuelaeasy/infrastructure/models/vuelo.dart';

class InfoVueloScreen extends StatelessWidget {
  final Vuelo vuelo; // Recibe el vuelo a mostrar

  const InfoVueloScreen({super.key, required this.vuelo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del Vuelo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Título
                Text(
                  'Vuelo de ${vuelo.origen} a ${vuelo.destino}',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),

                // Lista de detalles del vuelo
                _buildDetailTile(Icons.flight_takeoff, 'Número de Vuelo', vuelo.numVuelo.toString()),
                _buildDetailTile(Icons.place, 'Origen', vuelo.origen.toString()),
                _buildDetailTile(Icons.place_outlined, 'Destino', vuelo.destino.toString()),
                _buildDetailTile(Icons.calendar_today, 'Fecha', vuelo.fecha.toString()),
                _buildDetailTile(Icons.schedule, 'Hora de Salida', vuelo.horaSalida.toString()),
                _buildDetailTile(Icons.access_time_filled, 'Hora de Llegada', vuelo.horaLlegada.toString()),
                _buildDetailTile(Icons.airplanemode_active, 'Modelo de Avión', vuelo.modeloAvion.toString()),
                _buildDetailTile(Icons.event_seat, 'Total de Asientos', vuelo.totalAsientos.toString()),
              ],
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
      title: Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(value, style: TextStyle(fontSize: 16)),
    );
  }
}
