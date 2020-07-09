import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:moneto2/models/departamento.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/widgets/load.dart';

class ServiceDpto {
  Loads loads;

  Future<List<Departamento>> getAll(String token, String id) async {
    String url = Constants.uri + 'api/geografia/GetListDepartamento?idPais=' + id;

    final response =
        await http.get(url, headers: {HttpHeaders.authorizationHeader: token});

    List<Departamento> item =
        List<Departamento>();
    var list = json.decode(response.body);
    for (Map x in list) {
      item.add(Departamento.fromMap(x));
    }
 
    return item;
    //return _list;
  }
}
