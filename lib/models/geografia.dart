class Geografia {
  String id;
  /*  String Direccion;
  String Region; */
  int idPais;
  String descripcion;

/*   String Cronograma;
  String Operacion;
  String TipoOperacion; */

  Geografia({
    this.id,
    /*   this.Direccion,
    this.Region, */
    this.idPais,
    this.descripcion,
  });

  //create
  convertMap(String descripcion) {
    Map data = {
      "descripcion": descripcion,
    };
    return data;
  }

  //modificar
  convertMapOP(String idPais, String descripcion) {
    Map data = {
      "idPais": idPais,
      "descripcion": descripcion,
    };
    return data;
  }

  Geografia.fromJson(Map json)
      : id = json['id'],
        idPais = json['idPais'],
        descripcion = json['descripcion'];
  /*  idCategoria = json['idCategoria'],
        subnivel = json['subnivel'],
        ponderar = json['ponderar']; */
}
