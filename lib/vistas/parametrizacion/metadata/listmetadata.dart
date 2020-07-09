import 'package:flutter/material.dart';
import 'package:moneto2/models/metadata.dart';
import 'package:moneto2/models/user.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/vistas/parametrizacion/metadata/createmetadata.dart';
import 'package:moneto2/vistas/parametrizacion/metadata/editmetadata.dart';
import 'package:moneto2/vistas/parametrizacion/metadata/servicio.dart';

class ListMetadata extends StatefulWidget {
  User data_user;
  ListMetadata(this.data_user);

  @override
  _ListIDState createState() => _ListIDState();
}

class _ListIDState extends State<ListMetadata> with WidgetsBindingObserver {
  ServicioMetadata apiService = new ServicioMetadata();
  Metadata item;

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
          "Metadata",
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
                      builder: (context) => CreateMetadata(widget.data_user))); 
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: apiService.getAll(widget.data_user.Token),
        builder: (BuildContext context,
            AsyncSnapshot<List<Metadata>> snapshot) {
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

  Widget _buildListView(List<Metadata> list) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          Metadata profile = list[index];
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: GestureDetector(
              onTap: () {
              item = new Metadata(
                  idCabeceraMetadata: list[index].idCabeceraMetadata,
                  codigo: list[index].codigo,
                  nombre: list[index].nombre,
                   template: list[index].template,
                   
                );
                 
                Navigator.push(
                    context,
                    
                    MaterialPageRoute(
                        builder: (context) =>
                            EditMetadata(widget.data_user, item))); 
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
