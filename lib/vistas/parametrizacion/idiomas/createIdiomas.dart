import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneto2/models/idiomas.dart';
import 'package:moneto2/models/user.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/utils/servicioParametrizacion.dart';
import 'package:moneto2/widgets/load.dart';

class CrearIdioma extends StatefulWidget {
  User data_user;
  CrearIdioma(this.data_user);

  @override
  CreateState createState() => new CreateState();
}

class CreateState extends State<CrearIdioma>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  final format = DateFormat("yyyy-MM-dd");
  TextEditingController _descripcionController = new TextEditingController();
  TextEditingController _nombreCampoController = new TextEditingController();
  TextEditingController _equivalenciaController = new TextEditingController();
  ServicioParametrizacion servicio = new ServicioParametrizacion();
  final _formKey = GlobalKey<FormState>();
  Loads loads;

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
                "Añadir Idioma",
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
                                            labelText: "Descripción"),
                                        keyboardType: TextInputType.text,

                                        controller: _descripcionController,
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
                                            labelText: "Nombre Campo"),
                                        keyboardType: TextInputType.text,

                                        controller: _nombreCampoController,
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
                                            labelText: "Equivalencia"),
                                        keyboardType: TextInputType.text,

                                        controller: _equivalenciaController,
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

                  //Cuarta parte imagenes

                  //quinta parte

                  //sexta parte
                ],
              ),
            )),
          ),
        ));
  }

  save() async {
    if (_formKey.currentState.validate()) {
      Idioma nuevo = new Idioma();

      Map data = nuevo.convertMap(_descripcionController.text.trim(),
          _nombreCampoController.text.trim(), _equivalenciaController.text.trim());
      print(data.toString());
      //al servicio
      print(_descripcionController.text);
      print(_nombreCampoController.text);
      print(_equivalenciaController.text);

        await servicio.create(
          widget.data_user.Token, data, context, 'api/Idioma/Create'); 
    } else {
      loads = new Loads(context);
      loads.toast(2, "Los campos son Invalidos");
    }
  }
}
