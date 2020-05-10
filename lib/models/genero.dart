class Genero {
  int id;
  int idGenero;
  String nombre;
  String codigo;

  Genero({
    this.id,
    this.idGenero,
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
  convertMapOP(String idGenero, String codigo, String nombre) {
    Map data = {
      "idGenero": idGenero,
      "codigo": codigo,
      "nombre": nombre,
    };
    return data;
  }

//LEER
  Genero.fromJson(Map json)
      : idGenero = json['idGenero'],
      codigo = json['codigo'],
        nombre = json['nombre'];
}
