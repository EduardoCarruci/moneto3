import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:moneto2/models/cronograma.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/widgets/load.dart';

class ServicioCronograma {
  Loads loads;

  Future<List<Cronograma>> getAll(String token) async {
    String url = Constants.uri + 'api/Cronograma/GetListCronograma';

    final respuesta =
        await http.get(url, headers: {HttpHeaders.authorizationHeader: token});

    List<Cronograma> _list;

    var resBody = json.decode(respuesta.body);

    var capsules = resBody as List;

    _list = capsules.map((model) => Cronograma.fromJson(model)).toList();

    //print(resBody);
    //print(capsules);
    //print(respuesta);
    //print(_list);
    return _list;
  }
}
