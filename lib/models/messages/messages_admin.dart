import 'dart:convert';

class MessagesAdm {
  String id;
  int idmensaje;
  int idusuario;
  String fechaCreacion;
  int activo;
  String titulo;
  String mensajeInicial;

  MessagesAdm({
    this.id,
    this.idmensaje,
    this.idusuario,
    this.fechaCreacion,
    this.activo,
    this.titulo,
    this.mensajeInicial,
  });

  MessagesAdm.fromJson(Map json)
      : id = json['id'],
        idmensaje = json['idmensaje'],
        idusuario = json['idusuario'],
        fechaCreacion = json['fechaCreacion'],
        activo = json['activo'],
        titulo = json['titulo'],
        mensajeInicial = json['mensajeInicial'];
}
