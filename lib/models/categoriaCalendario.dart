class CategoriaCalendario {
  String id;
  int idCategoriaCalendario;
  String codigo;
  String nombre;
  
  CategoriaCalendario({
    this.id,
    this.idCategoriaCalendario,
    this.codigo,
    this.nombre,
  });

  //create
  converCreate(String codigo, String nombre) {
    Map data = {
      "codigo": codigo,
      "nombre": nombre,
    };
    return data;
  }

  // operaciones
  convertMapOP(String idCategoriaCalendario, String codigo, String nombre) {
    Map data = {
      "idCategoriaCalendario": idCategoriaCalendario,
      "codigo": codigo,
      "nombre": nombre,
    };
    return data;
  }

//LEER
  CategoriaCalendario.fromJson(Map json)
      : id = json['id'],
        idCategoriaCalendario = json['idCategoriaCalendario'],
        nombre = json['nombre'],
        codigo = json['codigo'];
      
}
