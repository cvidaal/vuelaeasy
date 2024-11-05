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
  int _selectedIndex = 0; // Para navegar de una pantalla a otra
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

  // Lista de pantallas, cada índice corresponde a una pestaña del BottomNavigationBar
  List<Widget> get _screens => [
        _buildVuelosList(), // La lista de vuelos
        const Center(child: Text('Billetes')), // Una pantalla de ejemplo
        const Center(child: Text('Perfil')), // Otra pantalla de ejemplo
      ];

  // Construye la lista de vuelos como un widget separado
  Widget _buildVuelosList() {
    return vuelos.isEmpty
        ? const Center(child: Text('No hay vuelos disponibles!'))
        : ListView.builder(
            itemCount: vuelos.length,
            itemBuilder: (context, index) {
              final vuelo = vuelos[index];
              return Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 8),
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
                    color: Colors.blue[100],
                    child: ListTile(
                      title: Text(
                        'Vuelo de ${vuelo.origen} a ${vuelo.destino}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Text('Fecha: ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800, fontSize: 17)),
                              Text(vuelo.fecha),
                            ],
                          ),
                          Row(
                            children: [
                              const Text('Hora salida: ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800, fontSize: 17)),
                              Text(vuelo.horaSalida),
                            ],
                          ),
                          Row(
                            children: [
                              const Text('Asientos: ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800, fontSize: 17)),
                              Text(vuelo.totalAsientos.toString()),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
  }

  void _cambiarItem(int index) {
    setState(() {
      _selectedIndex = index; // Actualiza el índice para cambiar de pantalla
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VuelaEasy - Vuelos'),
      ),
      body: _screens[_selectedIndex], // Muestra la pantalla según el índice
      floatingActionButton: _selectedIndex == 0 // Solo en la primera pantalla
          ? FloatingActionButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AgregarVueloScreen(vuelosCrud: widget.vuelosCrud),
                  ),
                );
                _cargarVuelos(); // Actualiza después de agregar un vuelo
              },
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.flight),
            label: 'Vuelos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.airplane_ticket),
            label: 'Billetes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _cambiarItem,
      ),
    );
  }
}
