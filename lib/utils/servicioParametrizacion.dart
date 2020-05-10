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
    //'api/CategoriaCalendario/Create'
    String url = Constants.uri + ruta;
     print(url);
    var body = json.encode(data);

    loads = new Loads(context);
    loads.progressCarga("Guardando...");
    //ACA DEBERIA ESTAR EL EVENTO GUARDANDO DATOS
    http.Response response = await http.post(url, body: body, headers: {
      HttpHeaders.authorizationHeader: token,
      "Content-Type": "application/json"
    });
    print("RESPONSE:  " + response.toString());
    if (response.statusCode <= 210) {
      loads.cerrar();
      loads.toast(1, "Los datos ingresados son correctos");
      Navigator.pop(context);
      print(210);
    } else if (response.statusCode == 302 ||
        response.statusCode == 400 ||
        response.statusCode == 401) {
      // Si LA PETICION FALLO
      loads.cerrar();
      loads.toast(2, "Los datos ingresados son incorrectos");
      Navigator.pop(context);
    } else {
      print("ACA");
      loads.cerrar();
      loads.toast(2, "Los datos ingresados son incorrectos");
      Navigator.pop(context);
    }
    return response.statusCode.toString();
  }

  Future<String> edit(String token, Map data, String id, BuildContext context,
      String ruta) async {
    //'api/CategoriaCalendario/Update/'
    String url = Constants.uri + ruta + id;
    print(url);
    var body = json.encode(data);

    loads = new Loads(context);
    loads.progressCarga("Guardando...");
    http.Response response = await http.post(url, body: body, headers: {
      HttpHeaders.authorizationHeader: token,
      "Content-Type": "application/json"
    });

    if (response.statusCode <= 210) {
      loads.cerrar();
      loads.toast(1, "Los datos ingresados son correctos");
      Navigator.pop(context);
      print(210);
    } else if (response.statusCode == 302 ||
        response.statusCode == 400 ||
        response.statusCode == 401) {
      // Si LA PETICION FALLO
      loads.cerrar();
      loads.toast(2, "Los datos ingresados son incorrectos");
      Navigator.pop(context);
    } else {
      print("ACA");
      loads.cerrar();
      loads.toast(2, "Los datos ingresados son incorrectos");
      Navigator.pop(context);
    }
    return response.statusCode.toString();
  }

  Future<String> delete(String token, Map data, String id, BuildContext context,
      String ruta) async {
    //'api/CategoriaCalendario/Delete/'
    String url = Constants.uri + ruta + id;
    print(url);
    loads = new Loads(context);
    loads.progressCarga("Eliminando...");
    http.Response response = await http.delete(url, headers: {
      HttpHeaders.authorizationHeader: token,
      "Content-Type": "application/json"
    });

    if (response.statusCode <= 210) {
      loads.cerrar();
      loads.toast(1, "Los datos ingresados son correctos");
      Navigator.pop(context);
      print(210);
    } else if (response.statusCode == 302 ||
        response.statusCode == 400 ||
        response.statusCode == 401) {
      // Si LA PETICION FALLO
      loads.toast(2, "Los datos ingresados son incorrectos");
      loads.cerrar();

      Navigator.pop(context);
    } else {
      loads.toast(2, "Los datos ingresados son incorrectos");
      loads.cerrar();

      Navigator.pop(context);
    }
    return response.statusCode.toString();
  }
}
