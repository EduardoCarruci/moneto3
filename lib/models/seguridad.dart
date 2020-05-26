class Seguridad {
  //String $id;
  int IdTipoClienteMenu;
  int idTipoCliente;
  int idMenu;
  String menu;
  int idhabilitado;

  Seguridad({
    this.IdTipoClienteMenu,
    this.idTipoCliente,
    this.idMenu,
    this.menu,
    this.idhabilitado,
  });

  /* convertMapOP(String idPeriodicidad, String codigo, String nombre,
      String equivalencia) {
    Map data = {
      "idPeriodicidad": idPeriodicidad,
      "codigo": codigo,
      "nombre": nombre,
      "equivalencia": equivalencia,
    };
    return data;
  } */

  Seguridad.fromJson(Map json)
      : IdTipoClienteMenu = json['IdTipoClienteMenu'],
        idTipoCliente = json['idTipoCliente'],
        idMenu = json['idMenu'],
        menu = json['menu'],
        idhabilitado = json['idhabilitado'];
}
