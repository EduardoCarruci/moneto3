import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:moneto2/models/categoria.dart';
import 'package:moneto2/models/user.dart';
import 'package:moneto2/vistas/principales/parametizacion.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/vistas/parametrizacion/categoria/createCategoria.dart';
import 'package:moneto2/vistas/parametrizacion/categoria/editCategoria.dart';
import 'package:moneto2/vistas/parametrizacion/categoria/servicio.dart';

class List_categoria extends StatefulWidget {
  User user;
  List_categoria(this.user);

  @override
  _List_categoriaState createState() => new _List_categoriaState();
}

class _List_categoriaState extends State<List_categoria>
    with WidgetsBindingObserver {
  ServicioCategoria servicio = new ServicioCategoria();
  Categoria item;

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
            "Categorias",
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
                        builder: (context) => CreateCategoria(widget.user)));
              },
            ),
          ],
        ),
        body: FutureBuilder(
          future: servicio.getAll(widget.user.Token),
          builder:
              (BuildContext context, AsyncSnapshot<List<Categoria>> snapshot) {
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

  Widget _buildListView(List<Categoria> list) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          Categoria profile = list[index];
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: GestureDetector(
              onTap: () {
              
            
                item = new Categoria(
                  id: list[index].id,
                  codigo: list[index].codigo,
                  nombre: list[index].nombre,
                  /* subnivel: list[index].subnivel,
                  ponderar: list[index].ponderar, */
                );
                print(item);
                  print(item.codigo);
                print(item.nombre);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            EditCategoria(widget.user, item)));
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
