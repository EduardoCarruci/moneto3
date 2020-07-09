import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:moneto2/models/messages/messages_detalle.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/widgets/load.dart';


class ServicioChat {
  Loads loads;
  
    final _popularesStreamController = StreamController<List<MessageDetalle>>.broadcast();

  Function(List<MessageDetalle>) get popularesSink => _popularesStreamController.sink.add;

  Stream<List<MessageDetalle>> get popularesStream => _popularesStreamController.stream;


  void disposeStreams() {
    _popularesStreamController?.close();
  }

  Future<List<MessageDetalle>> getmessageschat(int idmensaje) async {
    String url = Constants.uri +
        'api/mensaje/GetListChat_MensajeDetalle?idmensaje=' +
        idmensaje.toString();

    final respuesta = await http.get(url);
    //print(respuesta.body);
    List<MessageDetalle> _list;

    var resBody = json.decode(respuesta.body);
    //print(respuesta.body);
    var capsules = resBody as List;

    _list = capsules.map((model) => MessageDetalle.fromJson(model)).toList();
   // print(respuesta.body);
    //print(_list);
    print(respuesta.body);
    popularesSink( _list );
    return _list;
  }

    

}
