import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vuelaeasy/config/helpers/database/vuelos_crud.dart';
import 'package:vuelaeasy/infrastructure/models/vuelo.dart';

class AgregarVueloScreen extends StatefulWidget {
  final VuelosCrud vuelosCrud; // Pide la instancia de la clase VuelosCrud para acceder a los métodos
  final Vuelo? vuelo; // Pide la instancia de la clase Vuelo para editar un vuelo
  
  const AgregarVueloScreen({super.key, required this.vuelosCrud, this.vuelo});

  @override
  State<AgregarVueloScreen> createState() => _AgregarVueloScreenState();
}

class _AgregarVueloScreenState extends State<AgregarVueloScreen> {
  final _formKey = GlobalKey<FormState>(); // Llave para el formulario de vuelo
  late int numVuelo;
  late String origen;
  late String destino;
  late String fecha;
  late String horaSalida;
  late String horaLlegada;
  late String modeloAvion;
  late int totalAsientos;

// initState() se llama cuando el widget es insertado en el árbol de widgets
  @override
  void initState() { 
    if(widget.vuelo != null){
      // Si se recibe un vuelo, se asignan los valores a las variables
      numVuelo = widget.vuelo!.numVuelo!;
      origen = widget.vuelo!.origen!;
      destino = widget.vuelo!.destino!;
      fecha = widget.vuelo!.fecha!;
      horaSalida = widget.vuelo!.horaSalida!;
      horaLlegada = widget.vuelo!.horaLlegada!;
      modeloAvion = widget.vuelo!.modeloAvion!;
      totalAsientos = widget.vuelo!.totalAsientos!;
    } else{
      // Si no se recibe un vuelo, se asignan valores por defecto
      numVuelo = Random().nextInt(10000);
      origen = '';
      destino = '';
      fecha = '';
      horaSalida = '';
      horaLlegada = '';
      modeloAvion = '';
      totalAsientos = 0;
    }
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.vuelo == null ? 'Agregar vuelo' : 'Editar vuelo'), // Cambia el título si se recibe un vuelo
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: numVuelo.toString(),
                decoration: const InputDecoration(labelText: 'Número de vuelo'),
                validator: (value) => value!.isEmpty ? 'Ingresa el número de vuelo' : null,
                onChanged: (value) => numVuelo,
              ),
              TextFormField(
                initialValue: origen,
                decoration: const InputDecoration(labelText: 'Origen'),
                validator: (value) => value!.isEmpty ? 'Ingresa el origen' : null,
                onChanged: (value) => origen = value,
              ),
              TextFormField(
                initialValue: destino,
                decoration: const InputDecoration(labelText: 'Destino'),
                validator: (value) => value!.isEmpty ? 'Ingresa el destino' : null,
                onChanged: (value) => destino = value,
              ),
              TextFormField(
                initialValue: fecha.toString(),
                decoration: const InputDecoration(labelText: 'Fecha'),
                validator:(value) => value!.isEmpty ? 'Ingresa la fecha' : null,
                onChanged: (value) => fecha = value,
              ),
              TextFormField(
                initialValue: horaSalida,
                decoration: const InputDecoration(labelText: 'Hora de salida'),
                validator: (value) => value!.isEmpty ? 'Ingresa la hora de salida' : null,
                onChanged: (value) => horaSalida = value,
              ),
              TextFormField(
                initialValue: horaLlegada,
                decoration: const InputDecoration(labelText: 'Hora de llegada'),
                validator: (value) => value!.isEmpty ? 'Ingresa la hora de llegada' : null,
                onChanged: (value) => horaLlegada = value,
              ),
              TextFormField(
                initialValue: modeloAvion,
                decoration: const InputDecoration(labelText: 'Modelo de avión'),
                validator: (value) => value!.isEmpty ? 'Ingresa el modelo de avión' : null,
                onChanged: (value) => modeloAvion = value,
              ),
              TextFormField(
                initialValue: totalAsientos.toString(),
                decoration: const InputDecoration(labelText: 'Total de asientos'),
                validator: (value) => value!.isEmpty ? 'Ingresa el total de asientos' : null,
                onChanged: (value) => totalAsientos = int.parse(value) ?? 40,
              ),
              ElevatedButton(
                onPressed: () async{
                  if(_formKey.currentState!.validate()){
                    // Si el formulario es válido
                    if(widget.vuelo == null){
                      // Si no se recibe un vuelo, se crea uno nuevo
                      await widget.vuelosCrud.crearVuelos(Vuelo(
                        // Se crea un nuevo vuelo con los valores ingresados
                        numVuelo: numVuelo,
                        origen: origen,
                        destino: destino,
                        fecha: fecha,
                        horaSalida: horaSalida,
                        horaLlegada: horaLlegada,
                        modeloAvion: modeloAvion,
                        totalAsientos: totalAsientos
                      ));
                    } else{
                      await widget.vuelosCrud.actualizarVuelo(Vuelo(
                        // Si se recibe un vuelo, se actualiza con los nuevos valores
                        idvuelo: widget.vuelo!.idvuelo,
                        numVuelo: numVuelo,
                        origen: origen,
                        destino: destino,
                        fecha: fecha,
                        horaSalida: horaSalida,
                        horaLlegada: horaLlegada,
                        modeloAvion: modeloAvion,
                        totalAsientos: totalAsientos
                      ));
                    }
                    Navigator.pop(context); // Regresa a la pantalla anterior
                  }
                }, 
                child: Text(widget.vuelo == null ? 'Agregar vuelo' : 'Editar vuelo'))
            ],
          )
        ),
      ),
    );
  }
}