import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:moneto2/models/tipoAlarma.dart';
import 'package:moneto2/utils/Const.dart';

import 'package:moneto2/widgets/load.dart';

class ServicioTipoAlarma {
  Loads loads;

  Future<List<TipoAlarma>> getAll(String token) async {
    String url = Constants.uri + 'api/TipoAlarma/GetListTipoAlarma';

    final respuesta =
        await http.get(url, headers: {HttpHeaders.authorizationHeader: token});

    List<TipoAlarma> _list;

    var resBody = json.decode(respuesta.body);

    var capsules = resBody as List;
    /*  print(resBody);
    print(capsules); */
    _list = capsules.map((model) => TipoAlarma.fromJson(model)).toList();

    return _list;
  }
}
