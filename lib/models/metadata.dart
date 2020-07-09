class Metadata {
  int id;
  int idCabeceraMetadata;
  String codigo;
  String nombre;
 
  dynamic template;

  Metadata({
    this.id,
    this.idCabeceraMetadata,
    this.codigo,
    this.nombre,
   
    this.template,
  });

  //create
  convertMap(String codigo, String nombreMetadata) {
    Map data = {
      "codigo": codigo,
      "nombre": nombreMetadata,
     
    };
    return data;
  }

  //modificar
  convertMapOP(int idCabeceraMetadata,String codigo,String nombre) {
    Map data = {
      "idCabeceraMetadata": idCabeceraMetadata,
      "codigo": codigo,
      "nombre": nombre,
     
    };
    return data;
  }

//LEER
  Metadata.fromJson(Map json)
      : id = json['id'],
        idCabeceraMetadata = json['idCabeceraMetadata'],
        codigo = json['codigo'],
        nombre = json['nombre'],
        
        template = json['template'];
}
