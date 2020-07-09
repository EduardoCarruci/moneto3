import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:moneto2/models/iep.dart';
import 'package:moneto2/models/referencias.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/widgets/load.dart';

class ServicioIEP {
  Loads loads;

  Future<List<OperacionesFinancieras>> getAll(String token,String idOperacion,String idUser) async {
    // 'http://198.72.112.52/Monetapi/api/usuarios/Login?mail=${_usuarioController.text.trim()}&password=${_passwordController.text}',
    String url = Constants.uri +
        'api/OperacionesFinancieras/GetListOperacionesFinancieras?idCategoriaPadre=${idOperacion.toString()}&IdUsuario=${idUser.toString()}';
    
    final response = await http.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader: token,
      },
    );
  
    List<OperacionesFinancieras> _operacionesFinancieras =
        List<OperacionesFinancieras>();
    var list = json.decode(response.body);
    for (Map x in list) {
      _operacionesFinancieras.add(OperacionesFinancieras.fromMap(x));
    }

    return _operacionesFinancieras;
  }

    Future<List<Referencias>> getForRef(String token,String idUser) async {
    // 'http://198.72.112.52/Monetapi/api/usuarios/Login?mail=${_usuarioController.text.trim()}&password=${_passwordController.text}',
    String url = Constants.uri +
        'api/operacionesfinancieras/GetListOperacionesFinancierasIngresoEgresoSinReferenciar?IdUsuario=${idUser.toString()}';

    final response = await http.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader: token,
      },
    );
   // print(response.body);
    List<Referencias> _item =
        List<Referencias>();
    var list = json.decode(response.body);
    for (Map x in list) {
      _item.add(Referencias.fromMap(x));
    }
  //print(response.body);
    return _item;
  }
}
