import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:moneto2/models/tipomediopago.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/widgets/load.dart';

class ServicioTipoConcepto {
  Loads loads;

  Future<List<TipoMedioPago>> getAll(String token) async {
    String url = Constants.uri + 'api/tipomediopago/GetListTipoMedioPago';

    final respuesta =
        await http.get(url, headers: {HttpHeaders.authorizationHeader: token});

    List<TipoMedioPago> _list;

    var resBody = json.decode(respuesta.body);

    var capsules = resBody as List;

    _list = capsules.map((model) => TipoMedioPago.fromJson(model)).toList();

    return _list;
  }
}
