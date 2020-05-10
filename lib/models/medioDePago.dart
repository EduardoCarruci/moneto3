class MedioDePago {
  //String $id;
  int idTipoMedioPago;
  String descripcion;
  //String MedioPago;

  MedioDePago({
   // this.$id,
    this.idTipoMedioPago,
    this.descripcion,
   // this.MedioPago,
  });
  //create
  convertMap(String descripcion) {
    Map data = {
      "descripcion": descripcion,
    };
    return data;
  }
  //modificar
  convertMapOP(String idTipoMedioPago, String descripcion) {
    Map data = {
      "idTipoMedioPago": idTipoMedioPago,
      "descripcion": descripcion,
    };
    return data;
  }

  MedioDePago.fromJson(Map json)
      : idTipoMedioPago = json['idTipoMedioPago'],
        descripcion = json['descripcion'];
}
