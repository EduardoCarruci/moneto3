import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneto2/models/metadata.dart';
import 'package:moneto2/models/tipoDeIdentificacion.dart';
import 'package:moneto2/models/user.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/utils/servicioParametrizacion.dart';
import 'package:moneto2/widgets/load.dart';

class CreateMetadata extends StatefulWidget {
  User data_user;
  CreateMetadata(this.data_user);
  @override
  _Create createState() =>
      new _Create();
}

class _Create extends State<CreateMetadata>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  final format = DateFormat("yyyy-MM-dd");

  TextEditingController _NombreController = new TextEditingController();
  TextEditingController _CodigoController = new TextEditingController();
   TextEditingController _NombreCampoController = new TextEditingController();
  TextEditingController _NombreEquivalenciaController = new TextEditingController();


  ServicioParametrizacion servicio = new ServicioParametrizacion();
  Loads loads;
  final _formKey = GlobalKey<FormState>();
  List<String> _Config = new List();

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
          child: SafeArea(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Constants.darkPrimary,
                title: Text(
                  "Crear  Metadata",
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
                height:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? MediaQuery.of(context).size.height * 1
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
                                              labelText: "Codigo "),
                                          keyboardType: TextInputType.text,

                                          controller: _CodigoController,
                                          textInputAction: TextInputAction.done,
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
                                              labelText: "Nombre Metadata"),
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

                                          controller: _NombreCampoController,
                                          textInputAction: TextInputAction.done,
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
                                              labelText: "Nombre Equivalencia "),
                                          keyboardType: TextInputType.text,

                                          controller: _NombreEquivalenciaController,
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
          ),
        ));
  }

//String codigo, String nombreMetadata,String nombreCampo, String nombreEquivalencia
   save() async {
    if (_formKey.currentState.validate()) {
      Metadata nuevo = new Metadata();

      Map data = nuevo.convertMap(_CodigoController.text,
          _NombreController.text,_NombreCampoController.text,_NombreEquivalenciaController.text);

      //al servicio
      await servicio.create(widget.data_user.Token, data, context,'api/Metadata/Create');
    } else {
      loads = new Loads(context);
      loads.toast(2, "Los campos son Invalidos");
    }
  }
}
