class Estrato {
  int id;
  int idEstrato;
  String codigo;
  String nombre;

  Estrato({
    this.id,
    this.idEstrato,
    this.codigo,
    this.nombre,
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
  convertMapOP(
    String idEstrato,
    String codigo,
    String nombre,
  ) {
    Map data = {
      "idEstrato": idEstrato,
      "codigo": codigo,
      "nombre": nombre,
    };
    return data;
  }

//LEER
  Estrato.fromJson(Map json)
      : idEstrato = json['idEstrato'],
        codigo = json['codigo'],
        // nombreCampo = json['nombreCampo'],
        nombre = json['nombre'];
}
