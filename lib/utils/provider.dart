import 'package:flutter/material.dart';
import 'package:moneto2/models/iep.dart';

class ProviderInfo with ChangeNotifier {
  List<Detalleconcepto> _listado = new List<Detalleconcepto>();

  get listado {
    return _listado;
  }

  set listado(List<Detalleconcepto> listado) {
    this._listado = listado;
    notifyListeners();
  }
}
