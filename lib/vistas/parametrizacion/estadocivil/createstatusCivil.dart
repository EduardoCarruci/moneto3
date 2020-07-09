import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneto2/models/estadocivil.dart';
import 'package:moneto2/models/user.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/utils/servicioParametrizacion.dart';
import 'package:moneto2/widgets/load.dart';

import 'listEstadoCivil.dart';

class CreateEstadoCivil extends StatefulWidget {
  User data_user;

  CreateEstadoCivil(this.data_user);

  @override
  _Crear_Estado_CivilState createState() => new _Crear_Estado_CivilState();
}

class _Crear_Estado_CivilState extends State<CreateEstadoCivil>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  final format = DateFormat("yyyy-MM-dd");
  TextEditingController _NombreController = new TextEditingController();
  TextEditingController _CodigoController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Loads loads;
  ServicioParametrizacion servicio = new ServicioParametrizacion();
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
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
              "Crear Estado Civil",
              style: TextStyle(fontSize: 18),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ListEstadoCivil(widget.data_user)));
              },
            ),
            titleSpacing: 0,
            centerTitle: true,
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
            height: MediaQuery.of(context).orientation == Orientation.portrait
                ? MediaQuery.of(context).size.height * 1.1
                : MediaQuery.of(context).size.height * 2,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1),
                  child: Container(
                      height: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? MediaQuery.of(context).size.height * 0.4
                          : MediaQuery.of(context).size.height * 0.4,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Requerido';
                                        }
                                        return null;
                                      },
                                      decoration:
                                          InputDecoration(labelText: "Código"),
                                      keyboardType: TextInputType.text,

                                      controller: _CodigoController,
                                      textInputAction: TextInputAction.next,
                                      onChanged: (va) {},
                                      // focusNode: _local,
                                    ),
                                    flex: 3,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Requerido';
                                        }
                                        return null;
                                      },
                                      decoration:
                                          InputDecoration(labelText: "Nombre"),
                                      keyboardType: TextInputType.text,

                                      controller: _NombreController,
                                      textInputAction: TextInputAction.next,
                                      onChanged: (va) {},
                                      // focusNode: _local,
                                    ),
                                    flex: 3,
                                  ),
                                ],
                              ),
                            ),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      )),
                ),
              ],
            ),
          )),
        ));
  }

  save() async {
    if (_formKey.currentState.validate()) {
      EstadoCivil nuevo = new EstadoCivil();

      Map data =
          nuevo.convertMap(_CodigoController.text, _NombreController.text);

      //al servicio
      var success = await servicio.create(
          widget.data_user.Token, data, context, 'api/EstadoCivil/Create');
      if (success == "200") {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ListEstadoCivil(widget.data_user)));
      }
    } else {
      loads = new Loads(context);
      loads.toast(2, "Los campos son Invalidos");
    }
  }
}
