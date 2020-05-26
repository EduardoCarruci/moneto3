import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moneto2/models/user.dart';
import 'package:moneto2/screens/screensHome/cronograma/listCronograma.dart';
import 'package:moneto2/screens/screensHome/tercero/list.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/vistas/principales/login.dart';
import 'package:moneto2/vistas/principales/parametizacion.dart';
import 'package:moneto2/widgets/drawer.dart';

class Home extends StatefulWidget {
  User item;
  Home(this.item);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  List<bool> banderas = new List<bool>();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    for (var i = 0; i < widget.item.permisos.length; i++) {
      if (widget.item.permisos[i].idhabilitado == 1) {
        banderas.add(true);
      } else {
        banderas.add(false);
      }
    }
    setState(() {});

    /*  for (var i = 0; i < banderas.length; i++) {
      print(banderas[0]);
    } */
    super.initState();
  }

  _Rutas(int pos) {
    if (pos == 0) {
      /*Navigator.push(
          context, MaterialPageRoute(builder: (context) => Ingreso()));*/
    } else if (pos == 1) {
      /*Navigator.push(
          context, MaterialPageRoute(builder: (context) => List_Egreso()));*/
    } else if (pos == 2) {
      /* Navigator.push(
          context, MaterialPageRoute(builder: (context) => Operaciones()));*/
    } else if (pos == 3) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ListCronograma(widget.item)));
    } else if (pos == 4) {
      /*Navigator.push(
          context, MaterialPageRoute(builder: (context) => List_alarma()));*/
    } else if (pos == 5) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Parametizacion(widget.item)));
    } else if (pos == 6) {
    } else if (pos == 7) {
      /*  Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => List_Terceros(widget.data_user)));*/
    }
  }

  Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Seguro que quieres salir?'),
            //content: Text('Selecciona tu opción'),
            actions: <Widget>[
              Container(
                //color: Colors.red,
                child: Image(
                  fit: BoxFit.contain,
                  image: AssetImage("assets/emojicry.png"),
                  height: 100,
                  width: 100,
                ),
              ),
              FlatButton(
                child: Text(
                  'No',
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: Text(
                  'Sí',
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                  //Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Constants.darkPrimary,
            title: Text(
              "moneto",
              style: TextStyle(fontSize: 36),
            ),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          drawer: Drawer_admin(context),
          body: SingleChildScrollView(
            child: Container(
                color: Colors.transparent,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    RowsButtons("Ingresos", Icons.card_travel, banderas[0],
                        "Egresos", Icons.people, banderas[1]),
                    RowsButtons("Presupuesto", Icons.grid_on, banderas[2],
                        "Cronograma", Icons.grid_on, banderas[3]),
                    RowsButtons("Alarmas", Icons.timer, banderas[4],
                        "Parametrización", Icons.settings, banderas[5]),
                    RowsButtons(
                        "Herramientas Colaborativas",
                        Icons.contact_mail,
                        banderas[6],
                        "Terceros",
                        Icons.people,
                        banderas[7]),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  Widget RowsButtons(String texto, Icons, bool bandera, String textbutton2,
      Icons2, bool pivote) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Visibility(
            visible: bandera,
            child: GestureDetector(
              onTap: () {
                rutas(texto);
              },
              child: Container(
                //color: Colors.blue,
                height: 100.0,
                width: 100.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 35.0,
                      child: new Icon(
                        Icons,
                        color: Colors.white,
                      ),
                      foregroundColor: Constants.Gra1,
                      // Color.fromRGBO(172, 44, 58, 1),
                      backgroundColor: Constants.Gra1,
                      // Color.fromRGBO(172, 44, 58, 1),
                    ),
                    Text(
                      texto,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: pivote,
            child: GestureDetector(
              onTap: () {
                rutas(textbutton2);
              },
              child: Container(
                height: 100.0,
                width: 100.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 35.0,
                      child: new Icon(
                        Icons2,
                        color: Colors.white,
                      ),
                      foregroundColor: Constants.Gra1,
                      // Color.fromRGBO(172, 44, 58, 1),
                      backgroundColor: Constants.Gra1,
                      // Color.fromRGBO(172, 44, 58, 1),
                    ),
                    Text(
                      textbutton2,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void rutas(String texto) {
    switch (texto) {
      case "Ingresos":
        break;
      case "Egresos":
        break;
      case "Presupuesto":
        break;
      case "Cronograma":
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ListCronograma(widget.item)));
        break;
      case "Alarmas":
        break;
      case "Parametrización":
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Parametizacion(widget.item)));
        break;
      case "Herramientas Colaborativas":
        break;
      case "Terceros":
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ListTercero(widget.item)));
        break;
      default:
        break;
    }
  }
}
