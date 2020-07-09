import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneto2/models/metadata.dart';
import 'package:moneto2/models/tipoDeIdentificacion.dart';
import 'package:moneto2/models/user.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/utils/servicioParametrizacion.dart';
import 'package:moneto2/widgets/load.dart';

import 'listmetadata.dart';

class EditMetadata extends StatefulWidget {
  User data_user;

  Metadata item;

  EditMetadata(this.data_user, this.item);

  @override
  _Edit createState() => new _Edit();
}

class _Edit extends State<EditMetadata>
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
                                    InputDecoration(labelText: "Codigo "),
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
      Metadata nuevo = new Metadata();
//int idMetadata, String codigo, String nombreMetadata,
      //String nombreCampo, String nombreEquivalencia
      Map data = nuevo.convertMapOP(
        widget.item.idCabeceraMetadata,
        _CodigoController.text,
        _NombreController.text,
      );

      await servicio.edit(
          widget.data_user.Token,
          data,
          widget.item.idCabeceraMetadata.toString(),
          context,
          'api/CabeceraMetadatas/Update/');
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ListMetadata(widget.data_user)));
    } else {
      loads = new Loads(context);
      loads.toast(2, "Los campos son invalidos");
    }
  }

  delete() async {
    await servicio.delete(
        widget.data_user.Token,
        widget.item.idCabeceraMetadata.toString(),
        context,
        'api/CabeceraMetadatas/Delete/');
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ListMetadata(widget.data_user)));
  }
}
