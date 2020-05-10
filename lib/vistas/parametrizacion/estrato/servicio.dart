import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:moneto2/models/estrato.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/widgets/load.dart';

class ServicioEstrato{
  Loads loads;

  Future<List<Estrato>> getAll(String token) async {
    String url = Constants.uri + 'api/Estrato/GetListEstrato';


    final respuesta =
        await http.get(url, headers: {HttpHeaders.authorizationHeader: token});

    List<Estrato> _list;

    var resBody = json.decode(respuesta.body);

    var capsules = resBody as List;
    
    _list = capsules.map((model) => Estrato.fromJson(model)).toList();
    
     return _list;
  }
}
