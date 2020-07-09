class CuentaContablePadre {
  String id;
  int idCuentaContable;
  int espadre;
  int idtipoCliente;
  int idpadre;
  String codigo;
  String nombre;
  int idtipoCategoria;
  String tipoCategoria;
  CuentaContablePadre({
    this.id,
    this.idCuentaContable,
    this.espadre,
    this.idtipoCliente,
    this.idpadre,
    this.codigo,
    this.nombre,
    this.idtipoCategoria,
    this.tipoCategoria,
  });

  //create
  convertMap(String codigo, String nombre, int espadre, int idtipoCliente,
      int idcategoria) {
    Map data = {
      "codigo": codigo,
      "nombre": nombre,
      "espadre": espadre,
      "idtipoCliente": idtipoCliente,
      "idtipoCategoria": idcategoria,
    };
    return data;
  }

  //modificar
  convertMapOP(String codigo, String nombre, int idcuentacontable,
      int idcategoria, int espadre, int idpadre) {
    Map data = {
      "codigo": codigo,
      "nombre": nombre,
      "idcuentacontable": idcuentacontable,
      "idtipoCategoria": idcategoria,
      "espadre": espadre,
      "idpadre": idpadre,
    };
    return data;
  }

//LEER
  CuentaContablePadre.fromJson(Map json)
      : id = json['id'],
        idCuentaContable = json['idCuentaContable'],
        espadre = json['espadre'],
        idtipoCliente = json['idtipoCliente'],
        idpadre = json['idpadre'],
        codigo = json['codigo'],
        idtipoCategoria = json['idtipoCategoria'],
        tipoCategoria = json['tipoCategoria'],
        nombre = json['nombre'];
}
