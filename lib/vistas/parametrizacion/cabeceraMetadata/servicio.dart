import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:moneto2/models/cabecerametadata.dart';
import 'package:moneto2/utils/Const.dart';

import 'package:moneto2/widgets/load.dart';

class ServicioCabeceraMetadata {
  Loads loads;

  Future<List<CabeceraMetadata>> getCabeceraMetadata(String token) async {
    String url = Constants.uri + 'api/CabeceraMetadatas/GetListCabeceraMetadata';

    final respuesta =
        await http.get(url, headers: {HttpHeaders.authorizationHeader: token});
     
    List<CabeceraMetadata> _list;

    var resBody = json.decode(respuesta.body);

    var capsules = resBody as List;
   
    
    _list = capsules.map((model) => CabeceraMetadata.fromJson(model)).toList();

    return _list;
  }
}
