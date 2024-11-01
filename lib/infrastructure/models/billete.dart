
class Billete {
  int? idbillete;
  int? idvuelo;
  int? idpasajero;
  DateTime? fechaCompra;
  String? claseServicio;
  String? formaPago;
  double? precio;

  Billete({
    this.idbillete, 
    this.idpasajero,
    this.idvuelo,
    this.fechaCompra, 
    this.claseServicio, 
    this.formaPago, 
    this.precio
    });

  Billete.fromJson(Map<String, dynamic> json){
    idbillete = json['idbillete'];
    idvuelo = json['idvuelo'];
    idpasajero = json['idpasajero'];	
    fechaCompra = DateTime.tryParse(json['fecha_compra']);
    claseServicio = json['clase_servicio'];
    formaPago = json['forma_pago'];
    precio = json['precio']?.toDouble();
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idbillete'] = idbillete;
    data['idvuelo'] = idvuelo;
    data['idpasajero'] = idpasajero;
    data['fecha_compra'] = fechaCompra!.toIso8601String();
    data['clase_servicio'] = claseServicio;
    data['forma_pago'] = formaPago;
    data['precio'] = precio;
    return data;
  }
}