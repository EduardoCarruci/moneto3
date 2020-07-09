import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moneto2/models/idiomas.dart';
import 'package:moneto2/models/user.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/vistas/parametrizacion/idiomas/createIdiomas.dart';
import 'package:moneto2/vistas/parametrizacion/idiomas/editIdioma.dart';
import 'package:moneto2/vistas/parametrizacion/idiomas/servicio.dart';
import 'package:moneto2/vistas/principales/parametizacion.dart';

class ListIdioma extends StatefulWidget {
  User user;
  ListIdioma(this.user);

  @override
  _ListState createState() => new _ListState();
}

class _ListState extends State<ListIdioma> with WidgetsBindingObserver {
  ServicioIdiomas servicio = new ServicioIdiomas();
  Idioma item;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    print(widget.user.id.toString());
    print(widget.user.nombre.toString());
    print(widget.user.Token.toString());
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
            "Idiomas",
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
                        builder: (context) => CrearIdioma(widget.user)));
              },
            ),
          ],
        ),
        body: FutureBuilder(
          future: servicio.getAll(widget.user.Token),
          builder:
              (BuildContext context, AsyncSnapshot<List<Idioma>> snapshot) {
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

  Widget _buildListView(List<Idioma> list) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          Idioma profile = list[index];
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: GestureDetector(
              onTap: () {
                item = new Idioma(
                  idIdioma: list[index].idIdioma,
                  descripcion: list[index].descripcion,
                  nombreCampo: list[index].nombreCampo,
                  equivalencia: list[index].equivalencia,
                  //id: list[index].id,
                );

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditIdioma(widget.user, item)));
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
