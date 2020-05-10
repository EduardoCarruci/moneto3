class TipoAlarma {
  int id;
  int idTipoAlarma;
  String nombre;
  String codigo;

  TipoAlarma({
    this.id,
    this.idTipoAlarma,
    this.nombre,
    this.codigo,
  });

  //create
  convertMap(String codigo, String nombre) {
    Map data = {
      "codigo": codigo,
      "nombre": nombre,
    };
    return data;
  }

  //modificar
  convertMapOP(String idTipoAlarma, String codigo, String nombre) {
    Map data = {
      "idTipoAlarma": idTipoAlarma,
      "codigo": codigo,
      "nombre": nombre,
    };
    return data;
  }

//LEER
  TipoAlarma.fromJson(Map json)
      : idTipoAlarma = json['idTipoAlarma'],
        codigo = json['codigo'],
        nombre = json['nombre'];
}
