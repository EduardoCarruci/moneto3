import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneto2/models/moneda.dart';
import 'package:moneto2/models/user.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/utils/servicioParametrizacion.dart';
import 'package:moneto2/vistas/parametrizacion/moneda/listmonedas.dart';
import 'package:moneto2/widgets/load.dart';

class Crear_Moneda extends StatefulWidget {
  User data_user;
  Crear_Moneda(this.data_user);
  @override
  _PedidosState createState() => new _PedidosState();
}

class _PedidosState extends State<Crear_Moneda>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  final format = DateFormat("yyyy-MM-dd");
  TextEditingController _NombreController = new TextEditingController();
  TextEditingController _IdentificadorController = new TextEditingController();
  TextEditingController _CodigoController = new TextEditingController();
  ServicioParametrizacion servicio = new ServicioParametrizacion();
  Loads loads;

  final _formKey = GlobalKey<FormState>();

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
        title: "Moneda",
        theme: ThemeData(
            primarySwatch: Colors.deepPurple, cursorColor: Colors.deepPurple),
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          initialIndex: 0,
          length: 2,
          child: WillPopScope(
              onWillPop: () async => false,
                      child: Scaffold(
              appBar: AppBar(
                backgroundColor: Constants.darkPrimary,
                title: Text(
                  "Añadir Moneda",
                  style: TextStyle(fontSize: 18),
                ),
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ListMoneda(widget.data_user)));
                  },
                ),
                titleSpacing: 0,
                centerTitle: true,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.save),
                    onPressed: () {
                      _save();
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
          ),
        ));
  }

  _save() async {
    if (_formKey.currentState.validate()) {
      Moneda moneda = new Moneda();

      Map data = moneda.convertMap(_CodigoController.text,
          _NombreController.text, _IdentificadorController.text);

      //al servicio
      var success =await servicio.create(widget.data_user.Token, data, context,'api/Monedas/Create');
        if (success == "200"){
           Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ListMoneda(widget.data_user)));
        }
    } else {
      loads = new Loads(context);
      loads.toast(2, "Completa los Campos");
    }
  }
}
