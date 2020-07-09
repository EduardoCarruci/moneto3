
import 'dart:convert';

class Tercero {
    Tercero({
        this.id,
        this.idTercero,
        this.nombre,
        this.apellido,
        this.establecimiento,
        this.idTipoIdentificacion,
        this.tipoIdentificacion,
        this.nroIdentificacion,
        this.mail,
        this.telefono,
        this.fechaNacimiento,
        this.hijos,
        this.direccion,
        this.idGenero,
        this.genero,
        this.idTipoCliente,
        this.tipoCliente,
        this.idEstrato,
        this.estrato,
        this.idEstadoCivil,
        this.estadoCivil,
        this.ubicacionGps,
        this.idPais,
        this.pais,
        this.idDepartamento,
        this.departamento,
        this.idMunicipio,
        this.municipio,
        this.idLocalidad,
        this.localidad,
    });

    String id;
    int idTercero;
    String nombre;
    String apellido;
    String establecimiento;
    int idTipoIdentificacion;
    String tipoIdentificacion;
    String nroIdentificacion;
    String mail;
    String telefono;
    DateTime fechaNacimiento;
    int hijos;
    String direccion;
    int idGenero;
    String genero;
    int idTipoCliente;
    String tipoCliente;
    int idEstrato;
    String estrato;
    int idEstadoCivil;
    String estadoCivil;
    dynamic ubicacionGps;
    int idPais;
    String pais;
    int idDepartamento;
    String departamento;
    int idMunicipio;
    String municipio;
    int idLocalidad;
    String localidad;
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
    String ubicacionGps,
    String idPais,
    String idDepartamento,
    String idMunicipio,
    String idLocalidad,
  ) {
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
      "idPais": idPais,
      "idDepartamento": idDepartamento,
      "idMunicipio": idMunicipio,
      "idLocalidad": idLocalidad,
    };
    return data;
  }

factory Tercero.fromJson(String str) => Tercero.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Tercero.fromMap(Map<String, dynamic> json) => Tercero(
        id: json["\u0024id"],
        idTercero: json["idTercero"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        establecimiento: json["establecimiento"],
        idTipoIdentificacion: json["idTipoIdentificacion"],
        tipoIdentificacion: json["tipoIdentificacion"],
        nroIdentificacion: json["nroIdentificacion"],
        mail: json["mail"],
        telefono: json["telefono"],
        fechaNacimiento: DateTime.parse(json["fechaNacimiento"]),
        hijos: json["hijos"],
        direccion: json["direccion"],
        idGenero: json["idGenero"],
        genero: json["genero"],
        idTipoCliente: json["idTipoCliente"],
        tipoCliente: json["TipoCliente"],
        idEstrato: json["idEstrato"],
        estrato: json["estrato"],
        idEstadoCivil: json["idEstadoCivil"],
        estadoCivil: json["estadoCivil"],
        ubicacionGps: json["ubicacionGps"],
        idPais: json["idPais"],
        pais: json["Pais"],
        idDepartamento: json["idDepartamento"],
        departamento: json["Departamento"],
        idMunicipio: json["idMunicipio"],
        municipio: json["Municipio"],
        idLocalidad: json["idLocalidad"],
        localidad: json["Localidad"],
    );
     Map<String, dynamic> toMap() => {
        "\u0024id": id,
        "idTercero": idTercero,
        "nombre": nombre,
        "apellido": apellido,
        "establecimiento": establecimiento,
        "idTipoIdentificacion": idTipoIdentificacion,
        "tipoIdentificacion": tipoIdentificacion,
        "nroIdentificacion": nroIdentificacion,
        "mail": mail,
        "telefono": telefono,
        "fechaNacimiento": fechaNacimiento.toIso8601String(),
        "hijos": hijos,
        "direccion": direccion,
        "idGenero": idGenero,
        "genero": genero,
        "idTipoCliente": idTipoCliente,
        "TipoCliente": tipoCliente,
        "idEstrato": idEstrato,
        "estrato": estrato,
        "idEstadoCivil": idEstadoCivil,
        "estadoCivil": estadoCivil,
        "ubicacionGps": ubicacionGps,
        "idPais": idPais,
        "Pais": pais,
        "idDepartamento": idDepartamento,
        "Departamento": departamento,
        "idMunicipio": idMunicipio,
        "Municipio": municipio,
        "idLocalidad": idLocalidad,
        "Localidad": localidad,
    };

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
    String ubicacionGps,
    String idPais,
    String idDepartamento,
    String idMunicipio,
    String idLocalidad) {
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
      "idPais": idPais,
      "idDepartamento": idDepartamento,
      "idMunicipio": idMunicipio,
      "idLocalidad": idLocalidad,
    };
    return data;
  }


}
