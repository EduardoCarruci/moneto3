import 'dart:convert';
import 'package:intl/intl.dart';

class OperacionesFinancieras {
  int idOperacionFinanciera;
  int idUsuario;
  String referencia;
  double importeTotal;
  int idTercero;
  String tercero;
  dynamic refIdOperacionFinanciera;
  int idCategoriaPadre;
  int idCategoriaHija;
  String cuentacontablehija;
  List<Detalleconcepto> detalleconceptos;

  OperacionesFinancieras({
    this.idOperacionFinanciera,
    this.idUsuario,
    this.referencia,
    this.importeTotal,
    this.idTercero,
    this.tercero,
    this.refIdOperacionFinanciera,
    this.idCategoriaPadre,
    this.detalleconceptos,
    this.idCategoriaHija,
    this.cuentacontablehija,
  });

  factory OperacionesFinancieras.fromJson(String str) =>
      OperacionesFinancieras.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OperacionesFinancieras.fromMap(Map<String, dynamic> json) =>
      OperacionesFinancieras(
        idOperacionFinanciera: json["IdOperacionFinanciera"],
        idUsuario: json["IdUsuario"],
        referencia: json["Referencia"],
        importeTotal: json["ImporteTotal"],
        idTercero: json["IdTercero"],
        tercero: json["tercero"],
        refIdOperacionFinanciera: json["RefIdOperacionFinanciera"],
        idCategoriaPadre: json["IdCategoriaPadre"],
        idCategoriaHija: json["IdCategoriaHija"],
        cuentacontablehija: json["cuentacontablehija"],
        detalleconceptos: List<Detalleconcepto>.from(
            json["detalleconceptos"].map((x) => Detalleconcepto.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        //"IdOperacionFinanciera": idOperacionFinanciera,
        "IdUsuario": idUsuario,
        "Referencia": referencia,
        // "ImporteTotal": importeTotal,
        "IdTercero": idTercero,
        //"tercero": tercero,
        "RefIdOperacionFinanciera": refIdOperacionFinanciera,
        "IdCategoriaPadre": idCategoriaPadre,
        "IdCategoriaHija": idCategoriaHija,
        "detalleconceptos":
            List<dynamic>.from(detalleconceptos.map((x) => x.toMap())),
      };

  Map<String, dynamic> toMap2() => {
        "IdOperacionFinanciera": idOperacionFinanciera,
        "IdUsuario": idUsuario,
        "Referencia": referencia,
        //"ImporteTotal": importeTotal,
        "IdTercero": idTercero,
        "tercero": tercero,
        "RefIdOperacionFinanciera": refIdOperacionFinanciera,
        "IdCategoriaPadre": idCategoriaPadre,
        "IdCategoriaHija": idCategoriaHija,
        "detalleconceptos":
            List<dynamic>.from(detalleconceptos.map((x) => x.toMap2())),
      };
}

class Detalleconcepto {
  int idOperacionFinanciera;
  int idTipoConcepto;
  int idOperacionFinancieraDetalle;
  String tipoConcepto;
  double importe;
  String fecha;
  String numeroDocumento;
  static final format = DateFormat("yyyy-MM-dd");

  Detalleconcepto({
    this.idOperacionFinanciera,
    this.idTipoConcepto,
    this.idOperacionFinancieraDetalle,
    this.tipoConcepto,
    this.importe,
    this.fecha,
    this.numeroDocumento,
  });

  factory Detalleconcepto.fromJson(String str) =>
      Detalleconcepto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Detalleconcepto.fromMap(Map<String, dynamic> json) => Detalleconcepto(
        //format.format(DateTime.parse(item.fecha.toString()))
        idOperacionFinanciera: json["IdOperacionFinanciera"],
        idOperacionFinancieraDetalle: json["IdOperacionFinancieraDetalle"],

        idTipoConcepto: json["IdTipoMedioPago"],
        tipoConcepto: json["tipoConcepto"],
        importe: json["Importe"],
        fecha: json["Fecha"],
        numeroDocumento: json["NumeroDocumento"],
      );

  Map<String, dynamic> toMap() => {
        // "IdOperacionFinanciera": idOperacionFinanciera,
        "IdTipoMedioPago": idTipoConcepto,
        //  "tipoConcepto": tipoConcepto,
        "Importe": importe,
        "Fecha": fecha,
        "NumeroDocumento": numeroDocumento,
      };

  Map<String, dynamic> toMap2() => {
        "IdOperacionFinanciera": idOperacionFinanciera,
        "IdTipoMedioPago": idTipoConcepto,
        //"tipoConcepto": tipoConcepto,
        "Importe": importe,

        "Fecha": fecha,
        "NumeroDocumento": numeroDocumento,
      };
  convertMap(
      String idtipoconcepto, String importe, String fecha, String numeroDoc) {
    Map data = {
      "IdTipoMedioPago": idtipoconcepto,
      "Importe": importe,
      "Fecha": fecha,
      "NumeroDocumento": numeroDoc,
    };
    return data;
  }
}
