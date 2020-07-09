import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moneto2/models/cabecerametadata.dart';
import 'package:moneto2/models/color.dart';
import 'package:moneto2/models/idiomas.dart';
import 'package:moneto2/models/metadata.dart';
import 'package:moneto2/models/tipoCliente.dart';

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:moneto2/models/user.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/utils/servicioParametrizacion.dart';
import 'package:moneto2/vistas/parametrizacion/cabeceraMetadata/servicio.dart';
import 'package:moneto2/vistas/parametrizacion/color/servicio.dart';
import 'package:moneto2/vistas/parametrizacion/idiomas/servicio.dart';
import 'package:moneto2/vistas/parametrizacion/metadata/servicio.dart';
import 'package:moneto2/widgets/load.dart';
import 'package:moneto2/vistas/parametrizacion/tipocliente/list.dart';

class CreateTipoCliente extends StatefulWidget {
  User data_user;
  CreateTipoCliente(this.data_user);
  @override
  _Crear createState() => new _Crear();
}

class _Crear extends State<CreateTipoCliente>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  TextEditingController _NombreController = new TextEditingController();

  TextEditingController _CodigoController = new TextEditingController();

  ServicioParametrizacion servicio = new ServicioParametrizacion();

  ServicioIdiomas servicioIdioma = new ServicioIdiomas();
  ServicioCabeceraMetadata servicioMetadata = new ServicioCabeceraMetadata();
  ServicioColor servicioColor = new ServicioColor();

  Loads loads;

  final _formKey = GlobalKey<FormState>();

  String opcionidioma = "Seleccionar";
  String idIdioma;

  String opcionMetadata = "Seleccionar";
  String idMetadata;

  String opcionColor = "Seleccionar";
  String idColor;

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
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.darkPrimary,
          title: Text(
            "Añadir Tipo Cliente",
            style: TextStyle(fontSize: 18),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ListTipoCliente(widget.data_user)));
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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      "Codigo:",
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                    Container(
                      //color: Colors.red,
                      width: width * 0.30,
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Requerido';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Codigo",
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.text,

                        controller: _CodigoController,
                        textInputAction: TextInputAction.done,
                        onChanged: (va) {},
                        // focusNode: _local,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      "Tipo Cliente:",
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                    Container(
                      //color: Colors.red,
                      width: width * 0.30,
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Requerido';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Nombre",
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.text,

                        controller: _NombreController,
                        textInputAction: TextInputAction.done,
                        onChanged: (va) {},
                        // focusNode: _local,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      "Idioma:",
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                    FutureBuilder<List<Idioma>>(
                        future: servicioIdioma.getAll(widget.data_user.Token),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Idioma>> snapshot) {
                          if (!snapshot.hasData)
                            return CircularProgressIndicator();
                          return DropdownButton<Idioma>(
                            itemHeight: 50,
                            style: TextStyle(color: Colors.black),
                            items: snapshot.data
                                .map((data) => DropdownMenuItem<Idioma>(
                                      child: Text(
                                        data.descripcion,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                      ),
                                      value: data,
                                    ))
                                .toList(),
                            onChanged: (Idioma value) {
                              idIdioma = value.idIdioma.toString();
                              print(value.idIdioma);
                              print(value.descripcion);
                              opcionidioma = value.descripcion;
                              setState(() {});
                            },
                            isExpanded: false,
                            hint: Text(
                              opcionidioma,
                              style: TextStyle(fontSize: 16),
                            ),
                            icon: Icon(Icons.arrow_downward),
                            /*  value: value[],
                                            hint: Text(""), */
                          );
                        }),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      "Metadata:",
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                    FutureBuilder<List<CabeceraMetadata>>(
                        future: servicioMetadata
                            .getCabeceraMetadata(widget.data_user.Token),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<CabeceraMetadata>> snapshot) {
                          if (!snapshot.hasData)
                            return CircularProgressIndicator();
                          return DropdownButton<CabeceraMetadata>(
                            itemHeight: 50,
                            style: TextStyle(color: Colors.black),
                            items: snapshot.data
                                .map((data) =>
                                    DropdownMenuItem<CabeceraMetadata>(
                                      child: Text(
                                        data.nombre,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                      ),
                                      value: data,
                                    ))
                                .toList(),
                            onChanged: (CabeceraMetadata value) {
                              idMetadata = value.idCabeceraMetadata.toString();
                              print(value.idCabeceraMetadata);
                              print(value.nombre);
                              opcionMetadata = value.nombre;
                              setState(() {});
                            },
                            isExpanded: false,
                            hint: Text(
                              opcionMetadata,
                              style: TextStyle(fontSize: 16),
                            ),
                            icon: Icon(Icons.arrow_downward),
                            /*  value: value[],
                                            hint: Text(""), */
                          );
                        }),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      "Colores:",
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    FutureBuilder<List<ColorApp>>(
                        future: servicioColor.getAll(widget.data_user.Token),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<ColorApp>> snapshot) {
                          if (!snapshot.hasData)
                            return CircularProgressIndicator();
                          return DropdownButton<ColorApp>(
                            itemHeight: 50,
                            style: TextStyle(color: Colors.black),
                            items: snapshot.data
                                .map((data) => DropdownMenuItem<ColorApp>(
                                      child: Text(
                                        data.nombre,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                      ),
                                      value: data,
                                    ))
                                .toList(),
                            onChanged: (ColorApp value) {
                              idColor = value.idColorAPP.toString();
                              opcionColor = value.nombre;
                              setState(() {});
                              print(opcionColor.toString());
                              print(idColor.toString());
                            },
                            isExpanded: false,
                            hint: Text(
                              opcionColor,
                              style: TextStyle(fontSize: 16),
                            ),
                            icon: Icon(Icons.arrow_downward),
                            /*  value: value[],
                                            hint: Text(""), */
                          );
                        }),
                  ],
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  save() async {
    if (_formKey.currentState.validate() 
        && opcionidioma != "Seleccionar" 
        && opcionMetadata != "Seleccionar"
        && opcionColor != "Seleccionar"
        ) {
      TipoCliente nuevo = new TipoCliente();

      Map data = nuevo.convertMap(_CodigoController.text.trim(),
          _NombreController.text.trim(), idIdioma, idColor, idMetadata);

      var success= await servicio.create(
          widget.data_user.Token, data, context, 'api/TipoCliente/Create');
          if (success =="200"){
 Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ListTipoCliente(widget.data_user)));
          }
     
    } else {
      loads = new Loads(context);
      loads.toast(2, "Los campos son Invalidos");
    }
  }
}
