import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:moneto2/models/geografia.dart';
import 'package:moneto2/utils/Const.dart';

import 'package:moneto2/widgets/load.dart';

class ServicioGeografia {
  Loads loads;

  Future<List<Geografia>> getAll(String token) async {
    String url = Constants.uri + 'api/Pais/GetListPais';

    final respuesta =
        await http.get(url, headers: {HttpHeaders.authorizationHeader: token});

    List<Geografia> _list;

    var resBody = json.decode(respuesta.body);

    var capsules = resBody as List;

    _list = capsules.map((model) => Geografia.fromJson(model)).toList();

    return _list;
  }
}
