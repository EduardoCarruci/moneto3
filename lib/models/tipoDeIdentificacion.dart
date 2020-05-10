class TipoIdentificacion {
  String id;
  int idTipoIdentificacion;
  String nombre;
  String codigo;


  TipoIdentificacion({
    this.id,
    this.idTipoIdentificacion,
    this.nombre,
    this.codigo,
  });

  //create
  converCreate( String codigo, String nombre) {
    Map data = {
      
      "codigo": codigo,
      "nombre": nombre,
    };
    return data;
  }

  // operaciones
  convertMapOP(String idTipoIdentificacion,String codigo, String nombre) {
    Map data = {
      "idTipoIdentificacion": idTipoIdentificacion,
      "codigo": codigo,
      "nombre": nombre,
    };
    return data;
  }

//LEER
//{"$id":"1","idTipoIdentificacion":1,"codigo":"ASDW45","nombre":"Identificacion 1","Tercero":null,"Usuario":null}
  TipoIdentificacion.fromJson(Map json)
      : id = json['id'],
        idTipoIdentificacion = json['idTipoIdentificacion'],
        nombre = json['nombre'],
        codigo = json['codigo'];
}
