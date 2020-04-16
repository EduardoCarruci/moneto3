import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moneto2/models/user.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/vistas/parametizacion.dart';
import 'package:moneto2/widgets/drawer.dart';

class Home extends StatefulWidget {
  User data_user;
  Home(this.data_user);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>with WidgetsBindingObserver {
  List<String> _Titulo_boton = [
    "Ingresos",
    "Egresos",
    "Presupuesto",
    "Cronograma",
    "Alarmas",
    "Parametrización",
    "Herramientas Colaborativas",
    "Terceros"
  ];
  List<IconData> _Iconos = [
    Icons.card_travel,
    Icons.people,
    Icons.grid_on,
    Icons.grid_on,
    Icons.timer,
    Icons.settings,
    Icons.contact_mail,
    Icons.people
  ];

  @override
  void initState() {
 
    super.initState();
     WidgetsBinding.instance.addObserver(this);
    
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
      /* Navigator.push(
          context, MaterialPageRoute(builder: (context) => List_cronograma())); */
    } else if (pos == 4) {
      /*Navigator.push(
          context, MaterialPageRoute(builder: (context) => List_alarma()));*/
    } else if (pos == 5) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Parametizacion(widget.data_user)));
    } else if (pos == 6) {
    } else if (pos == 7) {
      /*  Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => List_Terceros(widget.data_user)));*/
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          /*IconButton(
                    icon: Icon(Icons.settings),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Configuracion()));
                    },
                  ),*/
        ],
      ),
      drawer: Drawer_admin(context),
      body: Container(
        color: Colors.transparent,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: GridView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          crossAxisCount:
              MediaQuery.of(context).orientation == Orientation.portrait
                  ? 2
                  : 4,
          childAspectRatio: 1.3,
          // Generate 100 widgets that display their index in the List.
          children: List.generate(_Titulo_boton.length, (index) {
            return Column(
              children: <Widget>[
                Expanded(
                    child: GestureDetector(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 35.0,
                              child: new Icon(
                                _Iconos[index],
                                color: Colors.white,
                              ),
                              foregroundColor: Constants.Gra1,
                              // Color.fromRGBO(172, 44, 58, 1),
                              backgroundColor: Constants.Gra1,
                              // Color.fromRGBO(172, 44, 58, 1),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Text(
                                _Titulo_boton[index],
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    _Rutas(index);
                  },
                )),
              ],
              mainAxisSize: MainAxisSize.max,
            );
          }),
        ),
      ),
    );
  }
}
