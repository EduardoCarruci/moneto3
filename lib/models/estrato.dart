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


  Estrato.fromJson(Map json)
      : idEstrato = json['idEstrato'],
        codigo = json['codigo'],
        nombre = json['nombre'];
}
