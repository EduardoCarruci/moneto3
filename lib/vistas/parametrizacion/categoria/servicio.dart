import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:moneto2/models/categoria.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/widgets/load.dart';

class ServicioCategoria {
  Loads loads;

  Future<List<Categoria>> getAll(String token) async {
    String url = Constants.uri + 'api/Categorias/GetListCategoria';

    final respuesta =
        await http.get(url, headers: {HttpHeaders.authorizationHeader: token});

    List<Categoria> _list;

    var resBody = json.decode(respuesta.body);

    var capsules = resBody as List;

    _list = capsules.map((model) => Categoria.fromJson(model)).toList();


    return _list;
  }


  Future<List<Categoria>> getUnique(String token, String id) async {
    String url = Constants.uri + 'api/Categorias/GetCategoria/' +id.toString();
    print(url);
    final respuesta =
        await http.get(url, headers: {HttpHeaders.authorizationHeader: token});
  

    Map<String, dynamic> resBody = json.decode(respuesta.body);

    List<Categoria> _list = List<Categoria>();
    
    var item = Categoria.fromJson(resBody);
    _list.add(item);
    print(_list);
   
    return _list;
  }

}
