class EstadoCivil {
  int id;
  int idEstadoCivil;
  String nombre;
  String codigo;

  EstadoCivil({
    this.id,
    this.idEstadoCivil,
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
  convertMapOP(String idEstadoCivil, String codigo, String nombre) {
    Map data = {
      "idEstadoCivil": idEstadoCivil,
      "codigo": codigo,
      "nombre": nombre,
    };
    return data;
  }

//LEER
  EstadoCivil.fromJson(Map json)
      : idEstadoCivil = json['idEstadoCivil'],
        codigo = json['codigo'],
        nombre = json['nombre'];
}
