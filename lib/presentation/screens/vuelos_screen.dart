import 'package:flutter/material.dart';
import 'package:vuelaeasy/config/helpers/database/vuelos_crud.dart';
import 'package:vuelaeasy/presentation/screens/agregar_vuelo_screen.dart';
import 'package:vuelaeasy/presentation/screens/info_vuelo_screen.dart';

class VuelosScreen extends StatefulWidget {
  final VuelosCrud vuelosCrud;

  const VuelosScreen({super.key, required this.vuelosCrud});

  @override
  State<VuelosScreen> createState() => _VuelosScreenState();
}

class _VuelosScreenState extends State<VuelosScreen> {
  List vuelos = [];

  @override
  void initState() {
    super.initState();
    _cargarVuelos();
  }

  Future<void> _cargarVuelos() async {
    final nuevosVuelos = await widget.vuelosCrud.obtenerVuelos();
    setState(() {
      vuelos = nuevosVuelos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VuelaEasy - Vuelos'),
      ),
      body: vuelos.isEmpty
          ? const Center(child: Text('No hay vuelos disponibles!', style: TextStyle(fontSize: 18)))
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              itemCount: vuelos.length,
              itemBuilder: (context, index) {
                final vuelo = vuelos[index];
                final asientosMensaje = vuelo.totalAsientos == 0 ? 'No hay asientos disponibles' : '${vuelo.totalAsientos}';
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: GestureDetector(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InfoVueloScreen(vuelo: vuelo),
                        ),
                      );
                    },
                    child: Card(
                      color: Colors.white,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Vuelo de ${vuelo.origen} a ${vuelo.destino}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 10),
                            _infoRow('Fecha', vuelo.fecha),
                            const SizedBox(height: 6),
                            _infoRow('Hora salida', vuelo.horaSalida),
                            const SizedBox(height: 6),
                            _infoRow('Hora llegada', vuelo.horaLlegada),
                            const SizedBox(height: 6),
                            _infoRow('Asientos', vuelo.totalAsientos.toString()),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AgregarVueloScreen(
                                            vuelo: vuelo,
                                            vuelosCrud: widget.vuelosCrud),
                                      ),
                                    );
                                    _cargarVuelos();
                                  },
                                  icon: const Icon(Icons.edit),
                                  color: Colors.blueAccent,
                                ),
                                IconButton(
                                  onPressed: () async {
                                    await widget.vuelosCrud.eliminarVuelo(vuelo);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text('Vuelo eliminado')));
                                    _cargarVuelos();
                                  },
                                  icon: const Icon(Icons.delete_forever_rounded),
                                  color: Colors.redAccent,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      AgregarVueloScreen(vuelosCrud: widget.vuelosCrud)));
          _cargarVuelos();
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label + ':',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black54,
            fontSize: 16,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            color: Colors.black87,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
