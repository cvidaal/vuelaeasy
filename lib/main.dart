import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vuelaeasy/config/helpers/database/database.dart';
import 'package:vuelaeasy/config/helpers/database/vuelos_crud.dart';
import 'package:vuelaeasy/config/theme/app_theme.dart';
import 'package:vuelaeasy/presentation/screens/vuelos_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized(); // <-- Necesario para que la aplicación se inicie correctamente
  await Database().instalacion();

  final conn = await Database().conexion();
  final vuelosCrud = VuelosCrud(conn);

  runApp(ProviderScope(child: MainApp(vuelosCrud: vuelosCrud,)));
}

class MainApp extends StatelessWidget {
  final VuelosCrud vuelosCrud;
  const MainApp({super.key, required this.vuelosCrud});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/vuelos': (context) => VuelosScreen(vuelosCrud: vuelosCrud)
      },
      theme: AppTheme().getTheme(),
      debugShowCheckedModeBanner: false,
      home: VuelosScreen(vuelosCrud: vuelosCrud),
      );
  }
}
