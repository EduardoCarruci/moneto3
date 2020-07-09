import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moneto2/models/genero.dart';
import 'package:moneto2/models/user.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/utils/servicioParametrizacion.dart';
import 'package:moneto2/vistas/parametrizacion/genero/ListGenero.dart';
import 'package:moneto2/widgets/load.dart';

class EditGenero extends StatefulWidget {
  User user;
  Genero m_genero;

  EditGenero(this.user, this.m_genero);
  @override
  _Editar_GeneroState createState() => new _Editar_GeneroState();
}

class _Editar_GeneroState extends State<EditGenero>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  TextEditingController _NombreController = new TextEditingController();
  TextEditingController _IdentificadorController = new TextEditingController();
  TextEditingController _CodigoController = new TextEditingController();
  ServicioParametrizacion servicio = new ServicioParametrizacion();
  final _formKey = GlobalKey<FormState>();
  List<String> _ConfigUpdate = new List();
  List<String> _ConfigDelete = new List();
  Loads loads;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();

    _NombreController = new TextEditingController(text: widget.m_genero.nombre);
    _CodigoController =
        new TextEditingController(text: widget.m_genero.codigo.toString());
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
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Constants.darkPrimary,
              title: Text(
                "Editar Genero",
                style: TextStyle(fontSize: 18),
              ),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ListGenero(widget.user)));
                },
              ),
              titleSpacing: 0,
              //centerTitle: true,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    update();
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
              height: MediaQuery.of(context).orientation == Orientation.portrait
                  ? MediaQuery.of(context).size.height * 1.1
                  : MediaQuery.of(context).size.height * 2,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: <Widget>[
                  //Primera parte fecha , valor,concepto y cuenta

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
                                        decoration: InputDecoration(
                                            labelText: "Código"),
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
                                        decoration: InputDecoration(
                                            labelText: "Nombre"),
                                        keyboardType: TextInputType.text,

                                        controller: _NombreController,
                                        textInputAction: TextInputAction.done,
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
        ));
  }

  delete() async {
    await servicio.delete(widget.user.Token,
        widget.m_genero.idGenero.toString(), context, 'api/Genero/Delete/');
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ListGenero(widget.user)));
  }

  update() async {
    if (_formKey.currentState.validate()) {
      Genero item = new Genero();
      Map data = item.convertMapOP(
        widget.m_genero.idGenero.toString(),
        _CodigoController.text,
        _NombreController.text,
      );

      var success = await servicio.edit(widget.user.Token, data,
          widget.m_genero.idGenero.toString(), context, 'api/Genero/Update/');
      if (success == "200") {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ListGenero(widget.user)));
      }
    } else {
      loads = new Loads(context);
      loads.toast(2, "Los campos son invalidos");
    }
  }
}
