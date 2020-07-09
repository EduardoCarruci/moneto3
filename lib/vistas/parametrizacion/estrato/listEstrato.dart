import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moneto2/models/estrato.dart';

import 'package:moneto2/models/user.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/vistas/parametrizacion/estrato/createEstrato.dart';
import 'package:moneto2/vistas/parametrizacion/estrato/editEstrato.dart';
import 'package:moneto2/vistas/parametrizacion/estrato/servicio.dart';
import 'package:moneto2/vistas/principales/parametizacion.dart';



class ListEstrato extends StatefulWidget {
  User user;
  ListEstrato(this.user);

  @override
  _ListState createState() => new _ListState();
}

class _ListState extends State<ListEstrato> with WidgetsBindingObserver {
  ServicioEstrato servicio = new ServicioEstrato();
  Estrato item;

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
      onWillPop: () async => false,child: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.darkPrimary,
          title: Text(
            "Estrato Economico",
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
                        builder: (context) => CreateEstrato(widget.user))); 
              },
            ),
          ],
        ),
        body: FutureBuilder(
          future: servicio.getAll(widget.user.Token),
          builder:
              (BuildContext context, AsyncSnapshot<List<Estrato>> snapshot) {
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
      )),
    );
  }

  Widget _buildListView(List<Estrato> list) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          Estrato profile = list[index];
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: GestureDetector(
              onTap: () {
                item = new Estrato(
                  idEstrato: list[index].idEstrato,
                  codigo: list[index].codigo,
                  nombre: list[index].nombre,
                  //id: list[index].id,
                );
               /*  print(item.idFranquicia);
                 print(item.codigo);
                  print(item.descripcion); */

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            EditEstrato(widget.user, item)));  
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
