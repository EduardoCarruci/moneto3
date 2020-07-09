class TipoCliente {
  int id;
  int idTipoCliente;
  String codigo;
  String nombre;
  int idIdioma;
  String idioma;

  int idColorApp;
  String colorApp;
  String colorHexaApp;

  int idMetadata;
  String idUsuario;
  int idCabeceraMetadata;
  String CabeceraMetadata;

  TipoCliente({
    this.id,
    this.idTipoCliente,
    this.codigo,
    this.nombre,
    this.idIdioma,
    this.idioma,
    this.idColorApp,
    this.colorApp,
    this.colorHexaApp,
    this.idMetadata,
    this.idUsuario,
    this.idCabeceraMetadata,
    this.CabeceraMetadata,
  });
  Map<String, dynamic> toMap() => {
        "\u0024id": id,
        "idTipoCliente": idTipoCliente,
        "codigo": codigo,
        "nombre": nombre,
        "idIdioma": idIdioma,
        "idioma": idioma,
        "idColorAPP": idColorApp,
        "ColorAPP": colorApp,
        "ColorHexaAPP": colorHexaApp,
        "idCabeceraMetadata": idCabeceraMetadata,
        "CabeceraMetadata": CabeceraMetadata,
      };

  //create
  convertMap(String codigo, String nombre, String idIdioma, String idColorAPP,
      String idCabeceraMetadata) {
    Map data = {
      "codigo": codigo,
      "nombre": nombre,
      "idIdioma": idIdioma,
      "idColorAPP": idColorAPP,
      "idCabeceraMetadata": idCabeceraMetadata,
    };
    return data;
  }

  convertMapOP(int idTipoCliente, String codigo, String nombre, String idIdioma,
      String idColorAPP, String idCabeceraMetadata) {
    Map data = {
      "idTipoCliente": idTipoCliente,
      "codigo": codigo,
      "nombre": nombre,
      "idIdioma": idIdioma,
      "idColorAPP": idColorAPP,
      "idCabeceraMetadata": idCabeceraMetadata,
    };
    print(data);
    return data;
  }

//LEER

//"$id":"1","idTipoCliente":2,"codigo":"asde1","nombre":"Proveedor1k","idIdioma":1,"idColorAPP":null,"idCabeceraMetadata":2
  TipoCliente.fromJson(Map json)
      : id = json['id'],
        idTipoCliente = json['idTipoCliente'],
        codigo = json['codigo'],
        nombre = json['nombre'],
        idIdioma = json['idIdioma'],
        idioma = json['idioma'],
        idColorApp = json['idColorAPP'],
        colorApp = json['ColorAPP'],
        colorHexaApp = json['ColorHexaAPP'],
        idMetadata = json['idMetadata'],
        idCabeceraMetadata = json['idCabeceraMetadata'],
        CabeceraMetadata = json['CabeceraMetadata'];
}
