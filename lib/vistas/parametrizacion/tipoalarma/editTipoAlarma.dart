import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:math' show Random;

import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:moneto2/models/tipoAlarma.dart';
import 'package:moneto2/models/user.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/utils/servicioParametrizacion.dart';
import 'package:moneto2/vistas/parametrizacion/tipoalarma/listTipoAlarma.dart';
import 'package:moneto2/widgets/load.dart';

class EditTipoAlarma extends StatefulWidget {
  User data_user;
  TipoAlarma m_tipo_alarma;

  EditTipoAlarma(this.data_user, this.m_tipo_alarma);
  @override
  _EdTipoAlarmaState createState() => new _EdTipoAlarmaState();
}

class _EdTipoAlarmaState extends State<EditTipoAlarma> {
  final format = DateFormat("yyyy-MM-dd");

  TextEditingController _NombreController = new TextEditingController();
  TextEditingController _CodigoController = new TextEditingController();
  ServicioParametrizacion servicio = new ServicioParametrizacion();

  Loads loads;

  @override
  void initState() {
    super.initState();
    _NombreController =
        new TextEditingController(text: widget.m_tipo_alarma.nombre);
    _CodigoController =
        new TextEditingController(text: widget.m_tipo_alarma.codigo);
  }

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Constants.darkPrimary,
            title: Text(
              "Editar Tipos de Alarmas",
              style: TextStyle(fontSize: 18),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ListTipoAlarma(widget.data_user)));
              },
            ),
            titleSpacing: 0,
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  edit();
                },
                iconSize: 20,
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  delete();
                },
                iconSize: 20,
              ),
            ],
          ),
          body: SingleChildScrollView(
              child: Container(
                  height: 200,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Requerido';
                              }
                              return null;
                            },
                            decoration: InputDecoration(labelText: "Nombre"),
                            keyboardType: TextInputType.text,

                            controller: _NombreController,
                            textInputAction: TextInputAction.next,
                            onChanged: (va) {},

                            // focusNode: _local,
                          ),
                          flex: 3,
                        ),
                        Expanded(
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Requerido';
                              }
                              return null;
                            },
                            decoration: InputDecoration(labelText: "Código "),
                            keyboardType: TextInputType.text,

                            controller: _CodigoController,
                            textInputAction: TextInputAction.done,
                            onChanged: (va) {},

                            // focusNode: _local,
                          ),
                          flex: 3,
                        ),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ))),
        ));
  }

  edit() async {
    if (_formKey.currentState.validate()) {
      TipoAlarma item = new TipoAlarma();

      Map data = item.convertMapOP(widget.m_tipo_alarma.idTipoAlarma.toString(),
          _CodigoController.text, _NombreController.text);

      await servicio.edit(
          widget.data_user.Token,
          data,
          widget.m_tipo_alarma.idTipoAlarma.toString(),
          context,
          'api/TipoAlarma/Update/');
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ListTipoAlarma(widget.data_user)));
    } else {
      loads = new Loads(context);
      loads.toast(2, "Los campos son invalidos");
    }
  }

  delete() async {
    await servicio.delete(
        widget.data_user.Token,
        widget.m_tipo_alarma.idTipoAlarma.toString(),
        context,
        'api/TipoAlarma/Delete/');
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ListTipoAlarma(widget.data_user)));
  }
}
