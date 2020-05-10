
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moneto2/models/estadocivil.dart';
import 'package:moneto2/models/user.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/vistas/parametrizacion/estadocivil/createstatusCivil.dart';
import 'package:moneto2/vistas/parametrizacion/estadocivil/editEstadoCivil.dart';
import 'package:moneto2/vistas/parametrizacion/estadocivil/servicio.dart';

class ListEstadoCivil extends StatefulWidget {
  User user;
  ListEstadoCivil(this.user);

  @override
  _ListState createState() => new _ListState();
}

class _ListState extends State<ListEstadoCivil>
    with WidgetsBindingObserver {
  ServicioEstadoCivil servicio = new ServicioEstadoCivil();
  EstadoCivil item;

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
          "Estado Civil",
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
                      builder: (context) => CreateEstadoCivil(widget.user)));
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: servicio.getAll(widget.user.Token),
        builder:
            (BuildContext context, AsyncSnapshot<List<EstadoCivil>> snapshot) {
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

  Widget _buildListView(List<EstadoCivil> list) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          EstadoCivil profile = list[index];
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: GestureDetector(
              onTap: () {
               item = new EstadoCivil(
                  idEstadoCivil: list[index].idEstadoCivil,
                  nombre: list[index].nombre,
                  codigo: list[index].codigo,
                  //id: list[index].id,
                );
               Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Editar_Estado_civil(widget.user, item)));  
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
