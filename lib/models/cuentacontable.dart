class CuentaContablePadre {
  String id;
  int idCuentaContable;
  int espadre;
  int idtipoCliente;
  int idpadre;
  String codigo;
  String nombre;
  int idcategoria;
  CuentaContablePadre({
    this.id,
    this.idCuentaContable,
    this.espadre,
    this.idtipoCliente,
    this.idpadre,
    this.codigo,
    this.nombre,
    this.idcategoria,
  });

  //create
  convertMap(String codigo, String nombre, int espadre, int idtipoCliente,int idcategoria) {
    Map data = {
      "codigo": codigo,
      "nombre": nombre,
      "espadre": espadre,
      "idtipoCliente": idtipoCliente,
      "idcategoria": idcategoria,
    };
    return data;
  }

  //modificar
    convertMapOP(String codigo, String nombre,int idcuentacontable) {
    Map data = {
       "codigo": codigo,
        "nombre": nombre,
      "idcuentacontable": idcuentacontable,
     
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
           idcategoria = json['idcategoria'],
        nombre = json['nombre'];
}
