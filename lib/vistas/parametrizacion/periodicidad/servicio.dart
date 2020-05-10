import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:moneto2/models/periodicidad.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/widgets/load.dart';

class ServicioPeriodicidad {
  Loads loads;

  Future<List<Periodicidad>> getAll(String token) async {
    String url = Constants.uri + 'api/Periodicidad/GetListPeriodicidad';

    final respuesta =
        await http.get(url, headers: {HttpHeaders.authorizationHeader: token});

    List<Periodicidad> _list;

    var resBody = json.decode(respuesta.body);

    var capsules = resBody as List;

    _list = capsules.map((model) => Periodicidad.fromJson(model)).toList();

    return _list;
  }

}
