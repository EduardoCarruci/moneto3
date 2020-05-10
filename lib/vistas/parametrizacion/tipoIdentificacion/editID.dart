import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneto2/models/tipoDeIdentificacion.dart';
import 'package:moneto2/models/user.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/utils/servicioParametrizacion.dart';
import 'package:moneto2/widgets/load.dart';

class Editar_T_identificacion extends StatefulWidget {
  User data_user;
  TipoIdentificacion item;
  Editar_T_identificacion(this.data_user, this.item);
  @override
  _Editar_T_identificacionState createState() =>
      new _Editar_T_identificacionState();
}

class _Editar_T_identificacionState extends State<Editar_T_identificacion>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  final format = DateFormat("yyyy-MM-dd");

  TextEditingController _NombreController = new TextEditingController();
  TextEditingController _CodigoController = new TextEditingController();
  ServicioParametrizacion servicio = new ServicioParametrizacion();
  Loads loads;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    _NombreController = new TextEditingController(text: widget.item.nombre);
    _CodigoController = new TextEditingController(text: widget.item.codigo);
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
                  "Editar Identificacion",
                  style: TextStyle(fontSize: 18),
                ),
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
                  child: Container(
                height:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? MediaQuery.of(context).size.height * 0.3
                        : MediaQuery.of(context).size.height * 0.6,
                padding: EdgeInsets.symmetric(horizontal: 10),
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
                ),
              )),
            ),
          ),
        ));
  }

  update() async {
    if (_formKey.currentState.validate()) {
      TipoIdentificacion nuevo = new TipoIdentificacion();

      Map data = nuevo.convertMapOP(
        widget.item.idTipoIdentificacion.toString(),
        _CodigoController.text,
        _NombreController.text,
      );

      await servicio.edit(widget.data_user.Token, data,
          widget.item.idTipoIdentificacion.toString(), context,'api/TipoIdentificacion/Update/');
    } else {
      loads = new Loads(context);
      loads.toast(2, "Los campos son invalidos");
    }
  }

  delete() async {
    if (_formKey.currentState.validate()) {
      TipoIdentificacion nuevo = new TipoIdentificacion();

      Map data = nuevo.convertMapOP(
        widget.item.idTipoIdentificacion.toString(),
        _CodigoController.text,
        _NombreController.text,
      );

      await servicio.delete(widget.data_user.Token, data,
          widget.item.idTipoIdentificacion.toString(), context,'api/TipoIdentificacion/Delete/');
    } else {
      loads = new Loads(context);
      loads.toast(2, "Los campos son invalidos");
    }
  }
}
