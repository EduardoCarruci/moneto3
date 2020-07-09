import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moneto2/models/genero.dart';
import 'package:moneto2/models/user.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/vistas/parametrizacion/genero/createGenero.dart';
import 'package:moneto2/vistas/parametrizacion/genero/editGenero.dart';
import 'package:moneto2/vistas/parametrizacion/genero/servicio.dart';
import 'package:moneto2/vistas/principales/parametizacion.dart';

class ListGenero extends StatefulWidget {
  User user;
  ListGenero(this.user);

  @override
  _ListState createState() => new _ListState();
}

class _ListState extends State<ListGenero> with WidgetsBindingObserver {
  ServicioGenero servicio = new ServicioGenero();
  Genero item;

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
            "Genero",
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
                        builder: (context) => CreateGenero(widget.user)));
              },
            ),
          ],
        ),
        body: FutureBuilder(
          future: servicio.getAll(widget.user.Token),
          builder:
              (BuildContext context, AsyncSnapshot<List<Genero>> snapshot) {
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

  Widget _buildListView(List<Genero> list) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          Genero profile = list[index];
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: GestureDetector(
              onTap: () {
                item = new Genero(
                  idGenero: list[index].idGenero,
                  nombre: list[index].nombre,
                  codigo: list[index].codigo,
                  //id: list[index].id,
                );
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditGenero(widget.user, item)));
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
