import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneto2/models/categoria.dart';
import 'package:moneto2/models/user.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/utils/servicioParametrizacion.dart';
import 'package:moneto2/widgets/load.dart';
import 'package:moneto2/vistas/parametrizacion/categoria/listCategorias.dart';

class CreateCategoria extends StatefulWidget {
  User data_user;
  CreateCategoria(this.data_user);
  @override
  _createCategoriaState createState() => new _createCategoriaState();
}

class _createCategoriaState extends State<CreateCategoria>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  final format = DateFormat("yyyy-MM-dd");

  TextEditingController _NombreController = new TextEditingController();

  /*  TextEditingController _subNivelController = new TextEditingController(); */

  TextEditingController _codigoController = new TextEditingController();

  /* TextEditingController _PonderacionController = new TextEditingController(); */
  Loads loads;
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
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Constants.darkPrimary,
            title: Text(
              "Añadir Categoría",
              style: TextStyle(fontSize: 18),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            List_categoria(widget.data_user)));
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
                  height:
                      MediaQuery.of(context).orientation == Orientation.portrait
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
                        /*   Expanded(
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Requerido';
                              }
                              return null;
                            },
                            decoration:
                                InputDecoration(labelText: "SubNivel"),
                            keyboardType: TextInputType.text,

                            controller: _subNivelController,
                            textInputAction: TextInputAction.next,
                            onChanged: (va) {},
                            // focusNode: _local,
                          ),
                          flex: 3,
                        ), */
                        Expanded(
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Requerido';
                              }
                              return null;
                            },
                            decoration: InputDecoration(labelText: "Codigo"),
                            keyboardType: TextInputType.text,

                            controller: _codigoController,
                            textInputAction: TextInputAction.next,
                            onChanged: (va) {},
                            // focusNode: _local,
                          ),
                          flex: 3,
                        ),
                        /* Expanded(
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Requerido';
                              }
                              return null;
                            },
                            decoration:
                                InputDecoration(labelText: "Ponderación "),
                            keyboardType: TextInputType.number,

                            controller: _PonderacionController,
                            textInputAction: TextInputAction.done,
                            onChanged: (va) {},
                            // focusNode: _local,
                          ),
                          flex: 3,
                        ), */
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ))),
        ));
  }

  save() async {
    if (_formKey.currentState.validate()) {
      Categoria nuevo = new Categoria();

      Map data =
          nuevo.convertMap(_codigoController.text, _NombreController.text);

      var success = await servicio.create(
          widget.data_user.Token, data, context, 'api/categorias/Create');
      if (success == "200") {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => List_categoria(widget.data_user)));
      }
    } else {
      loads = new Loads(context);
      loads.toast(2, "Los campos son Invalidos");
    }
  }
}
