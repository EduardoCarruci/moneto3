class CuentaContableHijo {
  String id;
  int idCuentaContable;
  int espadre;
  int idtipoCliente;
  int idpadre;
  String codigo;
  String nombre;

  CuentaContableHijo({
    this.id,
    this.idCuentaContable,
    this.espadre,
    this.idtipoCliente,
    this.idpadre,
    this.codigo,
    this.nombre,
  });

  //create
  convertMap(String codigo, String nombre, int espadre, int idpadre) {
    Map data = {
      "codigo": codigo,
      "nombre": nombre,
      "espadre": espadre,
      "idpadre": idpadre,
    };
    return data;
  }

    convertMapOP(String codigo, String nombre, int espadre, int idpadre) {
    Map data = {
      "codigo": codigo,
      "nombre": nombre,
      "espadre": espadre,
      "idpadre": idpadre,
    };
    return data;
  }

  
//LEER
  CuentaContableHijo.fromJson(Map json)
      : id = json['id'],
        idCuentaContable = json['idCuentaContable'],
        espadre = json['espadre'],
        idtipoCliente = json['idtipoCliente'],
        idpadre = json['idpadre'],
        codigo = json['codigo'],
        nombre = json['nombre'];
}
