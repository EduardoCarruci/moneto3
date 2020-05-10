import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moneto2/models/moneda.dart';
import 'package:moneto2/models/user.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/utils/servicioParametrizacion.dart';
import 'package:moneto2/widgets/load.dart';

class Editar_Moneda extends StatefulWidget {
  User data_user;
  Moneda moneda;

  Editar_Moneda(this.data_user, this.moneda);
  @override
  _PedidosState createState() => new _PedidosState();
}

class _PedidosState extends State<Editar_Moneda>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin { 
  TextEditingController _NombreController = new TextEditingController();
  TextEditingController _IdentificadorController = new TextEditingController();
  TextEditingController _CodigoController = new TextEditingController();
  ServicioParametrizacion servicio = new ServicioParametrizacion();
  //MyGlobals myGlobals = new MyGlobals();
  final _formKey = GlobalKey<FormState>();
  Loads loads;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    _NombreController = new TextEditingController(text: widget.moneda.nombre);
    _IdentificadorController =
        new TextEditingController(text: widget.moneda.identificador);
    _CodigoController = new TextEditingController(text: widget.moneda.codigo);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Moneda",
        theme: ThemeData(
            primarySwatch: Colors.deepPurple, cursorColor: Colors.deepPurple),
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          initialIndex: 0,
          length: 2,
          child: Scaffold(
            //key: myGlobals.scaffoldKey,
            appBar: AppBar(
              backgroundColor: Constants.darkPrimary,
              title: Text(
                "Editar Moneda",
                style: TextStyle(fontSize: 18),
              ),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  //Regresar();
                },
              ),
              titleSpacing: 0,
              //centerTitle: true,
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
                                            labelText: "Identificador"),
                                        keyboardType: TextInputType.text,

                                        controller: _IdentificadorController,
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

  edit() async {
    if (_formKey.currentState.validate()) {
      Moneda moneda = new Moneda();

      Map data = moneda.convertMapOP(
          widget.moneda.idMoneda.toString(),
          _CodigoController.text,
          _NombreController.text,
          _IdentificadorController.text);

      //OPERACIONES

      await servicio.edit(
          widget.data_user.Token, data, widget.moneda.idMoneda.toString(),context,'api/Monedas/Update/');
    }
    else {
      loads = new Loads(context);
      loads.toast(2, "Los campos son invalidos");
    }
  }

  delete() async {
    if (_formKey.currentState.validate()) {
      Moneda moneda = new Moneda();

      Map data = moneda.convertMapOP(
          widget.moneda.idMoneda.toString(),
          _CodigoController.text,
          _NombreController.text,
          _IdentificadorController.text);

      //OPERACIONES

      await servicio.delete(
          widget.data_user.Token, data, widget.moneda.idMoneda.toString(),context,'api/Monedas/Delete/');
    }
    else {
      loads = new Loads(context);
      loads.toast(2, "Los campos son invalidos");
    }
  }
}
