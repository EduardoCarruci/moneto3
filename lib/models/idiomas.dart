class Idioma {
  int id;
  int idIdioma;
  String descripcion;
  String nombreCampo;
  String equivalencia;
  //List TipoCliente;

  Idioma({
    this.id,
    this.idIdioma,
    this.descripcion,
    this.nombreCampo,
    this.equivalencia,
    
  });

  //create
  convertMap(String descripcion, String nombreCampo, String equivalencia) {
    Map data = {
      "descripcion": descripcion,
      "nombreCampo": nombreCampo,
      "equivalencia": equivalencia,
    };
    return data;
  }

  //modificar
  convertMapOP(String idIdioma, String descripcion, String nombreCampo,String equivalencia) {
    Map data = {
      "idIdioma": idIdioma,
      "descripcion": descripcion,
      "nombreCampo": nombreCampo,
      "equivalencia": equivalencia,
    };
    return data;
  }

//LEER
  Idioma.fromJson(Map json)
      : idIdioma = json['idIdioma'],
        descripcion = json['descripcion'],
        nombreCampo = json['nombreCampo'],
        equivalencia = json['equivalencia'];
}
