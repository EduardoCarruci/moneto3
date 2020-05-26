class CabeceraMetadata {
  String id;
  int idCabeceraMetadata;
  String nombre;
  String codigo;
  String template;

  CabeceraMetadata({
    this.id,
    this.idCabeceraMetadata,
    this.codigo,
    this.nombre,
    this.template,
  });

  //create
  /*  converCreate(String nombre) {
    Map data = {
      "nombre": nombre,
    };
    return data;
  } */

  // operaciones
  /*  convertMapOP(String idCategoriaCalendario, String nombre) {
    Map data = {
      "idCategoriaCalendario": idCategoriaCalendario,
      "nombre": nombre,
    };
    return data;
  } */

//LEER
  CabeceraMetadata.fromJson(Map json)
      : id = json['id'],
        idCabeceraMetadata = json['idCabeceraMetadata'],
        codigo = json['codigo'],
        nombre = json['nombre'],
        template = json['template'];
}
