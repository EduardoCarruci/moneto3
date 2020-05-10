//"$id":"1","idTipoCliente":2,"codigo":"asde1","nombre":"Proveedor1k","idIdioma":1,"idColoresLookFeel":1,"idMetadata":1

class TipoCliente {
  String id;
  int idTipoCliente;
  String codigo;
  String nombre;
  int idIdioma;
  int idColorApp;
  int idMetadata;
  String idUsuario;
  int idCabeceraMetadata;

  TipoCliente({
    this.id,
    this.idMetadata,
    this.idTipoCliente,
    this.codigo,
    this.nombre,
    this.idIdioma,
    this.idColorApp,
    this.idUsuario,
    this.idCabeceraMetadata
  });

  //create

  /*
  
  "codigo" : "aswd",
"nombre" : "Proveedor 1",
"idIdioma" : "1",
"idColoresLookFeel" : "1",
"idMetadata" : "1"
*/
  convertMap(String codigo, String nombre, String idIdioma,
      String idColorApp, String idUsuario) {
    Map data = {
      "codigo": codigo,
      "nombre": nombre,
      "idIdioma": idIdioma,
      "idColorApp": idColorApp,
      "idUsuario": idUsuario,
    };
    return data;
  }

  //modificar
/*   convertMapOP(int idMetadata, String codigo, String nombreMetadata,
      String nombreCampo, String nombreEquivalencia) {
    Map data = {
      "idMetadata": idMetadata,
      "codigo": codigo,
      "nombreMetadata": nombreMetadata,
      "nombreCampo": nombreCampo,
      "nombreEquivalencia": nombreEquivalencia,
    };
    return data;
  }
 */
//LEER

//{"$id":"1","idTipoCliente":2,"codigo":"asde1","nombre":"Proveedor1k","idIdioma":1,"idColoresLookFeel":1,"idMetadata":1}
  TipoCliente.fromJson(Map json)
      : id = json['id'],
        idTipoCliente = json['idTipoCliente'],
        codigo = json['codigo'],
        nombre = json['nombre'],
        idIdioma = json['idIdioma'],
        idUsuario = json['idUsuario'],
        idCabeceraMetadata = json['idCabeceraMetadata']
        ;
}
