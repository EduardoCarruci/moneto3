import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:moneto2/models/localidad.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/widgets/load.dart';

class ServiceLocalidad {
  Loads loads;

  Future<List<Localidad>> getAll(String token, String id) async {
    String url = Constants.uri + 'api/geografia/GetListLocalidad?idmunicipio=' + id;

    final response =
        await http.get(url, headers: {HttpHeaders.authorizationHeader: token});

    List<Localidad> item =
        List<Localidad>();
    var list = json.decode(response.body);
    for (Map x in list) {
      item.add(Localidad.fromMap(x));
    }
 
    return item;
    //return _list;
  }
}
