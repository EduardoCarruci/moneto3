class Franquicia {
  int id;
  int idFranquicia;
  String codigo;
  String descripcion;

  Franquicia({
    this.id,
    this.idFranquicia,
    this.codigo,
    this.descripcion,
  });

  //create
  convertMap(String codigo, String descripcion) {
    Map data = {
      "codigo": codigo,
      "descripcion": descripcion,
    };
    return data;
  }

  //modificar
  convertMapOP(
    String idFranquicia,
    String codigo,
    String descripcion,
  ) {
    Map data = {
      "idFranquicia": idFranquicia,
      "codigo": codigo,
      "descripcion": descripcion,
    };
    return data;
  }

//LEER
  Franquicia.fromJson(Map json)
      : idFranquicia = json['idFranquicia'],
        codigo = json['codigo'],
        // nombreCampo = json['nombreCampo'],
        descripcion = json['descripcion'];
}
