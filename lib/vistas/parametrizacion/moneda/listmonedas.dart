import 'package:flutter/material.dart';
import 'package:moneto2/models/moneda.dart';
import 'package:moneto2/models/user.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/vistas/parametrizacion/moneda/servicio.dart';

import 'createMoneda.dart';
import 'editMoneda.dart';

class ListMoneda extends StatefulWidget {
  User data_user;
  ListMoneda(this.data_user);

  @override
  _ListMonedaState createState() => _ListMonedaState();
}

class _ListMonedaState extends State<ListMoneda> with WidgetsBindingObserver {
  ServicioMoneda apiService = new ServicioMoneda();
  Moneda moneda;

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
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.darkPrimary,
        title: Text(
          "Monedas",
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
                      builder: (context) => Crear_Moneda(widget.data_user)));
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: apiService.getMonedas(widget.data_user.Token),
        builder: (BuildContext context, AsyncSnapshot<List<Moneda>> snapshot) {
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
    ));
  }

  Widget _buildListView(List<Moneda> monedaCoin) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          Moneda profile = monedaCoin[index];
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: GestureDetector(
              onTap: () {
                moneda = new Moneda(
                    idMoneda: monedaCoin[index].idMoneda,
                    nombre: monedaCoin[index].nombre,
                    codigo: monedaCoin[index].codigo,
                    identificador: monedaCoin[index].identificador);
                print(moneda.idMoneda.toString() +
                    moneda.nombre +
                    moneda.codigo +
                    moneda.identificador);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Editar_Moneda(widget.data_user, moneda)));
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
        itemCount: monedaCoin.length,
      ),
    );
  }

  
}
