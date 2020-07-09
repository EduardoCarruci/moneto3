import 'package:flutter/material.dart';
import 'package:moneto2/models/periodicidad.dart';
import 'package:moneto2/models/user.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/vistas/parametrizacion/periodicidad/editPeriodicidad.dart';
import 'package:moneto2/vistas/parametrizacion/periodicidad/servicio.dart';
import 'package:moneto2/vistas/principales/parametizacion.dart';

import 'createPeriodicidad.dart';

class ListPeriodicidad extends StatefulWidget {
  User data_user;
  ListPeriodicidad(this.data_user);

  @override
  _ListPeriodicidadState createState() => _ListPeriodicidadState();
}

class _ListPeriodicidadState extends State<ListPeriodicidad> with WidgetsBindingObserver {
  ServicioPeriodicidad apiService = new ServicioPeriodicidad();
  Periodicidad item;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:() async => false,
          child: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.darkPrimary,
          title: Text(
            "Periodicidad",
            style: TextStyle(fontSize: 18),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Parametizacion(widget.data_user)));

            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Crear_periodicidad(widget.data_user)));
              },
            ),
          ],
        ),
        body: FutureBuilder(
          future: apiService.getAll(widget.data_user.Token),
          builder: (BuildContext context, AsyncSnapshot<List<Periodicidad>> snapshot) {
            if (snapshot.hasData ) {
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

  Widget _buildListView(List<Periodicidad> list) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          Periodicidad profile = list[index];
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: GestureDetector(
              onTap: () {
                // PARA IR AL EDITAR
               item = new Periodicidad(
                    idPeriodicidad: list[index].idPeriodicidad,
                     codigo: list[index].codigo,
                      nombre: list[index].nombre,
                       equivalencia: list[index].equivalencia,
                    );
              
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Editr_Periodicidad(widget.data_user, item)));

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
