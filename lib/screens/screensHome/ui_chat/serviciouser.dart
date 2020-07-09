import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:moneto2/models/messages/messages_create.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/widgets/load.dart';


class ServicioMessagesUser {
  Loads loads;
 
 


  Future<List<MessageUser>> getMessagesUser(int idusuario) async {
   String url = Constants.uri + 'api/mensaje/GetListChat_Mensaje_Usuario?idusuario=' + idusuario.toString();

    final respuesta = await http.get(url);

    List<MessageUser> _list;

    var resBody = json.decode(respuesta.body);
      print(respuesta.body);
    var capsules = resBody as List;

    _list = capsules.map((model) => MessageUser.fromJson(model)).toList();


    //print(_list);
   

    return _list;
  }
}
