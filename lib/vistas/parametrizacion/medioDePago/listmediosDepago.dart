import 'package:flutter/material.dart';
import 'package:moneto2/models/medioDePago.dart';
import 'package:moneto2/models/user.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/vistas/parametrizacion/medioDePago/editMedioDePago.dart';
import 'package:moneto2/vistas/parametrizacion/medioDePago/servicio.dart';
import 'createMedioDePago.dart';
import 'package:moneto2/vistas/principales/parametizacion.dart';
class ListMedioDePago extends StatefulWidget {
  User user;
  ListMedioDePago(this.user);

  @override
  _ListMedioDePagoState createState() => _ListMedioDePagoState();
}

class _ListMedioDePagoState extends State<ListMedioDePago>
    with WidgetsBindingObserver {
  ServicioMedioDePago apiService = new ServicioMedioDePago();
  MedioDePago item;

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
       onWillPop: () async => false,
          child: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.darkPrimary,
          title: Text(
            "Medio de Pago",
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
                        builder: (context) => CrearMedioDePago(widget.user)));
              },
            ),
          ],
        ),
        body: FutureBuilder(
          future: apiService.getAll(widget.user.Token),
          builder:
              (BuildContext context, AsyncSnapshot<List<MedioDePago>> snapshot) {
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

  Widget _buildListView(List<MedioDePago> list) {
   
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          MedioDePago profile = list[index];
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: GestureDetector(
              onTap: () {
                 item = new MedioDePago(
                    idTipoMedioPago: list[index].idTipoMedioPago,
                     descripcion: list[index].descripcion,
                    
                    );
              
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            EditMedioDePago(widget.user, item)));
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
