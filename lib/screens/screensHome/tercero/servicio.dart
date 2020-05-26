import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:moneto2/models/tercero.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/widgets/load.dart';

class ServicioTercero {
  Loads loads;

  Future<List<Tercero>> getAll(String token) async {
    String url = Constants.uri + 'api/Tercero/GetListTercero';

    final respuesta =
        await http.get(url, headers: {HttpHeaders.authorizationHeader: token});

    List<Tercero> _list;

    var resBody = json.decode(respuesta.body);

    var capsules = resBody as List;

    _list = capsules.map((model) => Tercero.fromJson(model)).toList();

    return _list;
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
