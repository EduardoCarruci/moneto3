class CategoriaCalendario {
  String id;
  int idCategoriaCalendario;
  String nombre;
  
 
  CategoriaCalendario({
    this.id,
    this.idCategoriaCalendario,
   
    this.nombre,
  });

  //create
  converCreate(String nombre) {
    Map data = {
    
      "nombre": nombre,
    };
    return data;
  }

  // operaciones
  convertMapOP(String idCategoriaCalendario, String nombre) {
    Map data = {
      "idCategoriaCalendario": idCategoriaCalendario,
   
      "nombre": nombre,
    };
    return data;
  }

//LEER
  CategoriaCalendario.fromJson(Map json)
      : id = json['id'],
        idCategoriaCalendario = json['idCategoriaCalendario'],
        nombre = json['nombre'];
      
}
