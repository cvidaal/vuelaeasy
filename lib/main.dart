import 'package:flutter/material.dart';
import 'package:vuelaeasy/helpers/database.dart';
import 'package:vuelaeasy/presentation/screens/vuelos_screen.dart';

void main() async{
  await Database().instalacion();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: VuelosScreen(),
      );
  }
}
