import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moneto2/models/estrato.dart';
import 'package:moneto2/models/user.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/utils/servicioParametrizacion.dart';
import 'package:moneto2/widgets/load.dart';

import 'listEstrato.dart';

class CreateEstrato extends StatefulWidget {
  User data_user;
  CreateEstrato(this.data_user);
  @override
  _CreateState createState() => new _CreateState();
}

class _CreateState extends State<CreateEstrato>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  TextEditingController _NombrerController = new TextEditingController();
  TextEditingController _CodigoController = new TextEditingController();
  ServicioParametrizacion servicio = new ServicioParametrizacion();
  Loads loads;
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

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
                "Añadir Estrato",
                style: TextStyle(fontSize: 18),
              ),
              centerTitle: true,
              titleSpacing: 0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ListEstrato(widget.data_user)));
                },
              ),
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
                    height: MediaQuery.of(context).orientation ==
                            Orientation.portrait
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

                              controller: _NombrerController,
                              textInputAction: TextInputAction.next,
                              onChanged: (va) {},
                              // focusNode: _local,
                            ),
                            flex: 3,
                          ),
                          Expanded(
                            child: TextFormField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Requerido';
                                }
                                return null;
                              },
                              decoration: InputDecoration(labelText: "Código "),
                              keyboardType: TextInputType.text,

                              controller: _CodigoController,
                              textInputAction: TextInputAction.done,
                              onChanged: (va) {},
                              // focusNode: _local,
                            ),
                            flex: 3,
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ))),
          ),
        ));
  }

  save() async {
    if (_formKey.currentState.validate()) {
      Estrato nuevo = new Estrato();

      ///_NombrerController
      Map data = nuevo.convertMap(
        _CodigoController.text,
        _NombrerController.text,
      );

      //al servicio
      var success = await servicio.create(
          widget.data_user.Token, data, context, 'api/Estrato/Create');

      if (success == "200") {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ListEstrato(widget.data_user)));
      }
    } else {
      loads = new Loads(context);
      loads.toast(2, "Los campos son Invalidos");
    }
  }
}
