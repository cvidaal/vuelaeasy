import 'package:flutter/material.dart';

class HomeSreen extends StatelessWidget {
  const HomeSreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VuelaEasy'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          //TODO: Registrarse como pasajero
          // TODO: Añadir vuelos
          // TODO: Comprar billetes 
        ),
      ),
    );
  }
}