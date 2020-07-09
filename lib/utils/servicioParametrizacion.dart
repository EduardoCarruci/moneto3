import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/widgets/load.dart';

class ServicioParametrizacion {
  Loads loads;

  Future<String> create(
      String token, Map data, BuildContext context, String ruta) async {
    String url = Constants.uri + ruta;

    var body = json.encode(data);

    loads = new Loads(context);
    loads.progressCarga("Guardando...");
    http.Response response = await http.post(url, body: body, headers: {
      HttpHeaders.authorizationHeader: token,
      "Content-Type": "application/json"
    });

    if (response.statusCode == 200) {
      loads.cerrar();
      loads.toast(1, "Los datos ingresados son correctos");
    } else if (response.statusCode == 404) {
      loads.cerrar();
      loads.toast(2, response.body);
      Navigator.pop(context);
    }
    return response.statusCode.toString();
  }

  Future<String> edit(String token, dynamic data, String id,
      BuildContext context, String ruta) async {
    String url = Constants.uri + ruta + id;

    var body = json.encode(data);

    loads = new Loads(context);
    loads.progressCarga("Guardando...");
    http.Response response = await http.post(url, body: body, headers: {
      HttpHeaders.authorizationHeader: token,
      "Content-Type": "application/json"
    });

    if (response.statusCode == 200) {
      loads.cerrar();
      loads.toast(1, "Los datos ingresados son correctos");

      
    } else if (response.statusCode == 404) {
      // Si LA PETICION FALLO
      loads.cerrar();
      loads.toast(2, response.body);
      Navigator.pop(context);
    }
    return response.statusCode.toString();
  }

  Future<String> editTercero(
      String token, dynamic data, BuildContext context, String ruta) async {
    String url = Constants.uri + ruta;

    var body = json.encode(data);

    loads = new Loads(context);
    loads.progressCarga("Guardando...");

    http.Response response = await http.post(url, body: body, headers: {
      HttpHeaders.authorizationHeader: token,
      "Content-Type": "application/json"
    });
    //  if (response.statusCode <= 210) {
    if (response.statusCode == 200) {
      loads.cerrar();
      loads.toast(1, "Los datos ingresados son correctos");
    } else if (response.statusCode == 404) {
      // Si LA PETICION FALLO
      loads.cerrar();
      loads.toast(2, response.body);
      Navigator.pop(context);
    }
    return response.statusCode.toString();
  }

  Future<String> editAvanzado(
      String token, dynamic data, BuildContext context, String ruta) async {
    String url = Constants.uri + ruta;

    var body = json.encode(data);

    loads = new Loads(context);
    loads.progressCarga("Guardando...");
    http.Response response = await http.post(url, body: body, headers: {
      HttpHeaders.authorizationHeader: token,
      "Content-Type": "application/json"
    });

    if (response.statusCode == 200) {
      loads.cerrar();
      loads.toast(1, "Los datos ingresados son correctos");
    } else if (response.statusCode == 404) {
      loads.cerrar();
      loads.toast(2, response.body);
      Navigator.pop(context);
    }
    return response.statusCode.toString();
  }

  Future<String> delete(
      String token, String id, BuildContext context, String ruta) async {
    String url = Constants.uri + ruta + id;

    loads = new Loads(context);
    loads.progressCarga("Eliminando...");
    http.Response response = await http.delete(url, headers: {
      HttpHeaders.authorizationHeader: token,
      "Content-Type": "application/json"
    });

    if (response.statusCode == 200) {
      loads.cerrar();

      loads.toast(1, "Los datos ingresados son correctos");
    } else if (response.statusCode == 404) {
      loads.toast(2, response.body);
      loads.cerrar();

      Navigator.pop(context);
    }
    print(response.statusCode);
    return response.statusCode.toString();
  }

  Future<String> deleteTercero(
      String token, Map data, BuildContext context, String ruta) async {
    String url = Constants.uri + ruta;

    loads = new Loads(context);
    loads.progressCarga("Eliminando...");
    http.Response response = await http.delete(url, headers: {
      HttpHeaders.authorizationHeader: token,
      "Content-Type": "application/json"
    });

    if (response.statusCode == 200) {
      loads.cerrar();
      loads.toast(1, "Los datos ingresados son correctos");
    } else if (response.statusCode == 404) {
      loads.toast(2, response.body);
      loads.cerrar();

      Navigator.pop(context);
    }
    return response.statusCode.toString();
  }
}
