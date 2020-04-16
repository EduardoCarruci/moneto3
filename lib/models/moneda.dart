class Monedas {
  List<Moneda> items = new List();

  Monedas();

  Monedas.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final monedita = new Moneda.fromJsonMap(item);
      items.add(monedita);
    } //fin for
  } //fin constructor

}

class Moneda {
  int id;
  int idMoneda;
  String codigo;
  String nombre;
  String identificador;
  String MedioPago;


  Moneda({
    this.id,
    this.idMoneda,
    this.codigo,
    this.nombre,
    this.identificador,
    this.MedioPago,
   
  });

  Moneda.fromJsonMap(Map<String, dynamic> json) {
    id = json["id"];
    idMoneda = json["idMoneda"];
    codigo = json["codigo"];
    nombre = json["nombre"];
    identificador = json["identificador"];
    MedioPago = json["MedioPago"];
  
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "idMoneda": idMoneda,
        "codigo": codigo,
        "nombre": nombre,
        "identificador": identificador,
        "MedioPago": MedioPago,
        
      };
}
