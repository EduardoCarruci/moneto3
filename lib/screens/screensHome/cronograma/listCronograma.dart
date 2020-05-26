import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moneto2/models/cronograma.dart';
import 'package:moneto2/models/geografia.dart';
import 'package:moneto2/models/idiomas.dart';
import 'package:moneto2/models/user.dart';
import 'package:moneto2/screens/screensHome/cronograma/create.dart';
import 'package:moneto2/screens/screensHome/cronograma/editcronograma.dart';
import 'package:moneto2/screens/screensHome/cronograma/servicio.dart';
import 'package:moneto2/utils/Const.dart';

import 'package:moneto2/vistas/parametrizacion/idiomas/createIdiomas.dart';
import 'package:moneto2/vistas/parametrizacion/idiomas/editIdioma.dart';
import 'package:moneto2/vistas/parametrizacion/idiomas/servicio.dart';

class ListCronograma extends StatefulWidget {
  User user;
  ListCronograma(this.user);

  @override
  _ListState createState() => new _ListState();
}

class _ListState extends State<ListCronograma> with WidgetsBindingObserver {
  ServicioCronograma servicio = new ServicioCronograma();
  Cronograma item;

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
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.darkPrimary,
        title: Text(
          "Listado de Cronogramas",
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
                      builder: (context) => CreateCronograma(widget.user)));
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: servicio.getAll(widget.user.Token),
        builder:
            (BuildContext context, AsyncSnapshot<List<Cronograma>> snapshot) {
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

  Widget _buildListView(List<Cronograma> list) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          Cronograma profile = list[index];
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: GestureDetector(
              onTap: () {
                /*
    {$id: 4, idCronograma: 14, fecha: 2020-05-14T00:00:00,
     actividad: Quincenal, idAlarma: 1, 
     idCategoria: 2, categoria: categoría de calendario 2,
     idRecurrencia: 2, recurrencia: Quincenal, 
     dia: , dialargo: no encontrado} */
                item = new Cronograma(
                  idCronograma: list[index].idCronograma,
                  fecha: list[index].fecha,
                  actividad: list[index].actividad,
                  idAlarma: list[index].idAlarma,
                  idCategoria: list[index].idCategoria,
                  categoria: list[index].categoria,
                  idRecurrencia: list[index].idRecurrencia,
                  recurrencia: list[index].recurrencia,
                  dia: list[index].dia,
                  dialargo: list[index].dialargo,
                  //id: list[index].id,
                );

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            EditCronograma(widget.user, item)));
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        profile.actividad,
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
