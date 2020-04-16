import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moneto2/models/user.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/vistas/moneda/listmonedas.dart';

class Parametizacion extends StatefulWidget {
  User data_user;
  Parametizacion(this.data_user);
  @override
  ParametizacionState createState() => new ParametizacionState();
}

class ParametizacionState extends State<Parametizacion>
    with WidgetsBindingObserver {
  var promocion_prin;
  var promocion_prin_titulo;
  bool carga = false;

  double part1 = 0.4;
  double part2 = 0.45;
  double _progreso = 0.0;
  PageController controller = PageController();
  var currentPageValue = 0.0;

  List<String> _Titulo_boton = [
    "Moneda",
    "Periodicidad",
    "Medio de pago",
    "Categoría",
    "Geografía",
    "Tipo de Identificación",
    "Tipo cliente",
    "Cuentas contables",
    "Franquicia",
    "Categoría Calendario",
    "Tipo Alarma",
    "Idioma",
    "Colores",
    "Metadata",
    "Genero",
    "Estrato",
    "Estado Civil",
    "Acceso Seguridad",
  ];
  List<IconData> _Iconos = [
    Icons.monetization_on,
    Icons.people,
    Icons.grid_on,
    Icons.grid_on,
    Icons.timer,
    Icons.settings,
    Icons.contact_mail,
    Icons.people,
    Icons.card_travel,
    Icons.people,
    Icons.grid_on,
    Icons.grid_on,
    Icons.timer,
    Icons.settings,
    Icons.contact_mail,
    Icons.people,
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
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ListMoneda(widget.data_user)));
    }else{
      print("otra opcion");
    }

    /*    if (pos == 0) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => List_Moneda(widget.data_user)));
    } else if (pos == 1) {  Navigator.push(context, MaterialPageRoute(builder: (context) => List_periodicidad(widget.data_user)));}
    else if (pos == 2) {  Navigator.push(context, MaterialPageRoute(builder: (context) => List_Medio_de_pago(widget.data_user)));}
    else if (pos == 3) { Navigator.push(context, MaterialPageRoute(builder: (context) => List_categoria(widget.data_user)));                  }
    else if (pos == 4) {}
    else if (pos == 5) {  Navigator.push(context, MaterialPageRoute(builder: (context) => List_T_identificacion(widget.data_user)));                 }
    else if (pos == 6) { Navigator.push(context, MaterialPageRoute(builder: (context) => List_Tipo_cliente(widget.data_user))); }
    else if (pos == 8) { Navigator.push(context, MaterialPageRoute(builder: (context) => List_Franquicia(widget.data_user)));}
    else if (pos == 9) { Navigator.push(context, MaterialPageRoute(builder: (context) => List_categoria_calendario(widget.data_user)));}
    else if (pos == 10) { Navigator.push(context, MaterialPageRoute(builder: (context) => List_Tipo_alarma(widget.data_user)));}
    else if (pos == 14) { Navigator.push(context, MaterialPageRoute(builder: (context) => List_Genero(widget.data_user)));}
    else if (pos == 16) { Navigator.push(context, MaterialPageRoute(builder: (context) => List_Estado_Civil(widget.data_user)));}
    else if (pos == 7) { Navigator.push(context, MaterialPageRoute(builder: (context) => List_Cuentas_Contables(widget.data_user)));}
    else if (pos == 7) { Navigator.push(context, MaterialPageRoute(builder: (context) => Crear_Contable()));} */
  }

  Future<void> _Dialo_finalizar_examen(
    String msn,
    String pre,
    String cali,
  ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text(
              msn,
              textAlign: TextAlign.center,
            ),
          ),
          content: Container(
            height: MediaQuery.of(context).size.height / 6,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Expanded(child: Text("Preguntas")),
                      Expanded(child: Text(pre)),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Expanded(child: Text("Calificación")),
                      Expanded(child: Text(cali)),
                    ],
                  ),
                ),
              ],
            ),
            padding: EdgeInsets.only(top: 10),
          ),
        );
      },
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print("Current state = $state");

    switch (state.index) {
      case 0: // resumed

        break;
      case 1: // inactive

        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Constants.darkPrimary,
        title: Text(
          "Parametrización",
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.transparent,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: GridView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          crossAxisCount:
              MediaQuery.of(context).orientation == Orientation.portrait
                  ? 3
                  : 4,
          childAspectRatio: 0.9,
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
