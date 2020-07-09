import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:moneto2/models/tercero.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/widgets/load.dart';

class ServicioTercero {
  Loads loads;

    
    final _tercerosStreamController = StreamController<List<Tercero>>.broadcast();

  Function(List<Tercero>) get popularesSink => _tercerosStreamController.sink.add;

  Stream<List<Tercero>> get popularesStream => _tercerosStreamController.stream;


  void disposeStreams() {
    _tercerosStreamController?.close();
  }

  Future<List<Tercero>> getAll(String token) async {
    String url = Constants.uri + 'api/Tercero/GetListTercero';

    final response =
        await http.get(url, headers: {HttpHeaders.authorizationHeader: token});

    List<Tercero> item = List<Tercero>();
    var list = json.decode(response.body);
    for (Map x in list) {
      item.add(Tercero.fromMap(x));
    }

    popularesSink( item );
    
    return item;
  }

  // 'http://198.72.112.52/Monetapi/api/usuarios/Login?mail=${_usuarioController.text.trim()}&password=${_passwordController.text}',
  Future<Tercero> getTerceroByTipoAndNumero(
      String token, String idTipoIdentificacion, String numero) async {
    //String url = Constants.uri + 'api/Tercero/GetTerceroByTipoAndNumero';
    //http://198.72.112.52/Monetapi/api/Tercero/GetTerceroByTipoAndNumero?idTipoIdentificacion=""+&nroIdentificacion=""+numero
    String url =
        'http://198.72.112.52/Monetapi/api/Tercero/GetTerceroByTipoAndNumero?idTipoIdentificacion=${idTipoIdentificacion.toString()}&nroIdentificacion=${numero.toString()}';

    print(url);
    final respuesta =
        await http.get(url, headers: {HttpHeaders.authorizationHeader: token});
    try {
      var resBody = json.decode(respuesta.body);

      Tercero v = Tercero.fromJson(resBody);

      print(resBody);
      print(v);
      print(v.nombre.toString());
      print(v.apellido.toString());
      print(v.mail.toString());
      print(v.telefono.toString());
      print(v.direccion.toString());
      print(v.fechaNacimiento.toString());

      return v;
    } catch (Exception) {
      print(Exception);
    }
  }
}
