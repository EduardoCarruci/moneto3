import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:moneto2/models/medioDePago.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/widgets/load.dart';

class ServicioMedioDePago {
  Loads loads;

  Future<List<MedioDePago>> getAll(String token) async {
    String url = Constants.uri + 'api/TipoMedioPago/GetListTipoMedioPago';

    final respuesta =
        await http.get(url, headers: {HttpHeaders.authorizationHeader: token});

    List<MedioDePago> _list;

    var resBody = json.decode(respuesta.body);

    var capsules = resBody as List;

    _list = capsules.map((model) => MedioDePago.fromJson(model)).toList();


    return _list;
  }

 

 
}
