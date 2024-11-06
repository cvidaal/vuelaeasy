import 'package:flutter/material.dart';
import 'package:vuelaeasy/config/helpers/database/billetes_crud.dart';
import 'package:vuelaeasy/config/helpers/database/pasajeros_crud.dart';
import 'package:vuelaeasy/infrastructure/models/billete.dart';
import 'package:vuelaeasy/infrastructure/models/pasajero.dart';
import 'package:vuelaeasy/infrastructure/models/vuelo.dart';

class ComprarBilleteScreen extends StatefulWidget {
  final PasajerosCrud pasajerosCrud; // Instancia de PasajerosCrud
  final BilletesCrud billetesCrud;
  final Vuelo? vuelo; // Instancia de billetesCrud

  const ComprarBilleteScreen({
    super.key, 
    required this.pasajerosCrud,
     required this.billetesCrud, 
     this.vuelo
    });

  @override
  State<ComprarBilleteScreen> createState() => _ComprarBilleteScreenState();
}

class _ComprarBilleteScreenState extends State<ComprarBilleteScreen> {
  final _formKey = GlobalKey<FormState>(); // Llave para el formulario
  // Campos del formulario Pasajeros
  String nombre = '';
  String apellidos = '';
  String dni = '';
  String telefono = '';
  String direccion = '';

  // Campos del formulario Billetes
  //TODO: Falta fecha compra
  String claseServicio = '';
  String formaPago = '';
  double precio = 0.0;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comprar billete'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Definida anteriormente
          child: Column(
            children: [
              TextFormField(
                initialValue: nombre,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) => value!.isEmpty ? 'Ingresa el nombre' : null,
                onChanged: (value) => nombre = value,
              ),
              TextFormField(
                initialValue: apellidos,
                decoration: const InputDecoration(labelText: 'Apellidos'),
                validator: (value) => value!.isEmpty ? 'Ingresa los apellidos' : null,
                onChanged: (value) => apellidos = value,
              ),
              TextFormField(
                initialValue: dni,
                decoration: const InputDecoration(labelText: 'DNI'),
                validator: (value) => value!.isEmpty ? 'Ingresa el DNI' : null,
                onChanged: (value) => dni = value,
              ),
              TextFormField(
                initialValue: telefono,
                decoration: const InputDecoration(labelText: 'Teléfono'),
                validator: (value) => value!.isEmpty ? 'Ingresa el teléfono' : null,
                onChanged: (value) => telefono = value,
              ),
              TextFormField(
                initialValue: direccion,
                decoration: const InputDecoration(labelText: 'Dirección'),
                validator: (value) => value!.isEmpty ? 'Ingresa la dirección' : null,
                onChanged: (value) => direccion = value,
              ),
              TextFormField(
                initialValue: claseServicio,
                decoration: const InputDecoration(labelText: 'Clase de servicio'),
                validator: (value) => value!.isEmpty ? 'Ingresa la clase de servicio' : null,
                onChanged: (value) => claseServicio = value,
              ),
              TextFormField(
                initialValue: formaPago,
                decoration: const InputDecoration(labelText: 'Forma de pago'),
                validator: (value) => value!.isEmpty ? 'Ingresa la forma de pago' : null,
                onChanged: (value) => formaPago = value,
              ),
              TextFormField(
                initialValue: precio.toString(),
                decoration: const InputDecoration(labelText: 'Precio'),
                validator: (value) => value!.isEmpty ? 'Ingresa el precio' : null,
                onChanged: (value) => precio = double.parse(value) ?? 0.0,
              ),
              const SizedBox(height: 20,),
              
              ElevatedButton(
                onPressed: () => _guardarBillete(context), 
              child: Text('Comprar billete'),
              ),
            ],
          ),
        ),
      ),
    );
  }
    // Función para guardar billete y pasajero
  Future<void> _guardarBillete(BuildContext context) async {

    if (_formKey.currentState?.validate() ?? false) {
      // Crear un nuevo pasajero
      final pasajero = Pasajero(
        nombre: nombre,
        apellidos: apellidos,
        dni: dni,
        telefono: telefono,
        direccion: direccion,
      );

      // Guardar el pasajero en la base de datos
      await widget.pasajerosCrud.crearPasajero(pasajero);

      // Crear el billete
      final billete = Billete(
        idpasajero: pasajero.idpasajero, // Usamos el id del pasajero guardado
        fechaCompra: DateTime.now(),
        claseServicio: claseServicio,
        formaPago: formaPago,
        precio: precio,
      );

      // Guardar el billete en la base de datos
      await widget.billetesCrud.crearBillete(billete);
  }
}
}

// Función para guardar el billete y pasajero