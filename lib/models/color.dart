class ColorApp {
  String id;
  int idColorAPP;
  String nombre;
  String idScreen;
  String colorHexa;


  ColorApp({
    this.id,
    this.idColorAPP,
    this.nombre,
    this.idScreen,
    this.colorHexa
  });

    convertMapOP(int idusuario, int idColorApp) {
    Map data = {

 
      "idusuario": idusuario,
      "idColorApp": idColorApp,
     
    };
    return data;
  }

 
//LEER
//{"$id":"1","idTipoIdentificacion":1,"codigo":"ASDW45","nombre":"Identificacion 1","Tercero":null,"Usuario":null}
  ColorApp.fromJson(Map json)
      : id = json['id'],
        idColorAPP = json['idColorAPP'],
        nombre = json['nombre'],
        idScreen = json['idScreen'],
        colorHexa= json['colorHexa'];
}
