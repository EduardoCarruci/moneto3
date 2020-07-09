import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneto2/models/cronograma.dart';
import 'package:moneto2/models/user.dart';
import 'package:moneto2/screens/screensHome/cronograma/create.dart';
import 'package:moneto2/screens/screensHome/cronograma/editcronograma.dart';
import 'package:moneto2/screens/screensHome/cronograma/servicio.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/vistas/principales/home.dart';

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
            "Listado de Cronogramas",
            style: TextStyle(fontSize: 18),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Home(widget.user)));
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
          future: servicio.getAll(
              widget.user.Token, widget.user.idUsuario.toString()),
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
      )),
    );
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
                    idUsuario: list[index].idUsuario,
                    fechafinalizacion: list[index].fechafinalizacion
                    //id: list[index].id,
                    );

                // var newFormat = DateFormat("yyyy-MM-dd");

                /*       final format = DateFormat("yyyy-MM-dd");
                print(format.format(DateTime.parse(item.fecha.toString()))); */
/* 
                print(item.fecha);
                print(item.fechafinalizacion);
                String updatedDt =
                    format.format(DateTime.parse(item.fecha.toString()));
                print(updatedDt); */
              //
                print(item.fecha);
                print(item.fechafinalizacion);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            EditCronograma(widget.user, item))); 
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    profile.actividad,
                    style: TextStyle(color: Colors.black, fontSize: 16),
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
