import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:moneto2/models/estrato.dart';
import 'package:moneto2/models/franquicia.dart';
import 'package:moneto2/models/tipoAlarma.dart';
import 'package:moneto2/models/user.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/utils/servicioParametrizacion.dart';
import 'package:moneto2/widgets/load.dart';

class EditEstrato extends StatefulWidget {
  User data_user;
  Estrato estrato;

  EditEstrato(this.data_user, this.estrato);
  @override
  _EditState createState() => new _EditState();
}

class _EditState extends State<EditEstrato> {
  final format = DateFormat("yyyy-MM-dd");

  TextEditingController _NombreController = new TextEditingController();
  TextEditingController _CodigoController = new TextEditingController();
  ServicioParametrizacion servicio = new ServicioParametrizacion();

  Loads loads;

  @override
  void initState() {
    super.initState();
    _NombreController =
        new TextEditingController(text: widget.estrato.nombre);
    _CodigoController =
        new TextEditingController(text: widget.estrato.codigo);
  }

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Moneto2",
        theme: ThemeData(
            primarySwatch: Colors.deepPurple, cursorColor: Colors.deepPurple),
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          initialIndex: 0,
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Constants.darkPrimary,
              title: Text(
                "Editar Estrato",
                style: TextStyle(fontSize: 18),
              ),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
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
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    delete();
                  },
                  iconSize: 20,
                ),
              ],
            ),
            body: SingleChildScrollView(
                child: Container(
                    height: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? MediaQuery.of(context).size.height * 0.25
                        : MediaQuery.of(context).size.height * 2,
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
                              decoration: InputDecoration(labelText: "Código"),
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
          ),
        ));
  }

    edit() async {
    if (_formKey.currentState.validate()) {
      Estrato item = new Estrato();

      Map data = item.convertMapOP(
        widget.estrato.idEstrato.toString(),
        _CodigoController.text,
        _NombreController.text
      );

      await servicio.edit(widget.data_user.Token, data,
          widget.estrato.idEstrato.toString(), context,'api/Estrato/Update/');
    } else {
      loads = new Loads(context);
      loads.toast(2, "Los campos son invalidos");
    }
  }

  delete() async {
    if (_formKey.currentState.validate()) {
         Estrato item = new Estrato();


          Map data = item.convertMapOP(
        widget.estrato.idEstrato.toString(),
        _CodigoController.text,
        _NombreController.text
      );
      await servicio.delete(widget.data_user.Token, data,
            widget.estrato.idEstrato.toString(), context,'api/Estrato/Delete/');
    } else {
      loads = new Loads(context);
      loads.toast(2, "Los campos son invalidos");
    }
  }
}
