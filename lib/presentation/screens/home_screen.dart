import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VuelaEasy'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/vuelos'), // Navega a la pantalla de vuelos
              child: const Text('Ver vuelos disponibles', style: TextStyle(fontSize: 18),),
            )
          ],
        ),
      ),
    );
  }
}