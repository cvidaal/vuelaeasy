import 'dart:math';

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

  ComprarBilleteScreen(
      {super.key,
      required this.pasajerosCrud,
      required this.billetesCrud,
      this.vuelo});

  @override
  State<ComprarBilleteScreen> createState() => _ComprarBilleteScreenState();
}

class _ComprarBilleteScreenState extends State<ComprarBilleteScreen> {
  final _formKey = GlobalKey<FormState>(); // Llave para el formulario
  final List<String> opcionesClase = ['Turista', 'Ejecutiva', 'Primera clase'];
  final List<String> opcionesPago = ['Tarjeta', 'Efectivo', 'Paypal'];
  // Campos del formulario Pasajeros
  String nombre = '';
  String apellidos = '';
  String dni = '';
  String telefono = '';
  String direccion = '';

  // Campos del formulario Billetes
  //TODO: Falta fecha compra
  String claseServicio = 'Turista';
  String formaPago = 'Efectivo';
  double precio = double.parse((Random().nextDouble() * 1000).toStringAsFixed(2));
  

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
                initialValue: widget.vuelo?.idvuelo.toString(),
                decoration: const InputDecoration(labelText: 'ID Vuelo'),
                onChanged: (value) => widget.vuelo?.idvuelo = value as int?,
              ),
              TextFormField(
                initialValue: nombre,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) =>
                    value!.isEmpty ? 'Ingresa el nombre' : null,
                onChanged: (value) => nombre = value,
              ),
              TextFormField(
                initialValue: apellidos,
                decoration: const InputDecoration(labelText: 'Apellidos'),
                validator: (value) =>
                    value!.isEmpty ? 'Ingresa los apellidos' : null,
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
                validator: (value) =>
                    value!.isEmpty ? 'Ingresa el teléfono' : null,
                onChanged: (value) => telefono = value,
              ),
              TextFormField(
                initialValue: direccion,
                decoration: const InputDecoration(labelText: 'Dirección'),
                validator: (value) =>
                    value!.isEmpty ? 'Ingresa la dirección' : null,
                onChanged: (value) => direccion = value,
              ),
              DropdownButtonFormField<String>( // Desplegable
                value: claseServicio,
                decoration: const InputDecoration(labelText: 'Clase'),
                items: opcionesClase.map((String opcion){
                  return DropdownMenuItem(
                    value: opcion,
                    child: Text(opcion),
                  );
                },).toList(),
                onChanged: (value){
                  setState(() {
                    claseServicio = value!;
                  });
                }
                ),
              DropdownButtonFormField<String>(
                value: formaPago,
                decoration: const InputDecoration(labelText: 'Forma de pago: '),
                items: opcionesPago.map((String opcion){
                  return DropdownMenuItem(
                    value: opcion,
                    child: Text(opcion),
                  );
                },).toList(), 
                onChanged: (value){
                  setState(() {
                    formaPago = value!; // Forma de pag es igual a la opción seleccionada.
                  });
                }
                ),
              TextFormField(
                initialValue: precio.toString(),
                decoration: const InputDecoration(labelText: 'Precio'),
                validator: (value) =>
                    value!.isEmpty ? 'Ingresa el precio' : null,
                onChanged: (value) => precio = double.parse(value) ?? 0.0,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  _guardarBillete(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Billete comprado')));
                },
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
      final idPasajeroGenerado =
          await widget.pasajerosCrud.crearPasajero(pasajero);

      // Crear el billete
      final billete = Billete(
        idvuelo: widget.vuelo?.idvuelo, // Usamos el id del vuelo guardado
        idpasajero: idPasajeroGenerado, // Usamos el id del pasajero generado
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
