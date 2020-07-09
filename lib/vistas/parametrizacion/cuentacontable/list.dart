import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moneto2/models/cuentacontable.dart';
import 'package:moneto2/models/user.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/vistas/parametrizacion/cuentacontable/create.dart';
import 'package:moneto2/vistas/parametrizacion/cuentacontable/edit.dart';
import 'package:moneto2/vistas/parametrizacion/cuentacontable/servicio.dart';
import 'package:moneto2/vistas/principales/parametizacion.dart';

class ListCuentaContable extends StatefulWidget {
  User user;
  ListCuentaContable(this.user);

  @override
  _ListState createState() => new _ListState();
}

class _ListState extends State<ListCuentaContable> with WidgetsBindingObserver {
  ServicioCuentaContable servicio = new ServicioCuentaContable();
  CuentaContablePadre item;

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
        child: SafeArea(
            child: Scaffold(
          appBar: AppBar(
            backgroundColor: Constants.darkPrimary,
            title: Text(
              "Cuenta Contable",
              style: TextStyle(fontSize: 18),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Parametizacion(widget.user)));
              },
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CreateCuentaContable(widget.user)));
                },
              ),
            ],
          ),
          body: FutureBuilder(
            future: servicio.getAll(widget.user.Token),
            builder: (BuildContext context,
                AsyncSnapshot<List<CuentaContablePadre>> snapshot) {
              if (snapshot.hasData) {
                return _buildListView(snapshot.data);
              } else {
                return Center(
                  //ACA DEBERIA ESTAR EL EVENTO DE CARGAR LAS IMAGENES
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        )));
  }

  Widget _buildListView(List<CuentaContablePadre> list) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          CuentaContablePadre profile = list[index];
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: GestureDetector(
              onTap: () {
                item = new CuentaContablePadre(
                  idCuentaContable: list[index].idCuentaContable,
                  nombre: list[index].nombre,
                  codigo: list[index].codigo,
                  idtipoCliente: list[index].idtipoCliente,
                  idtipoCategoria: list[index].idtipoCategoria,
                  tipoCategoria: list[index].tipoCategoria,
                  //id: list[index].id,
                );

                print(item.idCuentaContable.toString());
                print(item.nombre.toString());
                print(item.codigo.toString());
                print(item.idtipoCliente.toString());
                print(item.idtipoCategoria.toString());
                print(item.tipoCategoria.toString());

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            EditCuentaContable(widget.user, item)));
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        profile.nombre,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: list.length,
      ),
    );
  }
}
