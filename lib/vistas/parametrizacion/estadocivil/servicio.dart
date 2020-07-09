import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:moneto2/models/estadocivil.dart';
import 'package:moneto2/utils/Const.dart';

import 'package:moneto2/widgets/load.dart';

class ServicioEstadoCivil {
  Loads loads;

  Future<List<EstadoCivil>> getAll(String token) async {
    String url = Constants.uri + 'api/EstadoCivil/GetListEstadoCivil';
      print(url);
    final respuesta =
        await http.get(url, headers: {HttpHeaders.authorizationHeader: token});

    List<EstadoCivil> _list;

    var resBody = json.decode(respuesta.body);

    var capsules = resBody as List;
   /*  print(resBody);
    print(capsules); */
    _list = capsules.map((model) => EstadoCivil.fromJson(model)).toList();

    return _list;
  }
}
