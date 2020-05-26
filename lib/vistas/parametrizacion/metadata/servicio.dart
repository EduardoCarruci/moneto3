import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:moneto2/models/cabecerametadata.dart';
import 'package:moneto2/models/metadata.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/widgets/load.dart';

class ServicioMetadata {
  Loads loads;

  Future<List<Metadata>> getAll(String token) async {
    String url = Constants.uri + 'api/Metadata/GetListMetadata';

    final respuesta =
        await http.get(url, headers: {HttpHeaders.authorizationHeader: token});
    /*  print(url);
    print(respuesta); */
    List<Metadata> _list;

    var resBody = json.decode(respuesta.body);

    var capsules = resBody as List;

    _list = capsules.map((model) => Metadata.fromJson(model)).toList();
    /*   print(resBody);
        print(capsules);
        print(_list);  */

    return _list;
  }


}
