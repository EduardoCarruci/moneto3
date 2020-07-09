import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:moneto2/models/tipoCliente.dart';

import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/widgets/load.dart';

class ServicioTipoCliente {
  Loads loads;

  Future<List<TipoCliente>> getAll(String token) async {
    String url = Constants.uri + 'api/TipoCliente/GetListTipoCliente';

    final respuesta =
        await http.get(url, headers: {HttpHeaders.authorizationHeader: token});

     List<TipoCliente> _list;

    var resBody = json.decode(respuesta.body);
    
    var capsules = resBody as List;
    
    _list = capsules.map((model) => TipoCliente.fromJson(model)).toList();
    
    

/*     List<TipoCliente> item = List<TipoCliente>();
    var list = json.decode(respuesta.body);
    print(list);
    for (Map x in list) {
      item.add(TipoCliente.fromJson(x));
 */
      
/*     Map<String, dynamic> resBody = json.decode(respuesta.body);

    List<TipoCliente> _list = List<TipoCliente>();
    
    var item = TipoCliente.fromJson(resBody);
    _list.add(item); */
    
    return _list;
  }
}
