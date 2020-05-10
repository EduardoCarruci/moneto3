import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moneto2/models/franquicia.dart';
import 'package:moneto2/models/user.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/vistas/parametrizacion/franquicia/createFranquicia.dart';
import 'package:moneto2/vistas/parametrizacion/franquicia/editFranquicia.dart';
import 'package:moneto2/vistas/parametrizacion/franquicia/servicio.dart';


class ListFranquicia extends StatefulWidget {
  User user;
  ListFranquicia(this.user);

  @override
  _ListState createState() => new _ListState();
}

class _ListState extends State<ListFranquicia> with WidgetsBindingObserver {
  ServicioFranquicia servicio = new ServicioFranquicia();
  Franquicia item;

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
          "Franquicia",
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
                      builder: (context) => CreateFranquicia(widget.user)));
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: servicio.getAll(widget.user.Token),
        builder:
            (BuildContext context, AsyncSnapshot<List<Franquicia>> snapshot) {
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

  Widget _buildListView(List<Franquicia> list) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          Franquicia profile = list[index];
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: GestureDetector(
              onTap: () {
                item = new Franquicia(
                  idFranquicia: list[index].idFranquicia,
                  codigo: list[index].codigo,
                  descripcion: list[index].descripcion,
                  //id: list[index].id,
                );
                print(item.idFranquicia);
                 print(item.codigo);
                  print(item.descripcion);

                 Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            EditFranquicia(widget.user, item))); 
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        profile.descripcion,
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
