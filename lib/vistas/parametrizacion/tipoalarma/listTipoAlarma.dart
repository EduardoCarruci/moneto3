import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moneto2/models/tipoAlarma.dart';
import 'package:moneto2/models/user.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/vistas/parametrizacion/tipoalarma/createTipoAlarma.dart';
import 'package:moneto2/vistas/parametrizacion/tipoalarma/editTipoAlarma.dart';
import 'package:moneto2/vistas/parametrizacion/tipoalarma/servicio.dart';

class ListTipoAlarma extends StatefulWidget {
  User user;
  ListTipoAlarma(this.user);

  @override
  _ListState createState() => new _ListState();
}

class _ListState extends State<ListTipoAlarma> with WidgetsBindingObserver {
  ServicioTipoAlarma servicio = new ServicioTipoAlarma();
  TipoAlarma item;

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
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.darkPrimary,
        title: Text(
          "Tipo Alarma",
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Crear_Tipo_Alarma(widget.user)));
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: servicio.getAll(widget.user.Token),
        builder:
            (BuildContext context, AsyncSnapshot<List<TipoAlarma>> snapshot) {
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
    ));
  }

  Widget _buildListView(List<TipoAlarma> list) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          TipoAlarma profile = list[index];
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: GestureDetector(
              onTap: () {
                item = new TipoAlarma(
                  idTipoAlarma: list[index].idTipoAlarma,
                  nombre: list[index].nombre,
                  codigo: list[index].codigo,
                  //id: list[index].id,
                );
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            EditTipoAlarma(widget.user, item)));  
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
