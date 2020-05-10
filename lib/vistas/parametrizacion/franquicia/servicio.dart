import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:moneto2/models/franquicia.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/widgets/load.dart';

class ServicioFranquicia {
  Loads loads;

  Future<List<Franquicia>> getAll(String token) async {
    String url = Constants.uri + 'api/Franquicia/GetListFranquicia';


    final respuesta =
        await http.get(url, headers: {HttpHeaders.authorizationHeader: token});

    List<Franquicia> _list;

    var resBody = json.decode(respuesta.body);

    var capsules = resBody as List;
    
    _list = capsules.map((model) => Franquicia.fromJson(model)).toList();
    print(capsules);
    print(resBody);
    print(_list);
     return _list;
  }
}
