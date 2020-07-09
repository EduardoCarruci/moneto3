import 'dart:convert';

class Localidad {
  String id;
  int idPais;
  dynamic pais;
  int idDepartamento;
  dynamic departamento;
  int idMunicipio;
  dynamic municipio;
  int idLocalidad;
  String localidad;

  Localidad({
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

  factory Localidad.fromJson(String str) => Localidad.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Localidad.fromMap(Map<String, dynamic> json) => Localidad(
        id: json["\u0024id"],
        idPais: json["idPais"],
        pais: json["Pais"],
        idDepartamento: json["idDepartamento"],
        departamento: json["Departamento"],
        idMunicipio: json["idMunicipio"],
        municipio: json["Municipio"],
        idLocalidad: json["idLocalidad"],
        localidad: json["Localidad"],
      );

  Map<String, dynamic> toMap() => {
        "\u0024id": id,
        "idPais": idPais,
        "Pais": pais,
        "idDepartamento": idDepartamento,
        "Departamento": departamento,
        "idMunicipio": idMunicipio,
        "Municipio": municipio,
        "idLocalidad": idLocalidad,
        "Localidad": localidad,
      };
}
