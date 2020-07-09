import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moneto2/models/tipoAlarma.dart';
import 'package:moneto2/models/user.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/utils/servicioParametrizacion.dart';
import 'package:moneto2/widgets/load.dart';

import 'listTipoAlarma.dart';

class Crear_Tipo_Alarma extends StatefulWidget {
  User data_user;
  Crear_Tipo_Alarma(this.data_user);
  @override
  _CreateState createState() => new _CreateState();
}

class _CreateState extends State<Crear_Tipo_Alarma>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  TextEditingController _NombreController = new TextEditingController();
  TextEditingController _CodigoController = new TextEditingController();
  ServicioParametrizacion servicio = new ServicioParametrizacion();
  Loads loads;
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Constants.darkPrimary,
              title: Text(
                "Añadir Tipo Alarma",
                style: TextStyle(fontSize: 18),
              ),
              centerTitle: true,
              titleSpacing: 0,
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
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.save),
                  onPressed: () {
                    save();
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
          ),
        ));
  }

  save() async {
    if (_formKey.currentState.validate()) {
      TipoAlarma nuevo = new TipoAlarma();

      Map data = nuevo.convertMap(
        _CodigoController.text,
        _NombreController.text,
      );

      //al servicio
      await servicio.create(
          widget.data_user.Token, data, context, 'api/TipoAlarma/Create');
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ListTipoAlarma(widget.data_user)));
    } else {
      loads = new Loads(context);
      loads.toast(2, "Los campos son Invalidos");
    }
  }
}
