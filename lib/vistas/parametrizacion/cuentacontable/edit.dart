import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneto2/models/cuentacontable.dart';
import 'package:moneto2/models/cuentacontablehijo.dart';
import 'package:moneto2/models/tipoCliente.dart';
import 'package:moneto2/models/user.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/utils/servicioParametrizacion.dart';
import 'package:moneto2/vistas/parametrizacion/cuentacontable/servicio.dart';
import 'package:moneto2/vistas/parametrizacion/tipocliente/servicio.dart';
import 'package:moneto2/widgets/load.dart';
import 'package:moneto2/vistas/parametrizacion/cuentacontable/list.dart';
class EditCuentaContable extends StatefulWidget {
  User user;
  CuentaContablePadre item;

  EditCuentaContable(this.user, this.item);
  @override
  _CreateState createState() => new _CreateState();
}

class _CreateState extends State<EditCuentaContable>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  final format = DateFormat("yyyy-MM-dd");
  TextEditingController _NombreController = new TextEditingController();
  TextEditingController _CodigoController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Loads loads;
  ServicioParametrizacion servicio = new ServicioParametrizacion();
  ServicioTipoCliente servicioTipoCLiente = new ServicioTipoCliente();
  ServicioCuentaContable servicioCuentaContable = new ServicioCuentaContable();
  String opcionCliente = "Seleccionar";
  int idTipoCliente;
  bool bandera = true;
  bool pivote = false;
  int idpadre;
   String value = "1";

  int idCuentaContableHijo;
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _NombreController.text = widget.item.nombre;
    _CodigoController.text = widget.item.codigo;
    idTipoCliente = widget.item.idtipoCliente;
    value = widget.item.idtipoCategoria.toString();
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
      onWillPop: () async => false,child:Scaffold(
          appBar: AppBar(
            backgroundColor: Constants.darkPrimary,
            title: Text(
              "Editar Cuenta Contable",
              style: TextStyle(fontSize: 18),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
               Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ListCuentaContable(widget.user)));
              },
            ),
            titleSpacing: 0,
            centerTitle: true,
            actions: <Widget>[
              Visibility(
                visible: bandera,
                child: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    edit();
                  },
                  iconSize: 20,
                ),
              ),
              /*  IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  delete();
                },
                iconSize: 20,
              ), */
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
                        child: SingleChildScrollView(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Text(
                                    "Cuentas Contables Hijos: ",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: FutureBuilder<
                                              List<CuentaContableHijo>>(
                                          future: servicioCuentaContable
                                              .getAllHijos(widget.user.Token,
                                                  widget.item.idCuentaContable),
                                          builder: (BuildContext context,
                                              AsyncSnapshot<
                                                      List<CuentaContableHijo>>
                                                  snapshot) {
                                            if (!snapshot.hasData)
                                              return CircularProgressIndicator();
                                            return DropdownButton<
                                                CuentaContableHijo>(
                                              itemHeight: 50,
                                              style: TextStyle(
                                                  color: Colors.black),
                                              items: snapshot.data
                                                  .map((data) =>
                                                      DropdownMenuItem<
                                                          CuentaContableHijo>(
                                                        child: Text(
                                                          data.nombre,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16),
                                                        ),
                                                        value: data,
                                                      ))
                                                  .toList(),
                                              onChanged:
                                                  (CuentaContableHijo value) {
                                                bandera = false;
                                                _NombreController.text =
                                                    value.nombre;
                                                _CodigoController.text =
                                                    value.codigo;
                                                opcionCliente = value.nombre;
                                                idpadre = value.idpadre;
                                                pivote = true;
                                                idCuentaContableHijo = value.idCuentaContable;

                                                print("ID DAD: " +
                                                    idpadre.toString());

                                                setState(() {});
                                              },
                                              isExpanded: true,
                                              hint: Text(
                                                opcionCliente,
                                                style: TextStyle(fontSize: 16),
                                              ),
                                              icon: Icon(Icons.arrow_downward),
                                              /*  value: value[],
                                                  hint: Text(""), */
                                            );
                                          }),
                                    ),
                                  )
                                ],
                              ),
                              Visibility(
                                 visible: bandera,
                                                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Text("Categoria: ",style: TextStyle(fontSize: 16.0)),
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
                              ),

                              SizedBox(
                                height: 20.0,
                              ),
                              Visibility(
                                visible: bandera,
                                child: Center(
                                  child: CupertinoButton(
                                      color: Constants.darkPrimary,
                                      child: Text(
                                        "Agregar Nuevo Hijo",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0),
                                      ),
                                      onPressed: () {
                                        print("codigo para agregar hijo");
                                        createHijo();
                                      }),
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Visibility(
                                visible: pivote,
                                child: Center(
                                  child: CupertinoButton(
                                      color: Constants.darkPrimary,
                                      child: Text(
                                        "Editar Hijo",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0),
                                      ),
                                      onPressed: () {
                                        editHijo();
                                      }),
                                ),
                              )
                            ],
                          ),
                        ),
                      )),
                ),
              ],
            ),
          )),
        ));
  }

  edit() async {
    if (_formKey.currentState.validate()) {
      CuentaContablePadre item = new CuentaContablePadre();

      Map data = item.convertMapOP(
          _CodigoController.text.toString().trim(),
          _NombreController.text.toString().trim(),
          widget.item.idCuentaContable,int.parse(value),1,null);
      print(data);
        await servicio.edit(
          widget.user.Token,
          data,
          widget.item.idCuentaContable.toString(),
          context,
          'api/CuentaContable/Update/');  
    } else {
      loads = new Loads(context);
      loads.toast(2, "Los campos son invalidos");
    }
  }

  editHijo() async {
    if (_formKey.currentState.validate()) {
      /*  CuentaContableHijo item = new CuentaContableHijo();

      Map data = item.convertMapOP(_CodigoController.text.toString().trim(),
          _NombreController.text.toString().trim(), 0, idpadre); */
          //String codigo, String nombre,int idcuentacontable,int idcategoria,int espadre,int idpadre
      CuentaContablePadre item = new CuentaContablePadre();
      Map data = item.convertMapOP(
        _CodigoController.text.toString().trim(),
        _NombreController.text.toString().trim(),
       idCuentaContableHijo,
       int.parse(value),
        0,
        widget.item.idCuentaContable       
      );
      print(data);
       await servicio.edit(
          widget.user.Token,
          data,
          widget.item.idCuentaContable.toString(),
          context,
          'api/CuentaContable/Update/'); 
          
  Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ListCuentaContable(widget.user)));
    } else {
      loads = new Loads(context);
      loads.toast(2, "Los campos son invalidos");
    } 
  }

  createHijo() async {
    if (_formKey.currentState.validate()) {
      CuentaContableHijo item = new CuentaContableHijo();
      //String codigo, String nombre, int espadre, int idpadre
      Map data = item.convertMap(
          _CodigoController.text.toString().trim(),
          _NombreController.text.toString().trim(),
          0,
          widget.item.idCuentaContable);
      print(data);
      await servicio.edit(
          widget.user.Token,
          data,
          widget.item.idCuentaContable.toString(),
          context,
          'api/CuentaContable/Create/');
           Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ListCuentaContable(widget.user)));
    } else {
      loads = new Loads(context);
      loads.toast(2, "Los campos son invalidos");
    }
  }

  delete() async {}
}
