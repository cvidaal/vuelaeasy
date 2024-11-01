class Pasajero {
  int? idpasajero;
  String? nombre;
  String? apellidos;
  String? dni;
  String? telefono;
  String? direccion;

  Pasajero({
    this.idpasajero,
    this.nombre,
    this.apellidos,
    this.dni,
    this.telefono,
    this.direccion
  });

  Pasajero.fromJson(Map<String, dynamic> json){
    idpasajero = json['idpasajero'];
    nombre = json['nombre'];
    apellidos = json['apellidos'];
    dni = json['dni'];
    telefono = json['telefono'];
    direccion = json['direccion'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = {};
    data['idpasajero'] = idpasajero;
    data['nombre'] = nombre;
    data['apellidos'] = apellidos;
    data['dni'] = dni;
    data['telefono'] = telefono;
    data['direccion'] = direccion;
    return data;
  }

  
}