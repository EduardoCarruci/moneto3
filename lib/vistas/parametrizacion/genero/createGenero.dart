import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:moneto2/models/genero.dart';
import 'package:moneto2/models/user.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/utils/servicioParametrizacion.dart';
import 'package:moneto2/widgets/load.dart';

class CreateGenero extends StatefulWidget {
  User data_user;
  CreateGenero(this.data_user);
  @override
  _PedidosState createState() => new _PedidosState();
}

class _PedidosState extends State<CreateGenero>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  final format = DateFormat("yyyy-MM-dd");
  TextEditingController _nombreController = new TextEditingController();
  Loads loads;
  TextEditingController _codigoController = new TextEditingController();
  ServicioParametrizacion servicio = new ServicioParametrizacion();
  
  final _formKey = GlobalKey<FormState>();
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
    return MaterialApp(
        title: "Moneto",
        theme: ThemeData(
            primarySwatch: Colors.deepPurple, cursorColor: Colors.deepPurple),
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          initialIndex: 0,
          length: 2,
          child: SafeArea(
                      child: Scaffold(
              appBar: AppBar(
                backgroundColor: Constants.darkPrimary,
                title: Text(
                  "Añadir Genero",
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
                              ? MediaQuery.of(context).size.height * 0.3
                              : MediaQuery.of(context).size.height * 0.6,
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
                                          decoration: InputDecoration(
                                              labelText: "Código"),
                                          keyboardType: TextInputType.text,

                                          controller: _codigoController,
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
                                          decoration: InputDecoration(
                                              labelText: "Nombre"),
                                          keyboardType: TextInputType.text,

                                          controller: _nombreController,
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
            ),
          ),
        ));
  }

  save() async{
        if (_formKey.currentState.validate()) {
      Genero nuevo = new Genero();

      Map data = nuevo.convertMap(
        _codigoController.text,
        _nombreController.text
      );

      //al servicio
      await servicio.create(widget.data_user.Token, data, context,'api/Genero/Create');
    } else {
      loads = new Loads(context);
      loads.toast(2, "Los campos son Invalidos");
    }
  }

}
