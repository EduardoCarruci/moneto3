import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:moneto2/models/tipoDeIdentificacion.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/widgets/load.dart';

class ServicioTipoidentificacion {
  Loads loads;

  Future<List<TipoIdentificacion>> getAll(String token) async {
    String url =
        Constants.uri + 'api/TipoIdentificacion/GetListTipoIdentificacion';

    final respuesta =
        await http.get(url, headers: {HttpHeaders.authorizationHeader: token});
   /*  print(url);
    print(respuesta); */
    List<TipoIdentificacion> _list;

    var resBody = json.decode(respuesta.body);

    var capsules = resBody as List;

    _list =
        capsules.map((model) => TipoIdentificacion.fromJson(model)).toList();
       /*  print(resBody);
        print(capsules);
        print(_list); */

  return _list;
  }
}
