import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moneto2/models/color.dart';
import 'package:moneto2/models/idiomas.dart';
import 'package:moneto2/models/tipoCliente.dart';
import 'package:moneto2/models/user.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/utils/servicioParametrizacion.dart';
import 'package:moneto2/vistas/parametrizacion/color/servicio.dart';
import 'package:moneto2/vistas/parametrizacion/idiomas/servicio.dart';
import 'package:moneto2/vistas/parametrizacion/metadata/servicio.dart';

import 'package:moneto2/widgets/load.dart';

class EditCliente extends StatefulWidget {
  User data_user;

  TipoCliente item;

  EditCliente(this.data_user, this.item);

  @override
  _Edit createState() => new _Edit();
}

class _Edit extends State<EditCliente>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  TextEditingController _NombreController = new TextEditingController();

  TextEditingController _CodigoController = new TextEditingController();

  ServicioParametrizacion servicio = new ServicioParametrizacion();

  ServicioIdiomas servicioIdioma = new ServicioIdiomas();
  ServicioMetadata servicioMetadata = new ServicioMetadata();
  ServicioColor servicioColor = new ServicioColor();

  Loads loads;

  final _formKey = GlobalKey<FormState>();

  String opcionidioma = "Seleccionar";
  String idIdioma;

  String opcionColor = "Seleccionar";
  String idColor;

  List<Idioma> _listIdiomas;
  List<ColorApp> _listColorApp;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    print(widget.data_user.id.toString());

    _NombreController = new TextEditingController(text: widget.item.nombre);
    _CodigoController = new TextEditingController(text: widget.item.codigo);
    /**
     * "idIdioma" : "1",
"idColorAPP" : "1",

     * 
     */
    idIdioma = widget.item.idIdioma.toString();
    idColor = widget.item.idColorApp.toString();
    getIdiomas();
/* 
   
    getColorsAPP(); */

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  Future<void> getIdiomas() async {
    _listIdiomas = await servicioIdioma.getUniqueIdioma(
        widget.data_user.Token, widget.item.idIdioma.toString());

    print("LIST IDIOMAS EN FUNCION: " + _listIdiomas.toString());
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
                  "Editar Tipo Cliente",
                  style: TextStyle(fontSize: 18),
                ),
                centerTitle: true,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
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
                            style:
                                TextStyle(color: Colors.black54, fontSize: 16),
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
                            "Nombre:",
                            style:
                                TextStyle(color: Colors.black54, fontSize: 16),
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
                      /*    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            "Idioma:",
                            style:
                                TextStyle(color: Colors.black54, fontSize: 16),
                          ),
                          FutureBuilder<List<Idioma>>(
                              initialData: _listIdiomas,
                              future:
                                  servicioIdioma.getAll(widget.data_user.Token),
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
                                                  color: Colors.black,
                                                  fontSize: 16),
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
 */
                      /*
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            "Colores:",
                            style:
                                TextStyle(color: Colors.black54, fontSize: 16),
                          ),
                          FutureBuilder<List<ColorApp>>(
                              future:
                                  servicioColor.getAll(widget.data_user.Token),
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
                                                  color: Colors.black,
                                                  fontSize: 16),
                                            ),
                                            value: data,
                                          ))
                                      .toList(),
                                  onChanged: (ColorApp value) {
                                    idColor = value.idColorAPP.toString();
                                    opcionColor = value.nombre;

                                    /*  idMetadata =
                                                    value.idMetadata.toString();
                                                print(value.idMetadata);
                                                print(value.nombreCampo);
                                                opcionMetadata = value.nombreCampo;  */
                                    setState(() {});
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
                    */
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  update() async {
    /*  if (_formKey.currentState.validate()) {
      Metadata nuevo = new Metadata();

      Map data = nuevo.convertMapOP(
        widget.item.idMetadata,
        _CodigoController.text,
        _NombreController.text,
        _NombreCampoController.text,
        _NombreEquivalenciaController.text,
      );

      await servicio.edit(widget.data_user.Token, data,
          widget.item.idMetadata.toString(), context, 'api/Metadata/Update/');
    } else {
      loads = new Loads(context);
      loads.toast(2, "Los campos son invalidos");
    } */
  }

  delete() async {
    /*   if (_formKey.currentState.validate()) {
      Metadata nuevo = new Metadata();

       Map data = nuevo.convertMapOP(
        widget.item.idMetadata,
        _CodigoController.text,
        _NombreController.text,
        _NombreCampoController.text,
        _NombreEquivalenciaController.text,
      );

      await servicio.delete(widget.data_user.Token, data,
          widget.item.idMetadata.toString(), context,'api/Metadata/Delete/');
    } else {
      loads = new Loads(context);
      loads.toast(2, "Los campos son invalidos");
    }  */
  }
}
