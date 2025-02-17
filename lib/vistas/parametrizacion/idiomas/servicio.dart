import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:moneto2/models/idiomas.dart';

import 'package:moneto2/utils/Const.dart';

import 'package:moneto2/widgets/load.dart';

class ServicioIdiomas {
  Loads loads;

  Future<List<Idioma>> getAll(String token) async {
    String url = Constants.uri + 'api/Idioma/GetListIdioma';
  print(url);
    final respuesta =
        await http.get(url, headers: {HttpHeaders.authorizationHeader: token});

    List<Idioma> _list;

    var resBody = json.decode(respuesta.body);

    var capsules = resBody as List;

    _list = capsules.map((model) => Idioma.fromJson(model)).toList();

    return _list;
  }

  Future<List<Idioma>> getUniqueIdioma(String token, String idIdioma) async {
    String url = Constants.uri + 'api/Idioma/GetIdioma/' +idIdioma.toString();
    print(url);
    final respuesta =
        await http.get(url, headers: {HttpHeaders.authorizationHeader: token});
  //  print("RESPUESTA: " + respuesta.toString());

    Map<String, dynamic> resBody = json.decode(respuesta.body);
    //print("RESBODY: " + resBody.toString());
   // var capsules = resBody;

   // print("capsules: " + capsules.toString());
    List<Idioma> _list = List<Idioma>();
    /* 
    _list = capsules.map((model) => Idioma.fromJson(model)).toList(); */
    var idioma = Idioma.fromJson(resBody);
    _list.add(idioma);
  //  print(_list);
    //return idioma;
    return _list;
  }
}
