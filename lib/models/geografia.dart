class Geografia {
  String id;
  int idPais;
  String pais;
  int idDepartamento;
  String departamento;
  int idMunicipio;
  String municipio;
  int idLocalidad;
  String localidad;

  Geografia({
    this.id,
    this.idPais,
    this.pais,
    this.idDepartamento,
    this.departamento,
    this.idMunicipio,
    this.municipio,
    this.idLocalidad,
    this.localidad,
  });

  //create
  convertMap(String descripcion) {
    Map data = {
      "descripcion": descripcion,
    };
    return data;
  }

  //modificar
  convertMapOP(String idPais, String descripcion) {
    Map data = {
      "idPais": idPais,
      "descripcion": descripcion,
    };
    return data;
  }

  Geografia.fromJson(Map json)
      : id = json['id'],
        idPais = json['idPais'],
        pais = json['Pais'],
        idDepartamento = json['idDepartamento'],
        departamento = json['Departamento'],
        idMunicipio = json['idMunicipio'],
        municipio = json['Municipio'],
        idLocalidad = json['idLocalidad'],
        localidad = json['Localidad'];
}
