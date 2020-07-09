import 'dart:convert';

class Departamento {
  String id;
  int idPais;
  dynamic pais;
  int idDepartamento;
  String departamento;
  int idMunicipio;
  dynamic municipio;
  int idLocalidad;
  dynamic localidad;

  Departamento({
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

  factory Departamento.fromJson(String str) =>
      Departamento.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Departamento.fromMap(Map<String, dynamic> json) => Departamento(
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
