class MessageUser {
  String id;
  int idmensaje;
  int idusuario;
  String fecha_creacion;
  int activo;
  String titulo;
  String mensaje_inicial;
  String mensaje;

  MessageUser({
    this.id,
    this.idmensaje,
    this.idusuario,
    this.fecha_creacion,
    this.activo,
    this.titulo,
    this.mensaje_inicial,
    this.mensaje,
  });

  //create
  convertMap(int idusuario, String titulo, String mensaje_inicial) {
    Map data = {
      "idusuario": idusuario,
      "titulo": titulo,
      "mensaje_inicial": mensaje_inicial,
    };
    return data;
  }

    messageCreate(int idmensaje, int idusuario, String mensaje) {
    Map data = {
      "idmensaje": idmensaje,
      "idusuario": idusuario,
      "mensaje": mensaje,
    };
    return data;
  }

//LEER
  MessageUser.fromJson(Map json)
      : id = json['id'],
        idmensaje = json['idmensaje'],
        idusuario = json['idusuario'],
        fecha_creacion = json['fechaCreacion'],
        activo = json['activo'],
        titulo = json['titulo'],
        mensaje_inicial = json['mensaje_inicial'];
}
