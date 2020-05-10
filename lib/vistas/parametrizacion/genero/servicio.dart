import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:moneto2/models/genero.dart';
import 'package:moneto2/utils/Const.dart';

import 'package:moneto2/widgets/load.dart';

class ServicioGenero {
  Loads loads;

  Future<List<Genero>> getAll(String token) async {
    String url = Constants.uri + 'api/Genero/GetListGenero';

    final respuesta =
        await http.get(url, headers: {HttpHeaders.authorizationHeader: token});

    List<Genero> _list;

    var resBody = json.decode(respuesta.body);

    var capsules = resBody as List;

    _list = capsules.map((model) => Genero.fromJson(model)).toList();

    return _list;
  }

}
