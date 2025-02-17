import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneto2/models/categoriaCalendario.dart';
import 'package:moneto2/models/user.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/utils/servicioParametrizacion.dart';
import 'package:moneto2/vistas/parametrizacion/categoriaCalendario/listCategoriaCalendario.dart';
import 'package:moneto2/widgets/load.dart';

class EditCategoriaCalendario extends StatefulWidget {
  User data_user;
  CategoriaCalendario actual;

  EditCategoriaCalendario(this.data_user, this.actual);
  @override
  _Ed_CategoriaState createState() => new _Ed_CategoriaState();
}

class _Ed_CategoriaState extends State<EditCategoriaCalendario> {
  final format = DateFormat("yyyy-MM-dd");

  TextEditingController _NombreController = new TextEditingController();
  TextEditingController _CodigoController = new TextEditingController();
  ServicioParametrizacion servicio = new ServicioParametrizacion();
  Loads loads;

  @override
  void initState() {
    super.initState();
    _NombreController = new TextEditingController(text: widget.actual.nombre);
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
              "Editar Categoría Calendario",
              style: TextStyle(fontSize: 18),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                    Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ListCategoriaCalendario(widget.data_user)));
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
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ))),
        ));
  }

  edit() async {
    if (_formKey.currentState.validate()) {
      CategoriaCalendario item = new CategoriaCalendario();

      Map data = item.convertMapOP(
          widget.actual.idCategoriaCalendario.toString(),
          _NombreController.text);

     var success = await servicio.edit(
          widget.data_user.Token,
          data,
          widget.actual.idCategoriaCalendario.toString(),
          context,
          "api/CategoriaCalendario/Update/");

          
      if (success == "200") {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ListCategoriaCalendario(widget.data_user)));
      }
          
          
    } else {
      loads = new Loads(context);
      loads.toast(2, "Los campos son invalidos");
    }
  }

  delete() async {
  

      await servicio.delete(
          widget.data_user.Token,
          
          widget.actual.idCategoriaCalendario.toString(),
          context,
          "api/CategoriaCalendario/Delete/");

            Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ListCategoriaCalendario(widget.data_user)));
  
  }
}
