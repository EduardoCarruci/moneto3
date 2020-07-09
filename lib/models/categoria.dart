class Categoria {
  int id;
  String nombre;
  String codigo;
  //String subnivel;
 // int ponderar;

/*   String Cronograma;
  String Operacion;
  String TipoOperacion; */

  Categoria({
    this.id,
    this.nombre,
    this.codigo,
    //this.subnivel,
    //this.ponderar,
  });

  //create
  convertMap(
       String codigo,String nombre) {
    Map data = {
      "codigo": codigo,
      "nombre": nombre,
    
    };
    return data;
  }
    //modificar
    convertMapOP(int id,String codigo ,String nombre) {
    Map data = {
       "id": id,
      "codigo": codigo,
      "nombre": nombre,
      /* "subnivel": subnivel,
      "ponderar": ponderar, */
    };
    return data;
  }
//LEER
  Categoria.fromJson(Map json)
      : id = json['id'],
        nombre = json['nombre'],
        codigo = json['codigo'];
      /*   subnivel = json['subnivel'],
        ponderar = json['ponderar']; */
}
