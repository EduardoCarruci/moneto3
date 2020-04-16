import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:moneto2/models/moneda.dart';

class ServicioMoneda {
  Future<List<Moneda>> getMonedas(String token) async {
    print("CAI");
    String url = "http://198.72.112.52:8080/api/Monedas/GetListMoneda";
    final respuesta =
        await http.get(url, headers: {HttpHeaders.authorizationHeader: token});

    print(respuesta);
    final decodedData = jsonDecode(respuesta.body);
    print(decodedData);
    final monedas = new Monedas.fromJsonList(decodedData['']);
    print(monedas.items);

    if (monedas.items == null) {
      print("VACIA");
    }
    return monedas.items;
  }
}
