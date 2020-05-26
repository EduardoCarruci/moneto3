class Tercero {
  String id;
  int idTercero;
  String nombre;
  String apellido;
  String establecimiento;
  int idTipoIdentificacion;
  String nroIdentificacion;
  String mail;
  String telefono;
  String fechaNacimiento;
  int hijos;
  String direccion;
  int idGenero;
  int idTipoCliente;
  String tipoCliente;
  int idEstrato;
  int idEstadoCivil;
  String ubicacionGps;
  String TipoCliente;

  Tercero(
      {this.id,
      this.idTercero,
      this.nombre,
      this.apellido,
      this.establecimiento,
      this.idTipoIdentificacion,
      this.nroIdentificacion,
      this.mail,
      this.telefono,
      this.fechaNacimiento,
      this.hijos,
      this.direccion,
      this.idGenero,
      this.idTipoCliente,
      this.tipoCliente,
      this.idEstrato,
      this.idEstadoCivil,
      this.ubicacionGps,
      this.TipoCliente});
  //ffactory User.fromJson(String str) => User.fromMap(json.decode(str));
  //create
  converCreate(
      String nombre,
      String apellido,
      String establecimiento,
      int idTipoIdentificacion,
      String nroIdentificacion,
      String mail,
      String telefono,
      String fechaNacimiento,
      String hijos,
      String direccion,
      int idGenero,
      int idTipoCliente,
      int idEstrato,
      int idEstadoCivil,
      String ubicacionGps) {
    Map data = {
      "nombre": nombre,
      "apellido": apellido,
      "establecimiento": establecimiento,
      "idTipoIdentificacion": idTipoIdentificacion,
      "nroIdentificacion": nroIdentificacion,
      "mail": mail,
      "telefono": telefono,
      "fechaNacimiento": fechaNacimiento,
      "hijos": hijos,
      "direccion": direccion,
      "idGenero": idGenero,
      "idTipoCliente": idTipoCliente,
      "idEstrato": idEstrato,
      "idEstadoCivil": idEstadoCivil,
      "ubicacionGps": ubicacionGps,
    };
    return data;
  }

  factory Tercero.fromMap(Map<String, dynamic> json) => Tercero(
        id: json["\u0024id"],
        idTercero: json["idTercero"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        establecimiento: json["establecimiento"],
        idTipoIdentificacion: json["idTipoIdentificacion"],
        nroIdentificacion: json["nroIdentificacion"],
        mail: json["mail"],
        telefono: json["telefono"],
        fechaNacimiento: json["fechaNacimiento"],
        hijos: json["hijos"],
        direccion: json["direccion"],
        idGenero: json["idGenero"],
        idTipoCliente: json["idTipoCliente"],
        tipoCliente: json["TipoCliente"],
        idEstrato: json["idEstrato"],
        idEstadoCivil: json["idEstadoCivil"],
        ubicacionGps: json["ubicacionGps"],
      );

  convertMapOP(
      int idtercero,
      String nombre,
      String apellido,
      String establecimiento,
      int idTipoIdentificacion,
      String nroIdentificacion,
      String mail,
      String telefono,
      String fechaNacimiento,
      String hijos,
      String direccion,
      int idGenero,
      int idTipoCliente,
      int idEstrato,
      int idEstadoCivil,
      String ubicacionGps) {
    Map data = {
      "idtercero": idtercero,
      "nombre": nombre,
      "apellido": apellido,
      "establecimiento": establecimiento,
      "idTipoIdentificacion": idTipoIdentificacion,
      "nroIdentificacion": nroIdentificacion,
      "mail": mail,
      "telefono": telefono,
      "fechaNacimiento": fechaNacimiento,
      "hijos": hijos,
      "direccion": direccion,
      "idGenero": idGenero,
      "idTipoCliente": idTipoCliente,
      "idEstrato": idEstrato,
      "idEstadoCivil": idEstadoCivil,
      "ubicacionGps": ubicacionGps,
    };
    return data;
  }

//LEER
  Tercero.fromJson(Map json)
      : idTercero = json['idTercero'],
        nombre = json['nombre'],
        apellido = json['apellido'],
        establecimiento = json['establecimiento'],
        idTipoIdentificacion = json['idTipoIdentificacion'],
        nroIdentificacion = json['nroIdentificacion'],
        mail = json['mail'],
        telefono = json['telefono'],
        fechaNacimiento = json['fechaNacimiento'],
        hijos = json['hijos'],
        direccion = json['direccion'],
        idGenero = json['idGenero'],
        idTipoCliente = json['idTipoCliente'],
        idEstrato = json['idEstrato'],
        idEstadoCivil = json['idEstadoCivil'],
        ubicacionGps = json['ubicacionGps'],
        TipoCliente = json['TipoCliente'];
}
