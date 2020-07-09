import 'dart:convert';

class MessagesUser {
  String id;
  int idmensaje;
  int idusuario;
  String fecha_creacion;
  int activo;
  String titulo;
  String mensajeInicial;

  MessagesUser({
    this.id,
    this.idmensaje,
    this.idusuario,
    this.fecha_creacion,
    this.activo,
    this.titulo,
    this.mensajeInicial,
  });

  MessagesUser.fromJson(Map json)
      : id = json['id'],
        idmensaje = json['idmensaje'],
        idusuario = json['idusuario'],
        fecha_creacion = json['fecha_creacion'],
        activo = json['activo'],
        titulo = json['titulo'],
        mensajeInicial = json['mensajeInicial'];
}
