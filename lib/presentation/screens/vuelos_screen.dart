import 'package:flutter/material.dart';
import 'package:vuelaeasy/config/helpers/database/vuelos_crud.dart';
import 'package:vuelaeasy/presentation/screens/agregar_vuelo_screen.dart';

class VuelosScreen extends StatefulWidget {

  final VuelosCrud vuelosCrud; // Recibe la instancia de la clase VuelosCrud

  const VuelosScreen({super.key, required this.vuelosCrud});

  @override
  State<VuelosScreen> createState() => _VuelosScreenState();
}

class _VuelosScreenState extends State<VuelosScreen> {
  List vuelos = []; // Almacena la lista de vuelos

  @override
  void initState() {
    super.initState();
    _cargarVuelos(); // Cargar los vuelos al iniciar la pantalla
  }

  Future<void> _cargarVuelos() async {
    final nuevosVuelos = await widget.vuelosCrud.obtenerVuelos();
    setState(() {
      vuelos = nuevosVuelos; // Actualiza la lista de vuelos
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VuelaEasy - Vuelos'),
      ),
      body: vuelos.isEmpty // Verifica si la lista de vuelos está vacía
          ? const Center(child: Text('No hay vuelos disponibles!'))
          : ListView.builder(
                itemCount: vuelos.length,
                itemBuilder: (context, index) {
                  final vuelo = vuelos[index];
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: 150,
                        color: Colors.black87,
                        child: ListTile(
                          title: Text('Vuelo de ${vuelo.origen} a ${vuelo.destino}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),),
                          subtitle: Text('Fecha: ${vuelo.fecha}\nHora salida: ${vuelo.horaSalida}\nAsientos: ${vuelo.totalAsientos}', style: const TextStyle(color: Colors.white),),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AgregarVueloScreen(vuelo: vuelo, vuelosCrud: widget.vuelosCrud),
                                    ),
                                  );
                                  _cargarVuelos(); // Actualiza la lista después de editar
                                },
                                icon: const Icon(Icons.edit),
                                color: Colors.blue,
                              ),
                              IconButton(
                                onPressed: () async {
                                  await widget.vuelosCrud.eliminarVuelo(vuelo);
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Vuelo eliminado')));
                                  _cargarVuelos(); // Actualiza la lista después de eliminar
                                },
                                icon: const Icon(Icons.delete_forever_rounded),
                                color: Colors.redAccent,
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
                await Navigator.push(context, MaterialPageRoute(builder: (context) => AgregarVueloScreen(vuelosCrud: widget.vuelosCrud)));
                _cargarVuelos(); // Actualiza la lista después de agregar
              },
              child: const Icon(Icons.add),
            ),
           
          );
  }
}