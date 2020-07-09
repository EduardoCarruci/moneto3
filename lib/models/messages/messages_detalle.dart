import 'dart:convert';

class MessageDetalle {
  String id;
  int idchat;
  int idmensaje;
  int idusuario;
  String mensaje;
  String nombre;

  MessageDetalle({
    this.id,
    this.idmensaje,
    this.idusuario,
    this.mensaje,
    this.nombre,

  });

  MessageDetalle.fromJson(Map json)
      : id = json['id'],
        idmensaje = json['idmensaje'],
        idusuario = json['idusuario'],
        mensaje = json['mensaje'],
        nombre = json['Nombre'];
}
