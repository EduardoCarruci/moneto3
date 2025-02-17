class Cronograma {
  int id;
  int idCronograma;
  String fecha;
  String actividad;
  int idAlarma;
  int idCategoria;
  String categoria;
  int idRecurrencia;
  String recurrencia;
  String dia;
  String dialargo;
  String fechafinalizacion;
  int idUsuario;
  //{"$id":"4","idCronograma":14,
  //"fecha":"2020-05-14T00:00:00","actividad":"Quincenal",
  //"idAlarma":1,"idCategoria":2,"categoria":"categoría de calendario 2",
  //"idRecurrencia":2,"recurrencia":"Quincenal","dia":"",
  //"dialargo":"no encontrado"}
  Cronograma({
    this.id,
    this.idCronograma,
    this.fecha,
    this.actividad,
    this.idAlarma,
    this.idCategoria,
    this.categoria,
    this.idRecurrencia,
    this.recurrencia,
    this.dia,
    this.dialargo,
    this.fechafinalizacion,
    this.idUsuario,
  });

  //create
  convertMap(String fecha, String actividad, int idAlarma, String idCategoria,
      String idRecurrencia, String dia,String idUser,String fechafinalizacion) {
    Map data = {
      "fecha": fecha,
      "actividad": actividad,
      "idAlarma": idAlarma,
      "idCategoria": idCategoria,
      "idRecurrencia": idRecurrencia,
      "dia": dia,
      "idusuario":idUser,
      "fecha_finalizacion":fechafinalizacion,
    };
    return data;
  }

  //modificar
  convertMapOP(int idCronograma, String fecha, String actividad, int idAlarma,
      String idCategoria, String idRecurrencia, String dia,String idUser,String fechafinalizacion) {
    Map data = {
      "idCronograma": idCronograma,
      "fecha": fecha,
      "actividad": actividad,
      "idAlarma": idAlarma,
      "idCategoria": idCategoria,
      "idRecurrencia": idRecurrencia,
       "dia": dia,
          "idusuario":idUser,
      "fecha_finalizacion":fechafinalizacion,
    };
    return data;
  }

//LEER
  Cronograma.fromJson(Map json)
      : idCronograma = json['idCronograma'],
        fecha = json['fecha'],
        actividad = json['actividad'],
        idAlarma = json['idAlarma'],
        idCategoria = json['idCategoria'],
        categoria = json['categoria'],
        idRecurrencia = json['idRecurrencia'],
        recurrencia = json['recurrencia'],
        dia = json['dia'],
        dialargo = json['dialargo'],
        fechafinalizacion = json['fecha_finalizacion'],
        idUsuario = json['idUsuario'];
}
