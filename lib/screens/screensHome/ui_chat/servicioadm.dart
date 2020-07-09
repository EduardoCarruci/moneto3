import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:moneto2/models/messages/messages_admin.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/widgets/load.dart';


class ServiceMessagesAdm {
  Loads loads;
 
 
  final _popularesStreamController = StreamController<List<MessagesAdm>>.broadcast();


  Function(List<MessagesAdm>) get popularesSink => _popularesStreamController.sink.add;

  Stream<List<MessagesAdm>> get popularesStream => _popularesStreamController.stream;


  void disposeStreams() {
    _popularesStreamController?.close();
  }


  Future<List<MessagesAdm>> getMessagesAdm() async {
   String url = Constants.uri + 'api/mensaje/GetListChat_Administrador';

    final respuesta = await http.get(url);

    List<MessagesAdm> _list;

    var resBody = json.decode(respuesta.body);
      print(respuesta.body);
    var capsules = resBody as List;

    _list = capsules.map((model) => MessagesAdm.fromJson(model)).toList();


    //print(_list);
    popularesSink( _list );

    return _list;
  }
}
