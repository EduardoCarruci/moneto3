import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:moneto2/models/color.dart';
import 'package:moneto2/models/color.dart';
import 'package:moneto2/utils/Const.dart';

import 'package:moneto2/widgets/load.dart';

class ServicioColor {
  Loads loads;

  Future<List<ColorApp>> getAll(String token) async {
    String url = Constants.uri + 'api/ColorApp/GetListColorApp';

    final respuesta =
        await http.get(url, headers: {HttpHeaders.authorizationHeader: token});

    List<ColorApp> _list;

    var resBody = json.decode(respuesta.body);

    var capsules = resBody as List;

    _list = capsules.map((model) => ColorApp.fromJson(model)).toList();

    return _list;
  }

  Future<List<ColorApp>> getUnique(
      String token, String idColorApp) async {
        print("COLOR APP: "+idColorApp);
    String url = Constants.uri + 'api/ColorApp/GetColorApp/'+idColorApp;
    print(url);
    final respuesta =
        await http.get(url, headers: {HttpHeaders.authorizationHeader: token});
    print("RESPUESTA: " + respuesta.toString());

    var resBody = json.decode(respuesta.body);
    print(resBody);
    var v = ColorApp.fromJson(resBody);
    
    /* print("RESBODY: " + resBody.toString());
    var capsules = resBody;

    print("capsules: " + capsules.toString());
    List<ColorApp> _list = List<ColorApp>();
    /* 
    _list = capsules.map((model) => Idioma.fromJson(model)).toList(); */
    var colors = ColorApp.fromJson(resBody);
    _list.add(colors);
    print(_list); */
    //return idioma;
    //return _list;
  
  }
}
