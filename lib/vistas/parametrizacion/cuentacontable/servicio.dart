import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:moneto2/models/cuentacontable.dart';
import 'package:moneto2/models/cuentacontablehijo.dart';
import 'package:moneto2/utils/Const.dart';

import 'package:moneto2/widgets/load.dart';

class ServicioCuentaContable {
  Loads loads;

  Future<List<CuentaContablePadre>> getAll(String token) async {
    String url =
        Constants.uri + 'api/CuentaContable/GetListCuentaContablePadre';

    final respuesta =
        await http.get(url, headers: {HttpHeaders.authorizationHeader: token});

    List<CuentaContablePadre> _list;

    var resBody = json.decode(respuesta.body);

    var capsules = resBody as List;
    /*  print(resBody);
    print(capsules); */
    _list =
        capsules.map((model) => CuentaContablePadre.fromJson(model)).toList();

    return _list;
  }

  Future<List<CuentaContableHijo>> getAllHijos(
      String token, int idPadre) async {
    String url = Constants.uri +
        'api/CuentaContable/GetListCuentaContableHijosByPadreID/' +
        idPadre.toString();
    print(url);
    final respuesta =
        await http.get(url, headers: {HttpHeaders.authorizationHeader: token});

    List<CuentaContableHijo> _list;

    var resBody = json.decode(respuesta.body);

    var capsules = resBody as List;
    /*  print(resBody);
    print(capsules); */
    _list =
        capsules.map((model) => CuentaContableHijo.fromJson(model)).toList();

    return _list;
  }
}
