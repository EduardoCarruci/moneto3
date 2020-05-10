class Periodicidad {
  String $id;
  int idPeriodicidad;
  String codigo;
  String nombre;
  int equivalencia;
  String Operacion_ModoOperacion;

  Periodicidad({
    this.$id,
    this.idPeriodicidad,
    this.codigo,
    this.nombre,
    this.equivalencia,
    this.Operacion_ModoOperacion,
  });

   convertMap(String codigo, String nombre, String equivalencia) {
    Map data = {
      "codigo": codigo,
      "nombre": nombre,
      "equivalencia": equivalencia,
    };
    return data;
  }

    convertMapOP(String idPeriodicidad, String codigo, String nombre, String equivalencia) {
    Map data = {
      "idPeriodicidad": idPeriodicidad,
      "codigo": codigo,
      "nombre": nombre,
      "equivalencia": equivalencia,
    };
    return data;
  }

  Periodicidad.fromJson(Map json)
      : idPeriodicidad = json['idPeriodicidad'],
        codigo = json['codigo'],
        nombre = json['nombre'],
        equivalencia = json['equivalencia'];
}
