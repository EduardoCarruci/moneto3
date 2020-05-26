import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:moneto2/models/categoriaCalendario.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/widgets/load.dart';

class ServicioCategoriaCalendario {
  Loads loads;

  Future<List<CategoriaCalendario>> getAll(String token) async {
    String url =
        Constants.uri + 'api/CategoriaCalendario/GetListCategoriaCalendario';

    final respuesta =
        await http.get(url, headers: {HttpHeaders.authorizationHeader: token});

    List<CategoriaCalendario> _list;

    var resBody = json.decode(respuesta.body);

    var capsules = resBody as List;

    _list =
        capsules.map((model) => CategoriaCalendario.fromJson(model)).toList();
    //print(resBody);
    return _list;
  }
}
