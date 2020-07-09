import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneto2/models/cuentacontable.dart';
import 'package:moneto2/models/tipoCliente.dart';
import 'package:moneto2/models/user.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/utils/servicioParametrizacion.dart';
import 'package:moneto2/vistas/parametrizacion/tipocliente/servicio.dart';
import 'package:moneto2/widgets/load.dart';
import 'package:moneto2/vistas/parametrizacion/cuentacontable/list.dart';

class CreateCuentaContable extends StatefulWidget {
  User data_user;

  CreateCuentaContable(this.data_user);

  @override
  _CreateState createState() => new _CreateState();
}

class _CreateState extends State<CreateCuentaContable>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  final format = DateFormat("yyyy-MM-dd");
  TextEditingController _NombreController = new TextEditingController();
  TextEditingController _CodigoController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Loads loads;
  ServicioParametrizacion servicio = new ServicioParametrizacion();
  ServicioTipoCliente servicioTipoCLiente = new ServicioTipoCliente();
  String opcionCliente = "Seleccionar";
  int idTipoCliente;

  String value = "1";
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
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Constants.darkPrimary,
            title: Text(
              "Crear Cuenta Contable",
              style: TextStyle(fontSize: 18),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ListCuentaContable(widget.data_user)));
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
            
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1),
                  child: Container(
                    
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Cuenta Contable: ",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Requerido';
                                        }
                                        return null;
                                      },
                                      /*   decoration: InputDecoration(
                                          labelText: "Nombre"), */
                                      keyboardType: TextInputType.text,

                                      controller: _NombreController,
                                      textInputAction: TextInputAction.next,
                                      onChanged: (va) {},
                                      // focusNode: _local,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Codigo: ",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Requerido';
                                        }
                                        return null;
                                      },
                                      /*   decoration: InputDecoration(
                                          labelText: "Nombre"), */
                                      keyboardType: TextInputType.text,

                                      controller: _CodigoController,
                                      textInputAction: TextInputAction.next,
                                      onChanged: (va) {},
                                      // focusNode: _local,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Text(
                                  "Cliente: ",
                                  style: TextStyle(fontSize: 16),
                                ),
                                Expanded(
                                  child: Container(
                                    child: FutureBuilder<List<TipoCliente>>(
                                        future: servicioTipoCLiente
                                            .getAll(widget.data_user.Token),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<List<TipoCliente>>
                                                snapshot) {
                                          if (!snapshot.hasData)
                                            return CircularProgressIndicator();
                                          return DropdownButton<TipoCliente>(
                                            itemHeight: 50,
                                            style:
                                                TextStyle(color: Colors.black),
                                            items: snapshot.data
                                                .map((data) => DropdownMenuItem<
                                                        TipoCliente>(
                                                      child: Text(
                                                        data.nombre,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16),
                                                      ),
                                                      value: data,
                                                    ))
                                                .toList(),
                                            onChanged: (TipoCliente value) {
                                              idTipoCliente =
                                                  value.idTipoCliente;
                                              print(value.idTipoCliente
                                                  .toString());
                                              print(value.nombre);
                                              opcionCliente = value.nombre;
                                              setState(() {});
                                            },
                                            isExpanded: true,
                                            hint: Text(
                                              opcionCliente,
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            //  icon: Icon(Icons.arrow_downward),
                                            /*  value: value[],
                                                hint: Text(""), */
                                          );
                                        }),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Text("Categoria: ",
                                    style: TextStyle(fontSize: 16.0)),
                                Expanded(
                                  child: Container(
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      items: [
                                        DropdownMenuItem<String>(
                                          child: Text('Ingresos'),
                                          value: '1',
                                        ),
                                        DropdownMenuItem<String>(
                                          child: Text('Egresos'),
                                          value: '2',
                                        ),
                                        DropdownMenuItem<String>(
                                          child: Text('Presupuestos'),
                                          value: '3',
                                        ),
                                      ],
                                      onChanged: (String change) {
                                        value = change;
                                        print(value);
                                        setState(() {});
                                      },
                                      value: value,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),
                ),
              ],
            ),
          )),
        ));
  }

  save() async {
    if (_formKey.currentState.validate()) {
      CuentaContablePadre nuevo = new CuentaContablePadre();
      //String codigo,String nombre, int espadre, int idtipoCliente
      Map data = nuevo.convertMap(
          _CodigoController.text.toString().trim(),
          _NombreController.text.toString().trim(),
          1,
          idTipoCliente,
          int.parse(value));
      print(data);
      //al servicio
       await servicio.create(
          widget.data_user.Token, data, context, 'api/CuentaContable/Create');

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ListCuentaContable(widget.data_user)));
    } else {
      loads = new Loads(context);
      loads.toast(2, "Los campos son Invalidos");
    }
  }
}
