import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:moneto2/models/moneda.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/widgets/load.dart';

class ServicioMoneda {
  Loads loads;
  Future<List<Moneda>> getMonedas(String token) async {
    String url = Constants.uri + 'api/Monedas/GetListMoneda';
    final respuesta =
        await http.get(url, headers: {HttpHeaders.authorizationHeader: token});

    List<Moneda> _listacoins;
    var resBody = json.decode(respuesta.body);
    var capsules = resBody as List;
    _listacoins = capsules.map((model) => Moneda.fromJson(model)).toList();
    return _listacoins;
  }

}
