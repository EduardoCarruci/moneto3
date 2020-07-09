import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:moneto2/models/cronograma.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/widgets/load.dart';

class ServicioCronograma {
  Loads loads;

  Future<List<Cronograma>> getAll(String token, String idUser) async {
    String url = Constants.uri +
        'api/Cronograma/GetListCronograma?idusuario=${idUser.toString()}';

    final respuesta =
        await http.get(url, headers: {HttpHeaders.authorizationHeader: token});
    //print(respuesta.body);
    List<Cronograma> _list;

    var resBody = json.decode(respuesta.body);

    var capsules = resBody as List;

    _list = capsules.map((model) => Cronograma.fromJson(model)).toList();

    return _list;
  }

  Future<List<Cronograma>> getAlarmas(String token, String idCronograma) async {
    print(idCronograma);
    String url = Constants.uri +
        'api/cronograma/GetListCronogramaFecha?idcronograma=${idCronograma.toString()}';

    final respuesta =
        await http.get(url, headers: {HttpHeaders.authorizationHeader: token});
        print(url);
    print(respuesta.body);
    List<Cronograma> _list;

    var resBody = json.decode(respuesta.body);

    var capsules = resBody as List;

    _list = capsules.map((model) => Cronograma.fromJson(model)).toList();

    return _list;
  }
}
