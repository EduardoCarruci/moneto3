class TipoMedioPago {
  String id;
  int idTipoMedioPago;
  String descripcion;

  TipoMedioPago({
    this.id,
    this.idTipoMedioPago,
    this.descripcion,
  });

  //create
/*   convertMap(int IdTipoConcepto, String Concepto) {
    Map data = {
      "IdTipoConcepto": IdTipoConcepto,
      "Concepto": Concepto,
    };
    return data;
  } */

//LEER
  TipoMedioPago.fromJson(Map json)
      : idTipoMedioPago = json['idTipoMedioPago'],
        descripcion = json['descripcion'];
}
