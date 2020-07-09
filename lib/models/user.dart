import 'dart:convert';

import 'package:moneto2/models/tipoCliente.dart';

class User {
  int id;
  String nombre;
  String Token;
  String idCabeceraMetadata;
  int idUsuario;
  String usuario;
  String password;
  String mail;
  String apellido;
  String telefono;
  String celular;
  DateTime vigenciaPasswordDesde;
  DateTime vigenciaPasswordHasta;
  int activo;
  int idGenero;
  dynamic tipoIdentificacion;
  TipoCliente tipoCliente;
  List<Permiso> permisos;
  

  User({
    this.id,
    this.idUsuario,
    this.usuario,
    this.password,
    this.mail,
    this.nombre,
    this.apellido,
    this.telefono,
    this.celular,
    this.vigenciaPasswordDesde,
    this.vigenciaPasswordHasta,
    this.activo,
    this.idGenero,
    this.tipoIdentificacion,
    this.tipoCliente,
    this.permisos,
  });

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        // id: json["\u0024id"],
        idUsuario: json["idUsuario"],
        usuario: json["usuario"],
        password: json["password"],
        mail: json["mail"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        telefono: json["telefono"],
        celular: json["celular"],
        vigenciaPasswordDesde: DateTime.parse(json["vigenciaPasswordDesde"]),
        vigenciaPasswordHasta: DateTime.parse(json["vigenciaPasswordHasta"]),
        activo: json["activo"],
        idGenero: json["idGenero"],
        tipoIdentificacion: json["TipoIdentificacion"],
        tipoCliente: TipoCliente.fromJson(json["TipoCliente"]),
        permisos:
            List<Permiso>.from(json["permisos"].map((x) => Permiso.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        // "\u0024id": id,
        "idUsuario": idUsuario,
        "usuario": usuario,
        "password": password,
        "mail": mail,
        "nombre": nombre,
        "apellido": apellido,
        "telefono": telefono,
        "celular": celular,
        "vigenciaPasswordDesde": vigenciaPasswordDesde.toIso8601String(),
        "vigenciaPasswordHasta": vigenciaPasswordHasta.toIso8601String(),
        "activo": activo,
        "idGenero": idGenero,
        "TipoIdentificacion": tipoIdentificacion,
        "TipoCliente": tipoCliente.toMap(),
        "permisos": List<dynamic>.from(permisos.map((x) => x.toMap())),
      };
}

class Permiso {
  int idMenu;
  int idhabilitado;

  Permiso({
    this.idMenu,
    this.idhabilitado,
  });

  factory Permiso.fromJson(String str) => Permiso.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Permiso.fromMap(Map<String, dynamic> json) => Permiso(
        idMenu: json["idMenu"],
        idhabilitado: json["idhabilitado"],
      );

  Map<String, dynamic> toMap() => {
        "idMenu": idMenu,
        "idhabilitado": idhabilitado,
      };
      
}
