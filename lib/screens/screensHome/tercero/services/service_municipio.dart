import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:moneto2/models/municipio.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/widgets/load.dart';

class ServiceMunicipio {
  Loads loads;

  Future<List<Municipio>> getAll(String token, String id) async {
    String url = Constants.uri + 'api/geografia/GetListMunicipio?iddepartamento=' + id;

    final response =
        await http.get(url, headers: {HttpHeaders.authorizationHeader: token});

    List<Municipio> item =
        List<Municipio>();
    var list = json.decode(response.body);
    for (Map x in list) {
      item.add(Municipio.fromMap(x));
    }
   // print(item);
    return item;
    //return _list;
  }
}
