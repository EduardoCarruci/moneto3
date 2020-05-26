import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moneto2/models/tercero.dart';
import 'package:moneto2/models/user.dart';
import 'package:moneto2/screens/screensHome/tercero/create.dart';
import 'package:moneto2/screens/screensHome/tercero/edit.dart';
import 'package:moneto2/screens/screensHome/tercero/servicio.dart';
import 'package:moneto2/utils/Const.dart';

class ListTercero extends StatefulWidget {
  User user;
  ListTercero(this.user);

  @override
  _ListState createState() => new _ListState();
}

class _ListState extends State<ListTercero> with WidgetsBindingObserver {
  ServicioTercero servicio = new ServicioTercero();

  Tercero item;

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
          "Listado de Terceros",
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
                      builder: (context) => CreateTerceros(widget.user)));
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: servicio.getAll(widget.user.Token),
        builder: (BuildContext context, AsyncSnapshot<List<Tercero>> snapshot) {
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

  Widget _buildListView(List<Tercero> list) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          Tercero profile = list[index];
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: GestureDetector(
              onTap: () {
                item = new Tercero(
                  idTercero:                 list[index].idTercero,
                  nombre:                    list[index].nombre,
                  apellido:                 list[index].apellido,
                  establecimiento:          list[index].establecimiento,
                  idTipoIdentificacion:     list[index].idTipoIdentificacion,
                  nroIdentificacion:            list[index].nroIdentificacion,
                  mail:                       list[index].mail,
                  telefono:                 list[index].telefono,
                  fechaNacimiento:        list[index].fechaNacimiento,
                  hijos:                    list[index].hijos,
                  direccion:              list[index].direccion,
                  idGenero:               list[index].idGenero,
                  idTipoCliente:            list[index].idTipoCliente,
                  TipoCliente:              list[index].TipoCliente,
                  idEstrato:                  list[index].idEstrato,
                  idEstadoCivil:        list[index].idEstadoCivil,
                  ubicacionGps:         list[index].ubicacionGps,

                  //id: list[index].id,
                );

print(item.idTercero );         
print(item.nombre              ); 
print(item.apellido            ); 
print(item.establecimiento     ); 
print(item.idTipoIdentificacion); 
print(item.nroIdentificacion  ); 
print(item.mail                ); 
print(item.telefono            ); 
print(item.fechaNacimiento     ); 
print(item.hijos              ); 
print(item.direccion           ); 
print(item.idGenero            ); 
print(item.idTipoCliente       ); 
print(item.TipoCliente        ); 
print(item.idEstrato         ); 
print(item.idEstadoCivil     );   
print(item.ubicacionGps     );   


               

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            EditTercero(widget.user, item))); 
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
