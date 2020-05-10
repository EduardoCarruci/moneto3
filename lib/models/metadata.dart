class Metadata {
  int id;
  int idMetadata;
  String codigo;
  String nombreMetadata;
  String nombreCampo;
  String nombreEquivalencia;

  Metadata({
    this.id,
    this.idMetadata,
    this.codigo,
    this.nombreMetadata,
    this.nombreCampo,
    this.nombreEquivalencia,
  });

  //create
  convertMap(String codigo, String nombreMetadata, String nombreCampo,
      String nombreEquivalencia) {
    Map data = {
      "codigo": codigo,
      "nombreMetadata": nombreMetadata,
      "nombreCampo": nombreCampo,
      "nombreEquivalencia": nombreEquivalencia,
    };
    return data;
  }

  //modificar
  convertMapOP(int idMetadata, String codigo, String nombreMetadata,
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

//LEER
  Metadata.fromJson(Map json)
      : id = json['id'],
        idMetadata = json['idMetadata'],
        codigo = json['codigo'],
        nombreMetadata = json['nombreMetadata'],
        nombreCampo = json['nombreCampo'],
        nombreEquivalencia = json['nombreEquivalencia'];
}
