class TipoCliente {
  int id;
  int idTipoCliente;
  String codigo;
  String nombre;
  int idIdioma;
  String idioma;
  int idColorAPP;
  String ColorAPP;
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
    this.idColorAPP,
    this.ColorAPP,
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
        "idColorAPP": idColorAPP,
        "ColorAPP": ColorAPP,
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
        idColorAPP = json['idColorAPP'],
        ColorAPP = json['ColorAPP'],
        idMetadata = json['idMetadata'],
        idCabeceraMetadata = json['idCabeceraMetadata'],
        CabeceraMetadata = json['CabeceraMetadata'];
}
