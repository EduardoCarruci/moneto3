import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:moneto2/models/tipoCliente.dart';

import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/widgets/load.dart';

class ServicioTipoCliente {
  Loads loads;

  Future<List<TipoCliente>> getAll(String token) async {
    String url =
        Constants.uri + 'api/TipoCliente/GetListTipoCliente';

    final respuesta =
        await http.get(url, headers: {HttpHeaders.authorizationHeader: token});
  /*   print(url);
    print(respuesta); */
    List<TipoCliente> _list;

    var resBody = json.decode(respuesta.body);

    var capsules = resBody as List;

    _list =
        capsules.map((model) => TipoCliente.fromJson(model)).toList();
      /*   print(resBody);
        print(capsules);
       */
  //print(resBody);
  return _list;
  }
}
