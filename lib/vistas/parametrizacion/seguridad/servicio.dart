import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:moneto2/models/seguridad.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/widgets/load.dart';

class ServicioSeguridad {
  Loads loads;

  Future<List<Seguridad>> getAllHijos(String token, String id) async {
    String url = Constants.uri +
        'api/Seguridad/GetSeguridadByTipoCliente/' +
        id.toString();
    print(url);
    final respuesta =
        await http.get(url, headers: {HttpHeaders.authorizationHeader: token});

    List<Seguridad> _list;

    var resBody = json.decode(respuesta.body);

    var capsules = resBody as List;
    /*  print(resBody);
    print(capsules); */
    _list = capsules.map((model) => Seguridad.fromJson(model)).toList();
    //print(_list);
    return _list;
  }
}
