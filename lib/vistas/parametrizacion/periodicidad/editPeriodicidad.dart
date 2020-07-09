import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneto2/models/periodicidad.dart';
import 'package:moneto2/models/user.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/utils/servicioParametrizacion.dart';
import 'package:moneto2/widgets/load.dart';
import 'package:moneto2/vistas/parametrizacion/periodicidad/listperiodicidad.dart';

class Editr_Periodicidad extends StatefulWidget {
  User data_user;
  Periodicidad periodicidad;
  Editr_Periodicidad(this.data_user, this.periodicidad);
  @override
  _PedidosState createState() => new _PedidosState();
}

class _PedidosState extends State<Editr_Periodicidad>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  final format = DateFormat("yyyy-MM-dd");
  TextEditingController _EquivalenciaController = new TextEditingController();
  TextEditingController _NombreController = new TextEditingController();
  TextEditingController _CodigoController = new TextEditingController();
  ServicioParametrizacion servicio = new ServicioParametrizacion();

  final _formKey = GlobalKey<FormState>();
  Loads loads;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    _EquivalenciaController = new TextEditingController(
        text: widget.periodicidad.equivalencia.toString());
    _NombreController =
        new TextEditingController(text: widget.periodicidad.nombre);
    _CodigoController =
        new TextEditingController(text: widget.periodicidad.codigo);
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
          child: SafeArea(
            child: WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Constants.darkPrimary,
                  title: Text(
                    "Editar periodo",
                    style: TextStyle(fontSize: 18),
                  ),
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ListPeriodicidad(widget.data_user)));
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
                  height:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? MediaQuery.of(context).size.height * 0.5
                          : MediaQuery.of(context).size.height * 2,
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
                                  keyboardType: TextInputType.number,

                                  controller: _EquivalenciaController,
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
          ),
        ));
  }

  edit() async {
    if (_formKey.currentState.validate()) {
      Periodicidad item = new Periodicidad();

      Map data = item.convertMapOP(
          widget.periodicidad.idPeriodicidad.toString(),
          _CodigoController.text,
          _NombreController.text,
          _EquivalenciaController.text);

      var success = await servicio.edit(
          widget.data_user.Token,
          data,
          widget.periodicidad.idPeriodicidad.toString(),
          context,
          'api/Periodicidad/Update/');
      if (success == "200") {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ListPeriodicidad(widget.data_user)));
      }
    } else {
      loads = new Loads(context);
      loads.toast(2, "Los campos son invalidos");
    }
  }

  delete() async {
    await servicio.delete(
        widget.data_user.Token,
        widget.periodicidad.idPeriodicidad.toString(),
        context,
        'api/Periodicidad/Delete/');

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ListPeriodicidad(widget.data_user)));
  }
}
